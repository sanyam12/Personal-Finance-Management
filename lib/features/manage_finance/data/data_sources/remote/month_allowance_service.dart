import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/entities/transaction.dart';
import '../../models/month_allowance.dart';
import '../../models/transaction.dart';

class MonthAllowanceService{

  Future<bool> addNewMonth(MonthAllowanceModel monthAllowanceModel)async{
    try {
      if(monthAllowanceModel.monthNo<=0 || monthAllowanceModel.monthNo>=13){
        return false;
      }
      // throw Exception("testing error");
      var auth = FirebaseAuth.instance;
      var db = FirebaseFirestore.instance;
      var uid = auth.currentUser!.uid;

      log(monthAllowanceModel.monthNo.toString());

      await db.collection(uid).doc(monthAllowanceModel.monthNo.toString())
          .set(monthAllowanceModel.toJson());
      // log("blablabla");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<DataState<List<MonthAllowanceModel>>> getAllMonths()async{
    try{
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final data = await FirebaseFirestore.instance.collection(uid).get();
      final List<MonthAllowanceModel> list = [];
      for(var i in data.docs){
        list.add(MonthAllowanceModel.fromJson(i.data()));
      }
      list.sort((a, b) =>
        a.monthNo.compareTo(b.monthNo)
      );
      return DataSuccess(list);
    }catch(e){
      return DataFailed(Exception(e));
    }
  }

  Future<void> addToTransactionsList(int month, TransactionModel transactionEntity)async{
    try {
      final uid=FirebaseAuth.instance.currentUser!.uid;
      final db = FirebaseFirestore.instance.collection(uid)
          .doc(month.toString());
      final doc = await db.get();
      final data = doc.data()!;
      final check = (data["transactions"] as List<dynamic>).map((e) => TransactionModel.fromJson(e)).toList();
      check.add(transactionEntity);
      data['transactions'] = check.map((e) => e.toJson()).toList();
      await db.set(data);
      int answer = 0;
      for(var i in check){
        answer+=i.amount;
      }
      updateTotalSpent(month, answer);
    } catch (e) {
      log(e.toString());
    }

  }

  Future<void> setMonthlyAllowance(int month, int allowance)async{
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection(uid)
              .doc(month.toString()).update({
            'monthlyAllowance':allowance
          });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateTotalSpent(int month, int amount)async{
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection(uid)
          .doc(month.toString()).update({
        'totalSpent':amount
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeFromTransactionsList(int month, TransactionModel transactionEntity) async{
    try {
      final uid=FirebaseAuth.instance.currentUser!.uid;
      final db = FirebaseFirestore.instance.collection(uid)
          .doc(month.toString());
      final doc = await db.get();
      final data = doc.data()!;
      final check = (data["transactions"] as List<dynamic>).map((e) => TransactionModel.fromJson(e)).toList();
      check.remove(transactionEntity);
      data['transactions'] = check.map((e) => e.toJson()).toList();
      await db.set(data);
      int answer = 0;
      for(var i in check){
        answer+=i.amount;
      }
      updateTotalSpent(month, answer);
    } catch (e) {
      log(e.toString());
    }
  }
}