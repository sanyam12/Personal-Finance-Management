import 'package:equatable/equatable.dart';

import 'transaction.dart';

class MonthAllowanceEntity extends Equatable{
  final int monthlyAllowance;
  final int totalSpent;
  final int monthNo;
  final List<TransactionEntity> transactions;

  const MonthAllowanceEntity({
    this.monthlyAllowance = 0,
    this.totalSpent = 0,
    this.monthNo = 0,
    required this.transactions
  });

  @override
  List<Object?> get props => [monthlyAllowance, totalSpent, monthNo, transactions];

}