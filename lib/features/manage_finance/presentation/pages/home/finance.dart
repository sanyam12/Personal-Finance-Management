import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance/features/manage_finance/presentation/bloc/allowance/remote/allowance_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/month_allowance.dart';
import '../../../domain/entities/transaction.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  bool isLoading = true;
  bool isAdd = false;
  bool isAllowance = false;
  bool isStack = false;
  List<MonthAllowanceEntity> data = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController newMonthAllowanceController = TextEditingController();
  TextEditingController newMonthNoController = TextEditingController();
  final AllowanceBloc bloc = sl();
  int selectedMonth = 0;
  int selectedIndex = 0;

  @override
  void dispose() {
    amountController.dispose();
    totalAmountController.dispose();
    nameController.dispose();
    newMonthAllowanceController.dispose();
    newMonthNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(
      child: CircularProgressIndicator(),
    );
    if (!isLoading) {
      selectedMonth = data[selectedIndex].monthNo;
      final double progress =
          data[selectedIndex].totalSpent / data[selectedIndex].monthlyAllowance;
      final int youHave =
          data[selectedIndex].monthlyAllowance - data[selectedIndex].totalSpent;
      final today = DateTime.now();
      DateTime firstDayOfMonth =
          DateTime(today.year, data[selectedIndex].monthNo, 1);
      final lastDayOfMonth =
          DateTime(today.year, data[selectedIndex].monthNo + 1, 0);
      final int daysLeft = lastDayOfMonth.day - today.day + 1;
      final double average = youHave / daysLeft;
      String formattedFirstDay =
          DateFormat('MMMM d, y').format(firstDayOfMonth);
      String formattedLastDay = DateFormat('MMMM d, y').format(lastDayOfMonth);
      child = SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _getSelectedMonth(selectedMonth),
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
                  "You Have",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.currency_rupee),
                    Text(
                      "$youHave",
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.north_east),
                    Text(
                        "Spent out of ₹${data[selectedIndex].monthlyAllowance} this month"),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isAllowance ? Colors.white : Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        isAllowance ? Colors.black : Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      isAllowance = !isAllowance;
                    });
                  },
                  child: const Text("Edit total allowance"),
                ),
                if (isAllowance)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: TextField(
                              controller: totalAmountController,
                              decoration: const InputDecoration(
                                labelText: 'Total Amount',
                              ),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                bloc.add(UpdateTotalAllowance(
                                    int.tryParse(totalAmountController.text)!,
                                    data[selectedIndex].monthNo));
                                setState(() {
                                  isLoading = true;
                                });
                              },
                              child: const Text("Submit"))
                        ],
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 9.0, 0, 0),
                  child: Card(
                    shape: _getCardShape(),
                    elevation: 5,
                    color: const Color(0xFFF8FAFF),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 18, 8, 18),
                          child: Icon(Icons.info),
                        ),
                        Expanded(
                          child: Text(
                            "You can spend ₹$average each day for rest of the month",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 350,
                    child: Card(
                      shape: _getCardShape(),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 9.0, 10, 9),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 18,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF4EDDB0)),
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formattedFirstDay),
                                Text("${(progress * 100).toInt()}%"),
                                Text(formattedLastDay),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "Transactions",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            isAdd ? Colors.white : Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            isAdd ? Colors.black : Colors.white)),
                    onPressed: () {
                      setState(() {
                        isAdd = !isAdd;
                      });
                    },
                    child: const Text("Add")),
                if (isAdd)
                  Card(
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Expense Name',
                          ),
                          controller: nameController,
                        ),
                        TextField(
                          controller: amountController,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final entity = TransactionEntity(
                              date: DateTime.now().toString(),
                              name: nameController.text,
                              amount: int.tryParse(amountController.text)!,
                            );
                            bloc.add(
                              AddNewTransaction(
                                data[selectedIndex].monthNo,
                                entity,
                              ),
                            );
                            // bloc.add(GetAllMonths());
                            setState(() {
                              isLoading = true;
                            });
                          },
                          child: const Text("Save Transaction"),
                        )
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data[selectedIndex].transactions.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.payments),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 10, 0, 10),
                                      child: Text(data[selectedIndex]
                                          .transactions[index]
                                          .name),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹${data[selectedIndex].transactions[index].amount}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        bloc.add(DeleteTransaction(
                                            data[selectedIndex]
                                                .transactions[index],
                                            data[selectedIndex].monthNo));
                                        // bloc.add(GetAllMonths());
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            if (isStack)
              Center(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Create new Month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          TextField(
                            controller: newMonthNoController,
                            decoration: const InputDecoration(
                              labelText: 'New Month Number',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          TextField(
                            controller: newMonthAllowanceController,
                            decoration: const InputDecoration(
                              labelText: 'Total Allowance for month',
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          ElevatedButton(
                              onPressed: (){
                                bloc.add(
                                    AddNewMonth(
                                        MonthAllowanceEntity(
                                            transactions: const [],
                                          monthNo: int.tryParse(newMonthNoController.text)!,
                                          totalSpent: 0,
                                          monthlyAllowance: int.tryParse(newMonthAllowanceController.text)!
                                        )
                                    )
                                );
                                setState(() {
                                  isLoading = true;
                                });
                              },
                              child: const Text("Create")
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            bloc.add(GetAllMonths());
            return bloc;
          },
          child: BlocListener<AllowanceBloc, AllowanceState>(
              listener: (context, state) {
                if (state is AllowanceLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
                if (state is AllowanceUpdated) {
                  bloc.add(GetAllMonths());
                }
                if (state is TransactionDeleted) {
                  bloc.add(GetAllMonths());
                }
                if (state is TransactionAdded) {
                  bloc.add(GetAllMonths());
                }
                if (state is AllowanceDataReady) {
                  setState(() {
                    data = state.data;
                    isLoading = false;
                  });
                }
                if (state is AddMonthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Month Added Successfully")));
                  bloc.add(GetAllMonths());
                }
                if (state is AddMonthError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went Wrong ${state.error}")));
                  bloc.add(GetAllMonths());
                }
                if (state is AllowanceDataError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went Wrong ${state.message}")));
                }
              },
              child: child),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              isStack = !isStack;
            });
          },
        child: isStack?const Icon(Icons.close):const Icon(Icons.add),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Personal Finance',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (selectedIndex != 0) {
              setState(() {
                selectedIndex--;
              });
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        IconButton(
          onPressed: () {
            if (selectedIndex != data.length - 1) {
              setState(() {
                selectedIndex++;
              });
            }
          },
          icon: const Icon(Icons.arrow_forward_ios),
        )
      ],
    );
  }

  _getCardShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));
  }

  String _getSelectedMonth(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }
}
