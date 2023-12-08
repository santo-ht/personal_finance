import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/accounts_type_model.dart';

class AccountsTypeProvider with ChangeNotifier {
  List<AccountsTypeModel> accountsTypeList = [];

  Future<void> fetchSetAccountTypesFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    if (dbVal.isNotEmpty) {
      List<AccountsTypeModel> accountsTypeListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        accountsTypeListLocal.add(AccountsTypeModel(
          accountTypeId: dbVal[i]['account_type_id'],
          accountTypeName: dbVal[i]['account_type_name'],
          accountIconName: dbVal[i]['account_type_icon'],
          accountTypeDesc: dbVal[i]['account_type_desc'],
        ));
      }
      accountsTypeList = accountsTypeListLocal;
      notifyListeners();
    }
  }

  List<AccountsTypeModel> get fetchAccountTypesList {
    return [...accountsTypeList];
  }
}
