import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/accounts_model.dart';

class AccountsProvider with ChangeNotifier {
  List<AccountsModel> accountsList = [];
  List<AccountsModel> accountsQueryList = [];

  Future<void> fetchSetAccountsFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    accountsList.clear();
    if (dbVal.isNotEmpty) {
      List<AccountsModel> accountsListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        accountsListLocal.add(AccountsModel(
          accountName: dbVal[i]['account_name'],
          accountId: dbVal[i]['account_id'],
          accountTypeId: dbVal[i]['account_type_id'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: '',
          accountTypeName: '',
          balanceAmount: dbVal[i]['balance_amount'],
        ));
      }
      accountsList = accountsListLocal;
      notifyListeners();
    }
  }

  List<AccountsModel> get fetchAccountsList {
    return [...accountsList];
  }

  Future<void> fetchSetAccountsQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    accountsQueryList.clear();
    if (dbVal.isNotEmpty) {
      List<AccountsModel> accountsQueryListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        accountsQueryListLocal.add(AccountsModel(
          accountName: dbVal[i]['account_name'],
          accountId: dbVal[i]['account_id'],
          accountTypeId: dbVal[i]['account_type_id'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: dbVal[i]['currency_name'],
          accountTypeName: dbVal[i]['account_type_name'],
          balanceAmount: dbVal[i]['balance_amount'],
        ));
      }
      accountsQueryList = accountsQueryListLocal;
      notifyListeners();
    }
  }

  List<AccountsModel> get fetchAccountsQueryList {
    return [...accountsQueryList];
  }
}
