import 'package:equatable/equatable.dart';

import 'transaction.dart';

class MonthAllowanceEntity extends Equatable{
  final int? monthlyAllowance;
  final int? totalSpent;
  final int? monthNo;
  final List<TransactionEntity>? transactions;

  const MonthAllowanceEntity({
    this.monthlyAllowance,
    this.totalSpent,
    this.monthNo,
    this.transactions
  });

  @override
  List<Object?> get props => [monthlyAllowance, totalSpent, monthNo, transactions];
}