import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> getDBInstance() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'finance.db'),
      onCreate: (db, version) => _createDbTables(db),
      version: 1,
    );
  }

  static void _createDbTables(Database db) {
    db.execute(
        'CREATE TABLE finance_master(finance_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, finance_name TEXT NOT NULL, finance_desc TEXT NOT NULL,coin_icon TEXT NULL)');
    db.execute(
        'CREATE TABLE expense_master(expense_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,expense_name TEXT NOT NULL, expense_type_id INTEGER NOT NULL,  expense_amount REAL NOT NULL,currency_id INTEGER NOT NULL,account_id INTEGER NOT NULL, expense_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, expense_note TEXT NULL)');
    db.execute(
        'CREATE TABLE accounts_master(account_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, account_name TEXT NOT NULL, account_type_id INTEGER NOT NULL,  currency_id INTEGER NOT NULL,balance_amount REAL NOT NULL)');
    db.execute(
        'CREATE TABLE account_trans_master(account_trans_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, account_trans_desc TEXT NOT NULL,account_trans_amount REAL NOT NULL,account_id INTEGER NOT NULL, account_trans_type_id INTEGER NOT NULL,  currency_id INTEGER NOT NULL,account_trans_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, account_trans_note TEXT NULL)');
    db.execute(
        'CREATE TABLE goals_master(goal_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, goal_name TEXT NOT NULL, currency_name TEXT NOT NULL, currency_short_name TEXT NOT NULL,achieved_amount REAL NOT NULL,achieved_percent REAL NOT NULL,target_amount REAL NOT NULL,goal_start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,goal_target_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)');
    db.execute(
        'CREATE TABLE goal_deposits(goal_deposit_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, goal_id INTEGER NOT NULL, deposit_amount REAL NOT NULL,deposit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,deposit_notes TEXT NULL, deposit_status INTEGER NOT NULL)');
    db.execute(
        'CREATE TABLE currencies_master(currency_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, currency_name TEXT NOT NULL, currency_short_name TEXT NOT NULL, currency_icon TEXT NULL)');
    db.execute(
        'CREATE TABLE expenses_type_master(expense_type_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, expense_type_name TEXT NOT NULL, expense_type_desc TEXT NULL, expense_type_icon TEXT NULL)');
    db.execute(
        'CREATE TABLE accounts_type_master(account_type_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, account_type_name TEXT NOT NULL, account_type_desc TEXT NULL, account_type_icon TEXT NULL)');
    db.execute(
        'CREATE TABLE accounts_trans_type(account_trans_type_id INTEGER PRIMARY KEY NOT NULL, account_trans_type_name TEXT NOT NULL)');
    db.insert('currencies_master', {
      'currency_name': 'Indian Rupee',
      'currency_short_name': 'INR',
      'currency_icon': '₹'
    });
    db.insert('accounts_trans_type',
        {'account_trans_type_id': 1, 'account_trans_type_name': 'Income'});
    db.insert('accounts_trans_type',
        {'account_trans_type_id': 2, 'account_trans_type_name': 'Expense'});
    db.insert('expenses_type_master', {
      'expense_type_name': 'Shopping',
      'expense_type_desc': 'Offline Shopping',
      'expense_type_icon': ''
    });
    db.insert('accounts_type_master', {
      'account_type_name': 'Bank',
      'account_type_desc': 'Bank Accounts',
      'account_type_icon': ''
    });
    db.insert('accounts_type_master', {
      'account_type_name': 'Credit Card',
      'account_type_desc': 'Credit Cards',
      'account_type_icon': ''
    });
    db.insert('accounts_type_master', {
      'account_type_name': 'Debit Card',
      'account_type_desc': 'Debit Cards',
      'account_type_icon': ''
    });
    db.insert('accounts_type_master', {
      'account_type_name': 'Wallet',
      'account_type_desc': 'Wallets',
      'account_type_icon': ''
    });
    db.insert('accounts_type_master', {
      'account_type_name': 'Cash',
      'account_type_desc': 'Cash',
      'account_type_icon': ''
    });
  }

  static Future<int> insertDataToDB(
      String tableName, Map<String, Object> data) async {
    final sqlDB = await DBHelper.getDBInstance();
    final insertedId = await sqlDB.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm
          .replace, //this will replace the existing entry in db if exists
    );
    return insertedId;
  }

  static Future<List<Map<String, dynamic>>> getDataFromDB(
      String tableName) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.query(tableName);
  }

  static Future<List<Map<String, dynamic>>> getDataFromDBRawQuery(
      String query) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.rawQuery(query);
  }

  //db.rawInsert('INSERT INTO my_table(name, age) VALUES("Bob", 23)');

  static Future<int> insertDataToDBRawStmt(String stmt) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.rawInsert(stmt);
  }

  static Future<int> insertDataToDBRawStmtParam(String stmt, params) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.rawInsert(stmt, params);
  }

  static Future<List<Map<String, dynamic>>> getDataFromDBRawQueryParam(
      String query, params) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.rawQuery(query, params);
  }

  static Future<int> updateDataDBRawQueryParam(String query, params) async {
    final sqlDB = await DBHelper.getDBInstance();
    return sqlDB.rawUpdate(query, params);
  }
}
