import 'dart:async';
import 'dart:developer' as logger;
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:personal_finance/core/resources/data_state.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';

import '../../../../domain/entities/month_allowance.dart';
import '../../../../domain/usecases/add_month_allowance.dart';
import '../../../../domain/usecases/add_new_transaction_usecase.dart';
import '../../../../domain/usecases/get_all_months_usecase.dart';
import '../../../../domain/usecases/remove_from_transaction_list_usecase.dart';
import '../../../../domain/usecases/update_total_allowance_usecase.dart';

part 'allowance_event.dart';

part 'allowance_state.dart';

class AllowanceBloc extends Bloc<AllowanceEvent, AllowanceState> {
  final AddMonthAllowanceUseCase _addMonthAllowanceUseCase;
  final GetAllMonthsUseCase _getAllMonthsUseCase;
  final AddNewTransactionUseCase _addNewTransactionUseCase;
  final RemoveFromTransactionListUseCase _removeFromTransactionListUseCase;
  final UpdateTotalAllowanceUseCase _updateTotalAllowanceUseCase;

  AllowanceBloc(
    this._addMonthAllowanceUseCase,
    this._getAllMonthsUseCase,
    this._addNewTransactionUseCase,
    this._removeFromTransactionListUseCase,
    this._updateTotalAllowanceUseCase,
  ) : super(AllowanceLoading()) {
    on<AddNewMonth>(onAddNewMonth);
    on<GetAllMonths>(onGetAllMonths);
    on<AddNewTransaction>(onAddNewTransaction);
    on<DeleteTransaction>(onDeleteTransaction);
    on<UpdateTotalAllowance>(onUpdateTotalAllowance);
  }

  void onAddNewMonth(AddNewMonth event, Emitter<AllowanceState> emit) async {
    try {
      bool check = await _addMonthAllowanceUseCase.call(params1: event.entity);
      if (check) {
        emit(AddMonthSuccess());
      } else {
        emit(AddMonthError("Something Went Wrong"));
      }
    } catch (e) {
      logger.log("catching");
      emit(AddMonthError(e.toString()));
    }
  }

  void onGetAllMonths(GetAllMonths event, Emitter<AllowanceState> emit) async {
    final data = await _getAllMonthsUseCase.call();
    if (data is DataSuccess && data.data != null) {
      logger.log("message");
      emit(AllowanceDataReady(data.data!));
    } else if (data is DataFailed) {
      logger.log(data.error.toString());
      emit(AllowanceDataError(data.error.toString()));
    }
  }

  void onAddNewTransaction(
      AddNewTransaction event, Emitter<AllowanceState> emit) async {
    await _addNewTransactionUseCase.call(
        params1: event.monthNo, params2: event.entity);
    emit(TransactionAdded());
  }

  void onDeleteTransaction(
      DeleteTransaction event, Emitter<AllowanceState> emit) async {
    await _removeFromTransactionListUseCase.call(
        params1: event.month, params2: event.entity);
    emit(TransactionDeleted());
  }

  void onUpdateTotalAllowance(
      UpdateTotalAllowance event, Emitter<AllowanceState> emit) async {
    await _updateTotalAllowanceUseCase.call(
      params1: event.month,
      params2: event.allowance,
    );
    emit(AllowanceUpdated());
  }
}
