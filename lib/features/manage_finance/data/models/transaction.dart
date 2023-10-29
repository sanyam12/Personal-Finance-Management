import 'package:personal_finance/features/manage_finance/domain/entities/transaction.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    String date = "",
    int amount = 0,
    String name = "",
  }):super(
    date: date,
    amount: amount,
    name: name
  );

  factory TransactionModel.fromJson(Map<String, dynamic> map){
    return TransactionModel(
      date: map["date"]??"",
      amount: map["amount"]??0,
      name: map["name"]??"",
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'date':date,
      'amount':amount,
      'name':name
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity transactionEntity){
    return TransactionModel(
      date: transactionEntity.date,
      amount: transactionEntity.amount,
      name: transactionEntity.name
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'date':date,
      'amount':amount,
      'name':name
    };
  }
}