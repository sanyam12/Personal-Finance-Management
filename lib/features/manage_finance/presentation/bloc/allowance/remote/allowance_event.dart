part of 'allowance_bloc.dart';

@immutable
abstract class AllowanceEvent extends Equatable{}

class AddNewMonth extends AllowanceEvent{
  final MonthAllowanceEntity entity;
  AddNewMonth(this.entity);

  @override
  List<Object?> get props => [entity];
}

class GetAllMonths extends AllowanceEvent{
  GetAllMonths();

  @override
  List<Object?> get props => [];
}

class AddNewTransaction extends AllowanceEvent{
  final int monthNo;
  final TransactionEntity entity;
  AddNewTransaction(this.monthNo, this.entity);

  @override
  List<Object?> get props => [];
}

class DeleteTransaction extends AllowanceEvent{
  final TransactionEntity entity;
  final int month;
  DeleteTransaction(this.entity, this.month);

  @override
  List<Object?> get props =>[entity, month];
}

class UpdateTotalAllowance extends AllowanceEvent{
  final int allowance;
  final int month;
  UpdateTotalAllowance(this.allowance, this.month);

  @override
  List<Object?> get props => [allowance, month];

}