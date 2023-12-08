class IncomeModel {
  int incomeId;
//  int incomeTypeId;
  double incomeAmount;
  String incomeDate;
  String? incomeNotes;
  int currencyId;
  String incomeName;
  String currencyName;
  String incomeTypeName;
  String accountName;
  int accountId;

  IncomeModel({
    required this.incomeId,
    // required this.incomeTypeId,
    required this.incomeAmount,
    required this.incomeDate,
    this.incomeNotes,
    required this.currencyId,
    required this.incomeName,
    required this.incomeTypeName,
    required this.currencyName,
    required this.accountId,
    required this.accountName,
  });
}
