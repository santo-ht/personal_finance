import 'package:flutter/material.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:personal_finance/expenses/pages/expenses_page.dart';
import 'package:personal_finance/expenses/providers/expenses_provider.dart';
import 'package:personal_finance/income/pages/income_page.dart';
import 'package:personal_finance/income/providers/income_provider.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final totalExpensesList =
        Provider.of<ExpenseProvider>(context).fetchAllExpensesQuery;
    /*   if (totalExpensesList.isEmpty) {
      totalExpensesList.add(0);
    } */
    final totalIncomeList =
        Provider.of<IncomeProvider>(context).fetchAllIncomeQuery;
    final balance = totalIncomeList[0] - totalExpensesList[0];
    // double totalExpenses = totalExpensesList.reduce((a, b) => a + b);
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    Navigator.of(context).pushNamed(IncomePage.routeName),
                child: Card(
                  //color: Colors.green,
                  elevation: 5,
                  shadowColor: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Income'),
                        Text(
                          totalIncomeList[0].toString(),
                          style: appPrimaryTheme().textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text('-'),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () =>
                    Navigator.of(context).pushNamed(ExpensesPage.routeName),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Expenses'),
                        Text(
                          totalExpensesList[0].toString(),
                          //'200000',
                          style: appPrimaryTheme().textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text('='),
              Card(
                // elevation: 5,
                shadowColor: balance > 0 ? Colors.green : Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Balance'),
                      Text(
                        balance.toString(),
                        style: appPrimaryTheme().textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //HomeBarChartWidget(),
        ],
      ),
    );
  }
}
