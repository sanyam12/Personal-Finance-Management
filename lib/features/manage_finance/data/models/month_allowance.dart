import 'package:floor/floor.dart';
import 'package:personal_finance/features/manage_finance/data/models/transaction.dart';
import 'package:personal_finance/features/manage_finance/domain/entities/month_allowance.dart';

@Entity(tableName: 'months', primaryKeys: ['id'])
class MonthAllowanceModel extends MonthAllowanceEntity {
  const MonthAllowanceModel({
    final int? id,
    int? monthlyAllowance,
    int? totalSpent,
    int? monthNo,
    List<TransactionModel>? transactions,
  });

  factory MonthAllowanceModel.fromJson(Map<String, dynamic> map){
    return MonthAllowanceModel(
      monthlyAllowance: map['monthlyAllowance']??0,
      totalSpent: map['totalSpent']??0,
      monthNo: map['monthNo']??0,
      transactions: map['transactions']?? <TransactionModel>[],
    );
  }
}