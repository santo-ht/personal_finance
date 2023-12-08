import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/goal_deposits_model.dart';

class GoalDepositsProvider with ChangeNotifier {
  List<GoalDepositsModel> goalDepositsList = [];
  List<GoalDepositsModel> goalIdDepositsList = [];

  Future<void> fetchSetGoalDepositsFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    goalDepositsList.clear();
    if (dbVal.isNotEmpty) {
      List<GoalDepositsModel> goalDepositsListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        goalDepositsListLocal.add(GoalDepositsModel(
          goalId: dbVal[i]['goal_id'],
          goalDepositId: dbVal[i]['goal_deposit_id'],
          depositAmount: dbVal[i]['deposit_amount'],
          depositDate: dbVal[i]['deposit_date'],
          depositNotes: dbVal[i]['deposit_notes'],
          status: dbVal[i]['deposit_status'],
        ));
      }
      goalDepositsList = goalDepositsListLocal;
      notifyListeners();
    }
  }

  List<GoalDepositsModel> get fetchGoalDepositsList {
    return [...goalDepositsList];
  }

  Future<void> fetchSetGoalIdDepositsFromDb(String query, params) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDBRawQueryParam(query, params);
    goalIdDepositsList.clear();
    if (dbVal.isNotEmpty) {
      List<GoalDepositsModel> goalIdDepositsListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        goalIdDepositsListLocal.add(GoalDepositsModel(
          goalId: dbVal[i]['goal_id'],
          goalDepositId: dbVal[i]['goal_deposit_id'],
          depositAmount: dbVal[i]['deposit_amount'],
          depositDate: dbVal[i]['deposit_date'],
          depositNotes: dbVal[i]['deposit_notes'],
          status: dbVal[i]['deposit_status'],
        ));
      }
      goalIdDepositsList = goalIdDepositsListLocal;
      notifyListeners();
    }
  }

  List<GoalDepositsModel> get fetchGoalIdDepositsList {
    return [...goalIdDepositsList];
  }
}
