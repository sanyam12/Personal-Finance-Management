import 'package:personal_finance/features/manage_finance/data/models/month_allowance.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';

import '../../../../core/resources/data_state.dart';

abstract class MonthAllowanceRepository {
  Future<DataState<List<MonthAllowanceEntity>>> getAllMonths();

  // Future<DataState<List<TransactionEntity>>> getAllTransactions(int month);

  Future<void> setMonthlyAllowance(int month, int allowance);

  Future<void> addToTransactionsList(
    int month,
    TransactionEntity transactionEntity,
  );

  Future<void> removeFromTransactionsList(
    int month,
    TransactionEntity transactionEntity,
  );

  Future<void> updateTotalSpent(int month, int amount);

  Future<void> addNewMonth(MonthAllowanceModel monthAllowanceModel);

}
