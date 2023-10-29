import 'package:personal_finance/core/usecase/usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

class RemoveFromTransactionListUseCase implements UseCase<void, int, TransactionEntity>{

  final MonthAllowanceRepository _monthAllowanceRepository;
  const RemoveFromTransactionListUseCase(this._monthAllowanceRepository);

  @override
  Future<void> call({int? params1, TransactionEntity? params2}) async{
    await _monthAllowanceRepository.removeFromTransactionsList(params1!, params2!);
  }

}