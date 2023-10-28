import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable{
  final String? date;
  final int? amount;
  final String? name;

  const TransactionEntity({
    this.date,
    this.amount,
    this.name
  });

  @override
  List<Object?> get props => [date, amount, name];
}