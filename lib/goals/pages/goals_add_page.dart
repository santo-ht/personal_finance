import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance/settings/models/currencies_model.dart';
import 'package:personal_finance/goals/pages/goals_page.dart';
import 'package:personal_finance/utils/db_helper.dart';
import 'package:provider/provider.dart';

import '../../settings/providers/currencies_provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../../utils/date_utils.dart';

class GoalsAddPage extends StatefulWidget {
  static const routeName = '/goalsAddPage';
  const GoalsAddPage({super.key});

  @override
  State<GoalsAddPage> createState() => _GoalsAddPageState();
}

class _GoalsAddPageState extends State<GoalsAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoading = false;

  var appStrings, lang;
  var goalName, currencyName, currencyShortName;
  late double goalAmount;
  DateTime goalStartDate = DateTime.now();
  DateTime goalEndDate = DateTime.now().add(const Duration(days: 30));

  double achievedAmount = 0.0;
  double achievedPercent = 0.0;
  List<CurrenciesModel> currenciesList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];
    Provider.of<CurrenciesProvider>(context)
        .fetchSetCurrenciesFromDb(AppConfig.currenciesTable)
        .then((_) {
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

  DateTime minTime() {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  DateTime maxTime() {
    var now = DateTime.now().add(const Duration(days: 36500));
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  void validateSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final formattedStartDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(goalStartDate);

      final formattedEndDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(goalEndDate);
      try {
        _formKey.currentState!.save();
        final Map<String, Object> dbmap = {
          'goal_name': goalName,
          'currency_name': currencyName,
          'currency_short_name': currencyName, //currencyShortName,
          'achieved_amount': achievedAmount,
          'achieved_percent': achievedPercent,
          'target_amount': goalAmount,
          'goal_start_date': formattedStartDate,
          'goal_target_date': formattedEndDate,
        };
        DBHelper.insertDataToDB(AppConfig.goalsTable, dbmap);
        // Navigator.of(context).pop();
        //Provider.of<CoinsProvider>(context).
        Navigator.of(context).pushReplacementNamed(GoalsPage.routeName);
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
    return isLoading
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              title: Text(
                appStrings['create-goal'],
                style: const TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  //height: 250,
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child:
                      //  Wrap(children: [
                      Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              appStrings['goal-name'],
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
                              keyboardType: TextInputType.text,
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
                                  return (appStrings['goal-name-validate']);
                                }

                                return null;
                              },

                              onSaved: (value) {
                                setState(() {
                                  goalName = value;
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
                              appStrings['goal-amount'],
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
                                  return (appStrings['goal-amount-validate']);
                                }

                                return null;
                              },

                              onSaved: (value) {
                                setState(() {
                                  goalAmount = double.parse(value!);
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
                              appStrings['goal-start-date'],
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
                                    DateUtil.getStringDate(goalStartDate, lang),
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
                                maxTime: maxTime(),
                                showTitleActions: true,
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  setState(() {
                                    goalStartDate = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              appStrings['goal-target-date'],
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
                                    DateUtil.getStringDate(goalEndDate, lang),
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
                                maxTime: maxTime(),
                                showTitleActions: true,
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  setState(() {
                                    goalEndDate = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                            child: Text(
                              appStrings['currency'],
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
                              keyboardType: TextInputType.text,
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
                                  return (appStrings['currency-validate']);
                                }

                                return null;
                              },

                              onSaved: (value) {
                                setState(() {
                                  currencyName = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          GestureDetector(
                              onTap: () {
                                validateSubmit();
                                /* Navigator.of(context)
                              .pushReplacementNamed(CoinsPage.routeName); */
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
                                child: Text(
                                  appStrings['save'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ]),
                  ),
                  // ], ),
                ),
              ),
            ),
          );
  }
}
