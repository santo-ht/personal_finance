class AppConfig {
  // static const whatsappSupport = "https://wa.me/+13054034537";

  /* Config Font Sizes */
  static const title1Size = 28.0;
  static const title2Size = 24.0;
  static const title3Size = 24.0;

  static const body1Size = 16.0;
  static const body2Size = 14.0;

  static const headlineSize = 16.0;

  /* Config Font Sizes */

  /* Config Language Headers */

  static const englishHeader = 0;

  /*  Config Language Headers */

  /* Config Colors */

  static const blueColorHex = '#002E5A';
  static const blueColor = 0xFF002F5D;
  static const blueBorderColor = 0xFF88A0B5;
  static const greenColor = 0xFF2CC78F;
  static const lightGrey = 0xFFD8D8D8;
  static const grey = 0xFFA9A9A9;
  static const appHexColor = "#5669FF";

  /* Config Colors */

  static const String appVersion = '1.0.0';
  static const String appVersionNumber = '1';

  // Images

  static const String maleProfileIcon = "assets/male_icon.png";
  static const String femaleProfileIcon = "assets/female_icon.png";
  static const String membersIcon = "assets/members.png";
  static const String noCommunity = "assets/no_community.png";
  static const String noPosts = "assets/no_posts.png";
  static const String logoImage = "assets/personal_finance.png";

  /* DB Config */

  // Tables
  static const String financeDb = 'finance';
  static const String financeTable = 'finance_master';
  static const String currenciesTable = 'currencies_master';
  static const String goalsTable = "goals_master";
  static const String goalsDepositTable = "goal_deposits";
  static const String expenseTable = 'expense_master';
  static const String accountsTable = 'accounts_master';
  static const String expensesTypeTable = 'expenses_type_master';
  static const String accountsTypeTable = 'accounts_type_master';
  static const String accountTransMaster = 'account_trans_master';
  static const String accountsTransTypeTable = 'accounts_trans_type';
  // Queries

  static const goalDepositsQuery =
      'SELECT * FROM goal_deposits WHERE deposit_status=? and goal_id=?';

  static const goalUpdate =
      'UPDATE goals_master SET achieved_amount=?, achieved_percent=? WHERE goal_id=?';

  static const accountsQuery =
      'SELECT AM.*, ATM.*, CU.* FROM accounts_master AM LEFT JOIN accounts_type_master ATM ON AM.account_type_id=ATM.account_type_id LEFT JOIN currencies_master CU ON CU.currency_id=AM.currency_id';

  static const expensesQuery =
      'SELECT EM.*, ETM.*, CU.*,AM.* FROM expense_master EM LEFT JOIN expenses_type_master ETM ON EM.expense_type_id=ETM.expense_type_id LEFT JOIN currencies_master CU ON CU.currency_id=EM.currency_id LEFT JOIN accounts_master AM ON EM.account_id=AM.account_id';

  static const incomeQuery =
      'SELECT ATM.*, CU.*,AM.*,ATT.* FROM account_trans_master ATM LEFT JOIN currencies_master CU ON CU.currency_id=ATM.currency_id LEFT JOIN accounts_master AM ON ATM.account_id=AM.account_id LEFT JOIN accounts_trans_type ATT ON ATT.account_trans_type_id=ATM.account_trans_type_id WHERE ATM.account_trans_type_id=1';

  static const transQuery =
      'SELECT ATM.*, CU.*,AM.*,ATT.* FROM account_trans_master ATM LEFT JOIN currencies_master CU ON CU.currency_id=ATM.currency_id LEFT JOIN accounts_master AM ON ATM.account_id=AM.account_id LEFT JOIN accounts_trans_type ATT ON ATT.account_trans_type_id=ATM.account_trans_type_id';

  static const allExpensesQuery = 'SELECT expense_amount FROM expense_master';

  static const allExpensesTotalQuery =
      'SELECT sum(expense_amount) AS expense_amount FROM expense_master';

  static const allIncomeTotalQuery =
      'SELECT sum(balance_amount) AS balance_amount FROM accounts_master';

  /* DB Config */
}
