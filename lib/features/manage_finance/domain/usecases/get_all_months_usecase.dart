import 'package:personal_finance/core/usecase/usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetAllMonthsUseCase implements UseCase<DataState<List<MonthAllowanceEntity>>, void, void>{
  final MonthAllowanceRepository _monthAllowanceRepository;
  const GetAllMonthsUseCase(this._monthAllowanceRepository);

  @override
  Future<DataState<List<MonthAllowanceEntity>>> call({void params1, void params2})async {
    return await _monthAllowanceRepository.getAllMonths();
  }


}