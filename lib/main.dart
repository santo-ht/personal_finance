import 'package:flutter/material.dart';
import 'package:personal_finance/accounts/pages/accounts_add_page.dart';
import 'package:personal_finance/accounts/pages/accounts_page.dart';
import 'package:personal_finance/budgets/pages/budgets_page.dart';
import 'package:personal_finance/expenses/pages/expenses_page.dart';
import 'package:personal_finance/goals/pages/goals_page.dart';
import 'package:personal_finance/income/pages/income_add_page.dart';
import 'package:personal_finance/settings/pages/currencies_page.dart';
import 'package:personal_finance/settings/providers/accounts_type_provider.dart';
import 'package:personal_finance/settings/providers/expenses_type_provider.dart';
import 'package:personal_finance/transactions/pages/trans_add_page.dart';
import 'package:personal_finance/transactions/pages/trans_page.dart';

import 'package:provider/provider.dart';

import 'income/pages/income_page.dart';
import 'accounts/providers/accounts_provider.dart';
import 'expenses/pages/expenses_add_page.dart';
import 'expenses/providers/expenses_provider.dart';

import 'income/providers/income_provider.dart';
import 'settings/pages/accounts_type_page.dart';
import 'settings/pages/expenses_type_page.dart';
import 'settings/providers/account_trans_type_provider.dart';
import 'settings/providers/currencies_provider.dart';
import 'goals/pages/goals_add_page.dart';

import 'goals/pages/goals_deposit_page.dart';
import 'goals/providers/goal_deposits_provider.dart';
import 'goals/providers/goals_provider.dart';
import 'config/app_theme.dart';
import 'home_page.dart';
import 'lang/providers/english_string_provider.dart';
import 'lang/providers/language_provider.dart';
import 'settings/pages/settings_page.dart';
import 'transactions/providers/trans_provider.dart';

void main() {
  runApp(const FinanceManager());
}

class FinanceManager extends StatefulWidget {
  const FinanceManager({super.key});

  @override
  State<FinanceManager> createState() => _FinanceManagerState();
}

class _FinanceManagerState extends State<FinanceManager> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => LanguageProvider()),
        ChangeNotifierProvider(create: (ctx) => EnglishStringProvider()),
        ChangeNotifierProvider(create: (ctx) => CurrenciesProvider()),
        ChangeNotifierProvider(create: (ctx) => ExpenseProvider()),
        ChangeNotifierProvider(create: (ctx) => IncomeProvider()),
        ChangeNotifierProvider(create: (ctx) => TransProvider()),
        ChangeNotifierProvider(create: (ctx) => ExpensesTypeProvider()),
        ChangeNotifierProvider(create: (ctx) => AccountsProvider()),
        ChangeNotifierProvider(create: (ctx) => AccountsTypeProvider()),
        ChangeNotifierProvider(create: (ctx) => GoalsProvider()),
        ChangeNotifierProvider(create: (ctx) => GoalDepositsProvider()),
        ChangeNotifierProvider(create: (ctx) => AccountTransTypeProvider()),
      ],
      child: MaterialApp(
        title: 'Finance Manager',
        debugShowCheckedModeBanner: false,
        theme: appPrimaryTheme(),
        home: const HomePage(),
        routes: {
          HomePage.routeName: (ctx) => const HomePage(),
          ExpensesPage.routeName: (ctx) => const ExpensesPage(),
          ExpensesAddPage.routeName: (ctx) => const ExpensesAddPage(),
          AccountsPage.routeName: (ctx) => const AccountsPage(),
          AccountsAddPage.routeName: (ctx) => const AccountsAddPage(),
          BudgetsPage.routeName: (ctx) => const BudgetsPage(),
          GoalsPage.routeName: (ctx) => const GoalsPage(),
          GoalsAddPage.routeName: (ctx) => const GoalsAddPage(),
          GoalsDepositPage.routeName: (ctx) => const GoalsDepositPage(),
          SettingsPage.routeName: (ctx) => const SettingsPage(),
          CurrenciesPage.routeName: (ctx) => const CurrenciesPage(),
          ExpensesTypePage.routeName: (ctx) => const ExpensesTypePage(),
          AccountsTypePage.routeName: (ctx) => const AccountsTypePage(),
          IncomeAddPage.routeName: (ctx) => const IncomeAddPage(),
          IncomePage.routeName: (ctx) => const IncomePage(),
          TransAddPage.routeName: (ctx) => const TransAddPage(),
          TransPage.routeName: (ctx) => const TransPage(),
        },
      ),
    );
  }
}
