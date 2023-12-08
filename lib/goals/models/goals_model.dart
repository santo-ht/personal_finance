class GoalsModel {
  int goalId;
  String goalName;
  String currencyName;
  String currencyShortName;
  double targetAmount;
  double achievedAmount;
  double achievedPercent;
  String startDate;
  String targetDate;

  GoalsModel({
    required this.goalId,
    required this.goalName,
    required this.currencyName,
    required this.currencyShortName,
    required this.achievedAmount,
    required this.achievedPercent,
    required this.targetAmount,
    required this.startDate,
    required this.targetDate,
  });
}
