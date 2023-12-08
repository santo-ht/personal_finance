import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/account_trans_type_model.dart';

class AccountTransTypeProvider with ChangeNotifier {
  List<AccountTransTypeModel> accountTransTypeList = [];

  Future<void> fetchSetAccountTransTypesFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    if (dbVal.isNotEmpty) {
      List<AccountTransTypeModel> accountTransTypeListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        accountTransTypeListLocal.add(AccountTransTypeModel(
          accountTransTypeId: dbVal[i]['account_trans_type_id'],
          accountTransTypeName: dbVal[i]['account_trans_type_name'],
        ));
      }
      accountTransTypeList = accountTransTypeListLocal;
      notifyListeners();
    }
  }

  List<AccountTransTypeModel> get fetchAccountTransTypesList {
    return [...accountTransTypeList];
  }
}
