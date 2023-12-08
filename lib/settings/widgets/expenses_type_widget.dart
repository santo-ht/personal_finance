import 'package:flutter/material.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:provider/provider.dart';

import '../providers/expenses_type_provider.dart';

class ExpensesTypeWidget extends StatefulWidget {
  const ExpensesTypeWidget({super.key});

  @override
  ExpensesTypeWidgetState createState() => ExpensesTypeWidgetState();
}

class ExpensesTypeWidgetState extends State<ExpensesTypeWidget> {
  // final currenciesList = AppCurrencies.currencies;

  @override
  Widget build(BuildContext context) {
    final expensesTypeList =
        Provider.of<ExpensesTypeProvider>(context).fetchExpensesTypeList;
    return expensesTypeList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expensesTypeList[index].expenseTypeName,
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        Text(
                          expensesTypeList[index].iconName,
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        //Text(String.fromCharCodes(a3)),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            itemCount: expensesTypeList.length,
          )
        : Container();
  }
}
