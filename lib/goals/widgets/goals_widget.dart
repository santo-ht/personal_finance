import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:personal_finance/goals/pages/goals_deposit_page.dart';
import 'package:personal_finance/goals/providers/goals_provider.dart';
import 'package:provider/provider.dart';

class GoalsWidget extends StatefulWidget {
  final appStrings, lang;
  const GoalsWidget(this.appStrings, this.lang, {super.key});

  @override
  State<GoalsWidget> createState() => _GoalsWidgetState();
}

class _GoalsWidgetState extends State<GoalsWidget> {
  @override
  Widget build(BuildContext context) {
    final goalsList = Provider.of<GoalsProvider>(context).fetchGoalsList;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListView.builder(
          itemCount: goalsList.length,
          itemBuilder: (context, index) {
            final daysLeft = (DateFormat("yyyy-MM-dd hh:mm:ss")
                    .parse(goalsList[index].targetDate))
                .difference(DateTime.now())
                .inDays;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context)
                  .pushNamed(GoalsDepositPage.routeName, arguments: {
                "appStrings": widget.appStrings,
                "lang": widget.lang,
                "goalDetails": goalsList[index],
              }),
              /*     .then((value) => Navigator.of(context)
                      .pushReplacementNamed(GoalsPage.routeName)), */
              child: Card(
                elevation: 5,
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(children: [
                    Text(
                      goalsList[index].goalName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹${goalsList[index].achievedAmount} / ₹${goalsList[index].targetAmount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${daysLeft.toString()} days left',
                              style: const TextStyle(
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          percent: goalsList[index].achievedPercent / 100 > 1
                              ? 1
                              : goalsList[index].achievedPercent / 100,
                          radius: 35,
                          progressColor:
                              goalsList[index].achievedPercent / 100 > 0.75
                                  ? Colors.green
                                  : Colors.red,
                          center: Text(
                            '${goalsList[index].achievedPercent} %',
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            );
          }),
    ));
  }
}
