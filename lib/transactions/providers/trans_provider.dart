import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/trans_model.dart';

class TransProvider with ChangeNotifier {
  List<TransModel> transList = [];
  List<TransModel> transQueryList = [];

  List<double> allTrans = [];

  Future<void> fetchSetTransFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    transList.clear();
    if (dbVal.isNotEmpty) {
      List<TransModel> transListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        transListLocal.add(TransModel(
          transName: dbVal[i]['trans_name'],
          transId: dbVal[i]['trans_id'],
          transTypeId: dbVal[i]['trans_type_id'],
          transAmount: dbVal[i]['balance_amount'],
          transDate: dbVal[i]['trans_date'],
          transNotes: dbVal[i]['trans_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: '',
          transTypeName: '',
          accountId: dbVal[i]['account_id'],
          accountName: '',
        ));
      }
      transList = transListLocal;
      notifyListeners();
    }
  }

  List<TransModel> get fetchtransList {
    return [...transList];
  }

  Future<void> fetchSetTransQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    transQueryList.clear();
    if (dbVal.isNotEmpty) {
      List<TransModel> transQueryListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        transQueryListLocal.add(TransModel(
          transName: dbVal[i]['account_trans_desc'],
          transId: dbVal[i]['account_trans_id'],
          transTypeId: dbVal[i]['account_trans_type_id'],
          transAmount: dbVal[i]['account_trans_amount'],
          transDate: dbVal[i]['account_trans_date'],
          transNotes: dbVal[i]['account_trans_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: dbVal[i]['currency_name'],
          transTypeName: dbVal[i]['account_trans_type_name'],
          accountId: dbVal[i]['account_id'],
          accountName: dbVal[i]['account_name'],
        ));
      }
      transQueryList = transQueryListLocal;
      notifyListeners();
    }
  }

  List<TransModel> get fetchTransQueryList {
    return [...transQueryList];
  }

  Future<void> fetchSetAllTransQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    allTrans.clear();
    if (dbVal.isNotEmpty) {
      for (int i = 0; i < dbVal.length; i++) {
        if (dbVal[i]['balance_amount'] == null) {
          allTrans.add(0);
        } else {
          allTrans.add(dbVal[i]['balance_amount']);
        }
      }

      notifyListeners();
    }
  }

  List<double> get fetchAllTransQuery {
    return [...allTrans];
  }
}
