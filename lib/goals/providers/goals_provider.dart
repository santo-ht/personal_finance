import 'package:flutter/material.dart';
import 'package:personal_finance/goals/models/goals_model.dart';
import 'package:personal_finance/utils/db_helper.dart';

class GoalsProvider with ChangeNotifier {
  List<GoalsModel> goalsList = [];

  Future<void> fetchSetGoalsFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    if (dbVal.isNotEmpty) {
      List<GoalsModel> goalsListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        goalsListLocal.add(GoalsModel(
          goalId: dbVal[i]['goal_id'],
          goalName: dbVal[i]['goal_name'],
          currencyName: dbVal[i]['currency_name'],
          currencyShortName: dbVal[i]['currency_short_name'],
          achievedAmount: dbVal[i]['achieved_amount'],
          achievedPercent: dbVal[i]['achieved_percent'],
          targetAmount: dbVal[i]['target_amount'],
          startDate: dbVal[i]['goal_start_date'],
          targetDate: dbVal[i]['goal_target_date'],
        ));
      }
      goalsList = goalsListLocal;
      notifyListeners();
    }
  }

  List<GoalsModel> get fetchGoalsList {
    return [...goalsList];
  }
}
