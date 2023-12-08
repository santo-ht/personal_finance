class ExpensesModel {
  int expenseId;
  int expenseTypeId;
  double expenseAmount;
  String expenseDate;
  String? expenseNotes;
  int currencyId;
  String expenseName;
  String currencyName;
  String expenseTypeName;
  String accountName;
  int accountId;

  ExpensesModel({
    required this.expenseId,
    required this.expenseTypeId,
    required this.expenseAmount,
    required this.expenseDate,
    this.expenseNotes,
    required this.currencyId,
    required this.expenseName,
    required this.expenseTypeName,
    required this.currencyName,
    required this.accountId,
    required this.accountName,
  });
}
