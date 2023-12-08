import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/date_utils.dart';
import '../providers/income_provider.dart';

class IncomeWidget extends StatefulWidget {
  final appStrings, lang;
  const IncomeWidget(this.appStrings, this.lang, {super.key});

  @override
  State<IncomeWidget> createState() => IncomeWidgetState();
}

class IncomeWidgetState extends State<IncomeWidget> {
  @override
  Widget build(BuildContext context) {
    final incomeList =
        Provider.of<IncomeProvider>(context).fetchincomeQueryList;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListView.builder(
          itemCount: incomeList.length,
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
                        incomeList[index].accountName,
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
                                incomeList[index].incomeName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              /*  Text(
                                incomeList[index].expenseTypeName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ), */
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹ ${incomeList[index].incomeAmount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                DateUtil.getPrettyDate(
                                    incomeList[index].incomeDate),
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
