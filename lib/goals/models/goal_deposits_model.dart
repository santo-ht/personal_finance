class GoalDepositsModel {
  int goalDepositId;
  int goalId;
  double depositAmount;
  String depositDate;
  String depositNotes;
  int status;

  GoalDepositsModel({
    required this.goalId,
    required this.goalDepositId,
    required this.depositAmount,
    required this.depositDate,
    required this.depositNotes,
    required this.status,
  });
}
