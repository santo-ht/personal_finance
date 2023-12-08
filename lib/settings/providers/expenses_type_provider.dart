import 'package:flutter/material.dart';
import 'package:personal_finance/settings/models/expenses_type_model.dart';
import 'package:personal_finance/utils/db_helper.dart';

class ExpensesTypeProvider with ChangeNotifier {
  List<ExpensesTypeModel> expensesTypeList = [];

  Future<void> fetchSetExpensesTypeFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    if (dbVal.isNotEmpty) {
      List<ExpensesTypeModel> expensesTypeListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        expensesTypeListLocal.add(ExpensesTypeModel(
          expenseTypeId: dbVal[i]['expense_type_id'],
          expenseTypeName: dbVal[i]['expense_type_name'],
          iconName: dbVal[i]['expense_type_icon'],
          expenseTypeDesc: dbVal[i]['expense_type_desc'],
        ));
      }
      expensesTypeList = expensesTypeListLocal;
      notifyListeners();
    }
  }

  List<ExpensesTypeModel> get fetchExpensesTypeList {
    return [...expensesTypeList];
  }
}
