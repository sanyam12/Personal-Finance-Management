part of 'allowance_bloc.dart';

@immutable
abstract class AllowanceState extends Equatable{}

class AllowanceLoading extends AllowanceState {
  AllowanceLoading();

  @override
  List<Object?> get props => [];
}

class AllowanceDataReady extends AllowanceState{
  List<MonthAllowanceEntity> data;
  final int random = Random().nextInt(10000);
  AllowanceDataReady(this.data);
  @override
  List<Object?> get props => [data, random];

}

class AllowanceDataError extends AllowanceState{
  final String message;
  AllowanceDataError(this.message);
  @override
  List<Object?> get props => [];

}

class AddMonthSuccess extends AllowanceState{
  @override
  List<Object?> get props => [];
}

class AddMonthError extends AllowanceState {

  final String error;

  AddMonthError(this.error);

  @override
  List<Object?> get props => [error];

}

class TransactionDeleted extends AllowanceState{
  @override
  List<Object?> get props => [Random().nextInt(10000)];

}

class TransactionAdded extends AllowanceState{
  @override
  List<Object?> get props => [Random().nextInt(10000)];
}

class AllowanceUpdated extends AllowanceState {
  @override
  List<Object?> get props => [Random().nextInt(10000)];

}

class NewMonthCreated extends AllowanceState{
  @override
  List<Object?> get props => [Random().nextInt(10000)];
}