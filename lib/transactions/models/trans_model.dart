class TransModel {
  int transId;
  int transTypeId;
  double transAmount;
  String transDate;
  String? transNotes;
  int currencyId;
  String transName;
  String currencyName;
  String transTypeName;
  String accountName;
  int accountId;

  TransModel({
    required this.transId,
    required this.transTypeId,
    required this.transAmount,
    required this.transDate,
    this.transNotes,
    required this.currencyId,
    required this.transName,
    required this.transTypeName,
    required this.currencyName,
    required this.accountId,
    required this.accountName,
  });
}
