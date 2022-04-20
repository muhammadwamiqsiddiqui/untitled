import 'package:flutter/material.dart';
import 'package:untitled/Models/Finance.dart';

class FinanceProvider extends ChangeNotifier{
  List<Finance> _financialRecords = [];

  List<Finance> get allFinancialRecords => _financialRecords;

  void updateFinancialRecords(Finance financialRecord){
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _financialRecords.add(financialRecord);
      notifyListeners();
    });
  }
  void setFinancialRecords(List<Finance> financialRecords)=>
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _financialRecords = financialRecords;

    });
}