import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/expenses_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<ExpensesModel> expensesList = [];
  List<ExpensesModel> expensesQueryList = [];

  List<double> allExpenses = [];

  Future<void> fetchSetExpensesFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    expensesList.clear();
    if (dbVal.isNotEmpty) {
      List<ExpensesModel> expensesListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        expensesListLocal.add(ExpensesModel(
          expenseName: dbVal[i]['expense_name'],
          expenseId: dbVal[i]['expense_id'],
          expenseTypeId: dbVal[i]['expense_type_id'],
          expenseAmount: dbVal[i]['expense_amount'],
          expenseDate: dbVal[i]['expense_date'],
          expenseNotes: dbVal[i]['expense_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: '',
          expenseTypeName: '',
          accountId: dbVal[i]['account_id'],
          accountName: '',
        ));
      }
      expensesList = expensesListLocal;
      notifyListeners();
    }
  }

  List<ExpensesModel> get fetchExpensesList {
    return [...expensesList];
  }

  Future<void> fetchSetExpensesQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    expensesQueryList.clear();
    if (dbVal.isNotEmpty) {
      List<ExpensesModel> expensesQueryListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        expensesQueryListLocal.add(ExpensesModel(
          expenseName: dbVal[i]['expense_name'],
          expenseId: dbVal[i]['expense_id'],
          expenseTypeId: dbVal[i]['expense_type_id'],
          expenseAmount: dbVal[i]['expense_amount'],
          expenseDate: dbVal[i]['expense_date'],
          expenseNotes: dbVal[i]['expense_notes'],
          currencyId: dbVal[i]['currency_id'],
          currencyName: dbVal[i]['currency_name'],
          expenseTypeName: dbVal[i]['expense_type_name'],
          accountId: dbVal[i]['account_id'],
          accountName: dbVal[i]['account_name'],
        ));
      }
      expensesQueryList = expensesQueryListLocal;
      notifyListeners();
    }
  }

  List<ExpensesModel> get fetchExpensesQueryList {
    return [...expensesQueryList];
  }

  Future<void> fetchSetAllExpensesQueryFromDb(String query) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQuery(query);
    allExpenses.clear();
    if (dbVal.isNotEmpty) {
      for (int i = 0; i < dbVal.length; i++) {
        if (dbVal[i]['expense_amount'] == null) {
          allExpenses.add(0);
        } else {
          allExpenses.add(dbVal[i]['expense_amount']);
        }
      }

      notifyListeners();
    }
  }

  List<double> get fetchAllExpensesQuery {
    return [...allExpenses];
  }
}
