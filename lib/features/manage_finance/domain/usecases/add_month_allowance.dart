import 'dart:developer';

import 'package:personal_finance/core/usecase/usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

class AddMonthAllowanceUseCase implements UseCase<bool, MonthAllowanceEntity, void>{
  final MonthAllowanceRepository _monthAllowanceRepository;

  const AddMonthAllowanceUseCase(this._monthAllowanceRepository);

  @override
  Future<bool> call({MonthAllowanceEntity?  params1, void params2}) {
    return _monthAllowanceRepository.addNewMonth(params1!);
  }

}