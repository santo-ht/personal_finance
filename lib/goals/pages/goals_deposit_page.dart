import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:personal_finance/goals/models/goals_model.dart';
import 'package:personal_finance/goals/pages/goals_page.dart';
import 'package:personal_finance/goals/providers/goal_deposits_provider.dart';
import 'package:personal_finance/goals/widgets/goal_deposits_widget.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../utils/db_helper.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../../config/app_theme.dart';
import '/utils/date_utils.dart';

class GoalsDepositPage extends StatefulWidget {
  static const routeName = '/goalsDetailPage';
  const GoalsDepositPage({super.key});

  @override
  State<GoalsDepositPage> createState() => GoalsDepositPageState();
}

class GoalsDepositPageState extends State<GoalsDepositPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoading = false;

  var appStrings, lang;
  var goalId;

  double depositAmount = 0.0;
  DateTime depositDate = DateTime.now();

  late GoalsModel goalDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];
    //goalId = args['goalId'];
    goalDetails = args['goalDetails'];
    Provider.of<GoalDepositsProvider>(context, listen: false)
        .fetchSetGoalIdDepositsFromDb(AppConfig.goalDepositsQuery,
            [0, goalDetails.goalId]). //0 - Active Status
        then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text(AppStrings.error),
              content: Text(error.toString()),
              actions: [
                ElevatedButton.icon(
                    // color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the alert dialog
                      Navigator.of(context)
                          .pop(); //Navigate back to previous page
                      /*  if (error.toString() == AppStrings.tokenExpiryMessage) {
                          Navigator.of(context)
                              .pushReplacementNamed(AuthPage.routeName);
                        } */
                    },
                    icon: const Icon(Icons.close),
                    label: const Text(AppStrings.close))
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
    });
  }

  void validateSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final formattedDepositDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(depositDate);

      try {
        _formKey.currentState!.save();
        final Map<String, Object> dbmap = {
          'goal_id': goalDetails.goalId,
          'deposit_amount': depositAmount,
          'deposit_date': formattedDepositDate,
          'deposit_notes': '',
          'deposit_status': 0,
        };
        DBHelper.insertDataToDB(AppConfig.goalsDepositTable, dbmap)
            .then((value) {
          final updatedAchievedAmount =
              goalDetails.achievedAmount + depositAmount;
          final updatedAchievedPercent =
              ((updatedAchievedAmount / goalDetails.targetAmount) * 100)
                  .toStringAsPrecision(4);
          DBHelper.updateDataDBRawQueryParam(AppConfig.goalUpdate, [
            updatedAchievedAmount,
            updatedAchievedPercent,
            goalDetails.goalId
          ]).then((value) {
            goalDetails.achievedAmount = updatedAchievedAmount;
            goalDetails.achievedPercent = double.parse(updatedAchievedPercent);
            Navigator.of(context).pushReplacementNamed(
              GoalsDepositPage.routeName,
              arguments: {
                "appStrings": appStrings,
                "lang": lang,
                "goalDetails": goalDetails
              },
            );
          });
        });
      } catch (error) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text(AppStrings.error),
                content: Text(error.toString()),
                actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(AppStrings.close))
                ],
              );
            });
        setState(() {
          isLoading = false;
        });
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, GoalsPage.routeName, (Route<dynamic> route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            goalDetails.goalName,
            style: const TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? Container()
            : SafeArea(
                child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appStrings['goal-start-date'],
                                    style:
                                        appPrimaryTheme().textTheme.titleSmall,
                                  ),
                                  Text(DateUtil.getPrettyDate(
                                      goalDetails.startDate)),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appStrings['goal-target-date'],
                                    style:
                                        appPrimaryTheme().textTheme.titleSmall,
                                  ),
                                  Text(DateUtil.getPrettyDate(
                                      goalDetails.targetDate)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appStrings['achieved'],
                                    style:
                                        appPrimaryTheme().textTheme.titleSmall,
                                  ),
                                  Text('₹${goalDetails.achievedAmount}'),
                                ],
                              ),
                              CircularPercentIndicator(
                                percent: goalDetails.achievedPercent / 100 > 1
                                    ? 1
                                    : goalDetails.achievedPercent / 100,
                                radius: 40,
                                progressColor:
                                    goalDetails.achievedPercent / 100 > 0.75
                                        ? Colors.green
                                        : Colors.red,
                                center: Text(
                                  '${goalDetails.achievedPercent} %',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appStrings['goal'],
                                    style:
                                        appPrimaryTheme().textTheme.titleSmall,
                                  ),
                                  Text('₹${goalDetails.targetAmount}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GoalDepositsWidget(appStrings, lang),
                    ],
                  ),
                ),
              )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  //height: 250,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child:
                      //  Wrap(children: [
                      Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appStrings['close'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              appStrings['deposit-amount'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          //SizedBox(height: 10),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(AppColors.lightGrey))),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextFormField(
                              //controller: emailController,
                              //obscureText: true,
                              autofocus: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return (appStrings[
                                      'deposit-amount-validate']);
                                }

                                return null;
                              },

                              onSaved: (value) {
                                setState(() {
                                  depositAmount = double.parse(value!);
                                });
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              appStrings['deposit-date'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(AppColors.lightGrey))),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: TextField(
                              controller: TextEditingController()
                                ..text =
                                    DateUtil.getStringDate(depositDate, lang),
                              //DateUtil.getStringDate(state),

                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              readOnly: true,
                              onTap: () => DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  setState(() {
                                    depositDate = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                              onTap: () {
                                validateSubmit();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.fromLTRB(15, 0, 10, 5),
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 40,
                                child: const Text(
                                  AppStrings.add,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ]),
                  ),
                  // ], ),
                );
              }),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
