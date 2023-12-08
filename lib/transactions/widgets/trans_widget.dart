import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/date_utils.dart';
import '../providers/trans_provider.dart';

class TransWidget extends StatefulWidget {
  final appStrings, lang;
  const TransWidget(this.appStrings, this.lang, {super.key});

  @override
  State<TransWidget> createState() => TransWidgetState();
}

class TransWidgetState extends State<TransWidget> {
  @override
  Widget build(BuildContext context) {
    final transList = Provider.of<TransProvider>(context).fetchTransQueryList;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListView.builder(
          itemCount: transList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              //color: Colors.black87,
              shadowColor:
                  transList[index].transTypeId == 1 ? Colors.green : Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transList[index].accountName,
                        style: const TextStyle(
                          color: Colors.black,
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
                                transList[index].transName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              /*  Text(
                                transList[index].expenseTypeName,
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
                                transList[index].transTypeId == 1
                                    ? '₹ ${transList[index].transAmount}'
                                    : '₹ -${transList[index].transAmount}',
                                style: TextStyle(
                                  color: transList[index].transTypeId == 1
                                      ? Colors.green
                                      : Colors.red,
                                  // Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                DateUtil.getPrettyDate(
                                    transList[index].transDate),
                                style: const TextStyle(
                                  color: Colors.black,
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
