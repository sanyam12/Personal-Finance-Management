import 'package:personal_finance/core/usecase/usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';

class UpdateTotalAllowanceUseCase implements UseCase<void, int, int>{
  final MonthAllowanceRepository _monthAllowanceRepository;
  UpdateTotalAllowanceUseCase(this._monthAllowanceRepository);

  @override
  Future<void> call({int? params1, int? params2}) async{
    //params1: - month
    //params2: - allowance
    await _monthAllowanceRepository.setMonthlyAllowance(params1!, params2!);
  }

}