import 'dart:developer';

import 'package:floor/floor.dart';
import 'package:personal_finance/features/manage_finance/data/models/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';

// @Entity(tableName: 'months', primaryKeys: ['id'])
class MonthAllowanceModel extends MonthAllowanceEntity {
  const MonthAllowanceModel({
    int monthlyAllowance = 0,
    int totalSpent = 0,
    int monthNo = 0,
    List<TransactionModel> transactions = const <TransactionModel>[],
  }):super(
    monthlyAllowance: monthlyAllowance,
    totalSpent: totalSpent,
    monthNo: monthNo,
    transactions: transactions
  );

  factory MonthAllowanceModel.fromJson(Map<String, dynamic> map) {
    return MonthAllowanceModel(
      monthlyAllowance: map['monthlyAllowance'] ?? 0,
      totalSpent: map['totalSpent'] ?? 0,
      monthNo: map['monthNo'] ?? 0,
      transactions: (map['transactions'] as List).map((e) => TransactionModel.fromJson(e)).toList(),
    );
  }

  factory MonthAllowanceModel.fromEntity(
      MonthAllowanceEntity monthAllowanceEntity) {
    log("inside factory ${monthAllowanceEntity.monthNo}");
    return MonthAllowanceModel(
        monthlyAllowance: monthAllowanceEntity.monthlyAllowance,
        totalSpent: monthAllowanceEntity.totalSpent,
        monthNo: monthAllowanceEntity.monthNo,
        transactions: monthAllowanceEntity.transactions.map((e) => TransactionModel.fromEntity(e))
            .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['monthlyAllowance'] = monthlyAllowance;
    map['totalSpent'] = totalSpent;
    map['monthNo'] = monthNo;
    map['transactions'] = transactions
        ?.map(
            (transaction) => TransactionModel.fromEntity(transaction).toJson())
        .toList();

    return map;
  }
}
