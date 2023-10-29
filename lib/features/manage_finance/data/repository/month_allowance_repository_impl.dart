import 'dart:developer';

import 'package:personal_finance/core/resources/data_state.dart';
import 'package:personal_finance/features/manage_finance/data/data_sources/remote/month_allowance_service.dart';
import 'package:personal_finance/features/manage_finance/data/models/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

import '../models/month_allowance.dart';

class MonthAllowanceRepositoryImpl implements MonthAllowanceRepository{
  final MonthAllowanceService _monthAllowanceService;
  const MonthAllowanceRepositoryImpl(this._monthAllowanceService);

  @override
  Future<void> addToTransactionsList(int month, TransactionEntity transactionEntity) async{
    await _monthAllowanceService.addToTransactionsList(month, TransactionModel.fromEntity(transactionEntity));
  }

  @override
  Future<DataState<List<MonthAllowanceModel>>> getAllMonths() async{
    return await _monthAllowanceService.getAllMonths();
  }

  @override
  Future<void> removeFromTransactionsList(int month, TransactionEntity transactionEntity) async{
    await _monthAllowanceService.removeFromTransactionsList(month, TransactionModel.fromEntity(transactionEntity));
  }

  @override
  Future<void> setMonthlyAllowance(int month, int allowance)async {
    await _monthAllowanceService.setMonthlyAllowance(month, allowance);
  }

  @override
  Future<void> updateTotalSpent(int month, int amount)async {
    await _monthAllowanceService.updateTotalSpent(month, amount);
  }

  @override
  Future<bool> addNewMonth(MonthAllowanceEntity monthAllowanceEntity) async {
    return await _monthAllowanceService.addNewMonth(MonthAllowanceModel.fromEntity(monthAllowanceEntity));
  }

}