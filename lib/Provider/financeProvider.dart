import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled/Models/Finance.dart';

class FinanceProvider extends ChangeNotifier{
  List<Finance> _financialRecords = [];
  int _totalIncome=0,_totalExpense=0,_savings=0;

  int get totalIncome => _totalIncome;
  int get totalExpense => _totalExpense;
  int get savings => _savings;

  List<Finance> get allFinancialRecords => _financialRecords;

  void updateFinancialRecords(Finance financialRecord){
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _financialRecords.add(financialRecord);
      if(financialRecord.type=="Income"){
        _totalIncome = _totalIncome + financialRecord.amount;
        log("income "+_totalIncome.toString());
      }else{
        _totalExpense = _totalExpense + financialRecord.amount;
      }
      _savings = _totalIncome - _totalExpense;
      notifyListeners();
    });
  }
  void setFinancialRecords(List<Finance> financialRecords)=>
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _financialRecords = financialRecords;

    });
}