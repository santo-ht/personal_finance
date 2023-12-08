class AccountsModel {
  int accountId;
  int accountTypeId;

  int currencyId;
  String accountName;
  String currencyName;
  String accountTypeName;
  double balanceAmount;

  AccountsModel({
    required this.accountId,
    required this.accountTypeId,
    required this.currencyId,
    required this.accountName,
    required this.accountTypeName,
    required this.currencyName,
    required this.balanceAmount,
  });
}
