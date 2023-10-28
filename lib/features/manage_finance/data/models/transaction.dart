import 'package:floor/floor.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/Transaction.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    String? date,
    int? amount,
    String? name,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> map){
    return TransactionModel(
      date: map["date"]??"",
      amount: map["amount"]??0,
      name: map["name"]??"",
    );
  }
}
