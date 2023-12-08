import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/income_model.dart';

class IncomeProvider with ChangeNotifier {
  List<IncomeModel> incomeList = [];
  List<IncomeModel> incomeQueryList = [];

  List<double> allincome = [];

  Future<void> fetchSetincomeFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    incomeList.clear();
    if (dbVal.isNotEmpty) {
      List<IncomeModel> incomeListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        incomeListLocal.add(IncomeModel(
          incomeName: dbVal[i]['income_name'],
          incomeId: dbVal[i]['income_id'],
          // incomeTypeId: dbVal[i]['income_type_id'],
          incomeAmount: dbVal[i]['balance_amount'],
          incomeDate: dbVal[i]['income_date'],
          incomeNotes: dbVal[i]['income_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: '',
          incomeTypeName: '',
          accountId: dbVal[i]['account_id'],
          accountName: '',
        ));
      }
      incomeList = incomeListLocal;
      notifyListeners();
    }
  }

  List<IncomeModel> get fetchincomeList {
    return [...incomeList];
  }

  Future<void> fetchSetincomeQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    incomeQueryList.clear();
    if (dbVal.isNotEmpty) {
      List<IncomeModel> incomeQueryListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        incomeQueryListLocal.add(IncomeModel(
          incomeName: dbVal[i]['account_trans_desc'],
          incomeId: dbVal[i]['account_trans_id'],
          incomeAmount: dbVal[i]['account_trans_amount'],
          incomeDate: dbVal[i]['account_trans_date'],
          incomeNotes: dbVal[i]['account_trans_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: dbVal[i]['currency_name'],
          incomeTypeName: dbVal[i]['account_trans_type_name'],
          accountId: dbVal[i]['account_id'],
          accountName: dbVal[i]['account_name'],
        ));
      }
      incomeQueryList = incomeQueryListLocal;
      notifyListeners();
    }
  }

  List<IncomeModel> get fetchincomeQueryList {
    return [...incomeQueryList];
  }

  Future<void> fetchSetAllIncomeQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    allincome.clear();
    if (dbVal.isNotEmpty) {
      for (int i = 0; i < dbVal.length; i++) {
        if (dbVal[i]['balance_amount'] == null) {
          allincome.add(0);
        } else {
          allincome.add(dbVal[i]['balance_amount']);
        }
      }

      notifyListeners();
    }
  }

  List<double> get fetchAllIncomeQuery {
    return [...allincome];
  }
}
