import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/date_utils.dart';
import '../providers/expenses_provider.dart';

class ExpensesWidget extends StatefulWidget {
  final appStrings, lang;
  const ExpensesWidget(this.appStrings, this.lang, {super.key});

  @override
  State<ExpensesWidget> createState() => ExpensesWidgetState();
}

class ExpensesWidgetState extends State<ExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    final expensesList =
        Provider.of<ExpenseProvider>(context).fetchExpensesQueryList;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListView.builder(
          itemCount: expensesList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expensesList[index].accountName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expensesList[index].expenseName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                expensesList[index].expenseTypeName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹ ${expensesList[index].expenseAmount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                DateUtil.getPrettyDate(
                                    expensesList[index].expenseDate),
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          }),
    ));
  }
}
