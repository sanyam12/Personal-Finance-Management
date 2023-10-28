import 'package:personal_finance/core/resources/data_state.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

import '../models/month_allowance.dart';

class MonthAllowanceRepositoryImpl implements MonthAllowanceRepository{
  @override
  Future<void> addToTransactionsList(int month, TransactionEntity transactionEntity) {
    // TODO: implement addToTransactionsList
    throw UnimplementedError();
  }

  @override
  Future<DataState<List<MonthAllowanceModel>>> getAllMonths() {
    // TODO: implement getAllMonths
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromTransactionsList(int month, TransactionEntity transactionEntity) {
    // TODO: implement removeFromTransactionsList
    throw UnimplementedError();
  }

  @override
  Future<void> setMonthlyAllowance(int month, int allowance) {
    // TODO: implement setMonthlyAllowance
    throw UnimplementedError();
  }

  @override
  Future<void> updateTotalSpent(int month, int amount) {
    // TODO: implement updateTotalSpent
    throw UnimplementedError();
  }

  @override
  Future<void> addNewMonth(MonthAllowanceModel monthAllowanceModel) {
    // TODO: implement addNewMonth
    throw UnimplementedError();
  }

}