import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:personal_finance/income/pages/income_page.dart';

import 'package:personal_finance/settings/providers/currencies_provider.dart';

import 'package:provider/provider.dart';

import '../../accounts/models/accounts_model.dart';
import '../../accounts/providers/accounts_provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../../settings/models/currencies_model.dart';
import '../../utils/date_utils.dart';
import '../../utils/db_helper.dart';

class IncomeAddWidget extends StatefulWidget {
  final appStrings, lang;
  const IncomeAddWidget(this.appStrings, this.lang, {super.key});
  @override
  State<IncomeAddWidget> createState() => IncomeAddWidgetState();
}

class IncomeAddWidgetState extends State<IncomeAddWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isInit = true;
  var isLoading = false;
  var incomeName,
      currencyId,
      incomeTypeId,
      accountTypeId,
      selectedETVal,
      selectedCurrencyVal,
      selectedAccountsVal;
  late double incomeAmount;
  String incomeNote = '';

  DateTime incomeDate = DateTime.now();

  double achievedAmount = 0.0;
  double achievedPercent = 0.0;
  List<CurrenciesModel> currenciesList = [];

  List<AccountsModel> accountsList = [];

  late int selectedETIndex, selectedCurrencyIndex, selectedAcctIndex;
  late String initialDropDownETVal,
      initialDropDownCurrencyVal,
      initialDropDownAcctVal;
  List<DropdownMenuItem<String>> incomeTypesDropdownItems = [];
  List<DropdownMenuItem<String>> currenciesDropdownItems = [];
  List<DropdownMenuItem<String>> accountsDropdownItems = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currenciesList =
        Provider.of<CurrenciesProvider>(context).fetchCurrenciesList;
    currenciesDropdownItems.clear();
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
        value: currenciesList[i].currencyName,
        child: Text(currenciesList[i].currencyName),
      );
      currenciesDropdownItems.add(newItem);
    }

    accountsList = Provider.of<AccountsProvider>(context).fetchAccountsList;
    accountsDropdownItems.clear();
    for (int k = 0; k < accountsList.length; k++) {
      var newItem = DropdownMenuItem(
        value: accountsList[k].accountName,
        child: Text(accountsList[k].accountName),
      );
      accountsDropdownItems.add(newItem);
    }
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

      final formattedIncomeDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(incomeDate);

      try {
        _formKey.currentState!.save();
        final Map<String, Object> dbmap = {
          'account_trans_desc': incomeName,
          // 'Income_type_id': IncomeTypeList[selectedETIndex].IncomeTypeId,
          'account_trans_amount': incomeAmount,
          'account_id': accountsList[selectedAcctIndex].accountId,
          'account_trans_type_id': 1,
          'currency_id': currenciesList[selectedCurrencyIndex]
              .currencyId, //currencyShortName,
          'account_trans_date': formattedIncomeDate,
          'account_trans_note': incomeNote,
        };
        DBHelper.insertDataToDB(AppConfig.accountTransMaster, dbmap);
        // Navigator.of(context).pop();
        //Provider.of<CoinsProvider>(context).
        Navigator.of(context).pushReplacementNamed(IncomePage.routeName);
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
        : SafeArea(
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
                            widget.appStrings['income-name'],
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
                                return (widget
                                    .appStrings['income-name-validate']);
                              }

                              return null;
                            },

                            onSaved: (value) {
                              setState(() {
                                incomeName = value;
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
                            widget.appStrings['income-amount'],
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
                                return (widget
                                    .appStrings['income-amount-validate']);
                              }

                              return null;
                            },

                            onSaved: (value) {
                              setState(() {
                                incomeAmount = double.parse(value!);
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
                            widget.appStrings['income-date'],
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
                              ..text = DateUtil.getStringDate(
                                  incomeDate, widget.lang),
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
                                  incomeDate = date;
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
                            widget.appStrings['select-currency'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton(
                              isExpanded: true,
                              value: selectedCurrencyVal,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: currenciesDropdownItems,
                              onChanged: (value) {
                                setState(() {
                                  initialDropDownCurrencyVal = value as String;
                                  selectedCurrencyVal = value;
                                  selectedCurrencyIndex =
                                      currenciesDropdownItems
                                          .indexWhere((i) => i.value == value);
                                });
                              }),
                        ),

                        //SizedBox(height: 10),
                        /*  Container(
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
                                return (widget.appStrings['currency-validate']);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                currencyId = value;
                              });
                            },
                          ),
                        ), */
                        const SizedBox(
                          height: 15,
                        ),
                        /*  Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Text(
                            widget.appStrings['income-type'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton(
                              isExpanded: true,
                              value: selectedETVal,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: incomeTypesDropdownItems,
                              onChanged: (value) {
                                setState(() {
                                  initialDropDownETVal = value as String;
                                  selectedETVal = value;
                                  selectedETIndex = incomeTypesDropdownItems
                                      .indexWhere((i) => i.value == value);
                                });
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ), */
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                          child: Text(
                            widget.appStrings['accounts'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: DropdownButton(
                              isExpanded: true,
                              value: selectedAccountsVal,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: accountsDropdownItems,
                              onChanged: (value) {
                                setState(() {
                                  initialDropDownAcctVal = value as String;
                                  selectedAccountsVal = value;
                                  selectedAcctIndex = accountsDropdownItems
                                      .indexWhere((i) => i.value == value);
                                });
                              }),
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
                                widget.appStrings['save'],
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
          );
  }
}
