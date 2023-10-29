import 'package:get_it/get_it.dart';
import 'package:personal_finance/features/manage_finance/data/data_sources/remote/login_service.dart';
import 'package:personal_finance/features/manage_finance/data/repository/login_repository_impl.dart';
import 'package:personal_finance/features/manage_finance/data/repository/month_allowance_repository_impl.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/login_repository.dart';
import 'package:personal_finance/features/manage_finance/domain/repository/month_allowance_repository.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/add_new_transaction_usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/get_all_months_usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/login_usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/remove_from_transaction_list_usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/signup_usecase.dart';
import 'package:personal_finance/features/manage_finance/domain/usecases/update_total_allowance_usecase.dart';
import 'package:personal_finance/features/manage_finance/presentation/bloc/signup/remote/signup_bloc.dart';

import 'features/manage_finance/data/data_sources/remote/month_allowance_service.dart';
import 'features/manage_finance/domain/usecases/add_month_allowance.dart';
import 'features/manage_finance/presentation/bloc/allowance/remote/allowance_bloc.dart';
import 'features/manage_finance/presentation/bloc/login/remote/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //services
  sl.registerSingleton<MonthAllowanceService>(MonthAllowanceService());
  sl.registerSingleton<LoginService>(LoginService());

  //repository
  sl.registerSingleton<MonthAllowanceRepository>(
      MonthAllowanceRepositoryImpl(sl()));
  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));

  //UseCase
  sl.registerSingleton<AddMonthAllowanceUseCase>(
      AddMonthAllowanceUseCase(sl()));
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl()));
  sl.registerSingleton<GetAllMonthsUseCase>(GetAllMonthsUseCase(sl()));
  sl.registerSingleton<AddNewTransactionUseCase>(
    AddNewTransactionUseCase(sl()),
  );
  sl.registerSingleton<RemoveFromTransactionListUseCase>(
    RemoveFromTransactionListUseCase(sl()),
  );
  sl.registerSingleton<UpdateTotalAllowanceUseCase>(
      UpdateTotalAllowanceUseCase(sl()));

  //BloC
  sl.registerFactory<AllowanceBloc>(
      () => AllowanceBloc(sl(), sl(), sl(), sl(), sl()));

  sl.registerFactory(() => LoginBloc(sl()));
  sl.registerFactory(() => SignupBloc(sl()));
}
