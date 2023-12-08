import 'package:flutter/material.dart';
import 'package:personal_finance/accounts/pages/accounts_page.dart';
import 'package:personal_finance/settings/providers/accounts_type_provider.dart';
import 'package:personal_finance/settings/providers/currencies_provider.dart';
import 'package:provider/provider.dart';

import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../../settings/models/accounts_type_model.dart';
import '../../settings/models/currencies_model.dart';
import '../../utils/db_helper.dart';

class AccountAddWidget extends StatefulWidget {
  final appStrings, lang;
  const AccountAddWidget(this.appStrings, this.lang, {super.key});
  @override
  State<AccountAddWidget> createState() => AccountAddWidgetState();
}

class AccountAddWidgetState extends State<AccountAddWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isInit = true;
  var isLoading = false;
  var accountName,
      currencyId,
      expenseTypeId,
      selectedETVal,
      selectedCurrencyVal;
  late double expenseAmount;
  String expenseNote = '';

  double accountBalance = 0.0;

  DateTime expenseDate = DateTime.now();

  double achievedAmount = 0.0;
  double achievedPercent = 0.0;
  List<CurrenciesModel> currenciesList = [];
  List<AccountsTypeModel> accountTypesList = [];

  late int selectedETIndex, selectedCurrencyIndex;
  late String initialDropDownETVal, initialDropDownCurrencyVal;
  List<DropdownMenuItem<String>> accountTypesDropdownItems = [];
  List<DropdownMenuItem<String>> currenciesDropdownItems = [];

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
    accountTypesList =
        Provider.of<AccountsTypeProvider>(context).fetchAccountTypesList;
    accountTypesDropdownItems.clear();
    for (int j = 0; j < accountTypesList.length; j++) {
      var newItem = DropdownMenuItem(
        value: accountTypesList[j].accountTypeName,
        child: Text(accountTypesList[j].accountTypeName),
      );
      accountTypesDropdownItems.add(newItem);
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

      /*  final formattedExpenseDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(expenseDate);
 */
      try {
        _formKey.currentState!.save();
        final Map<String, Object> dbmap = {
          'account_name': accountName,
          'account_type_id': accountTypesList[selectedETIndex].accountTypeId,
          'currency_id': currenciesList[selectedCurrencyIndex]
              .currencyId, //currencyShortName,
          'balance_amount': accountBalance,
        };

        DBHelper.insertDataToDB(AppConfig.accountsTable, dbmap)
            .then((accountId) {
          if (accountTypesList[selectedETIndex].accountTypeName !=
              'Credit Card') {
            final Map<String, Object> dbTransMap = {
              'account_trans_desc': accountName,
              'account_id': accountId,
              'currency_id': currenciesList[selectedCurrencyIndex]
                  .currencyId, //currencyShortName,
              'account_trans_amount': accountBalance,
              'account_trans_type_id': 1,
            };
            DBHelper.insertDataToDB(AppConfig.accountTransMaster, dbTransMap);
          }
          Navigator.of(context).pushReplacementNamed(AccountsPage.routeName);
        }).catchError((onError) {
          print(onError.toString());
        });

        // Navigator.of(context).pop();
        //Provider.of<CoinsProvider>(context).
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
                            widget.appStrings['account-name'],
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
                                    .appStrings['account-name-validate']);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                accountName = value;
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
                            widget.appStrings['account-balance'],
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
                                    .appStrings['expense-name-validate']);
                              }

                              return null;
                            },

                            onSaved: (value) {
                              setState(() {
                                accountBalance = double.parse(value!);
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
                            widget.appStrings['select-account-type'],
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
                              items: accountTypesDropdownItems,
                              onChanged: (value) {
                                setState(() {
                                  initialDropDownETVal = value as String;
                                  selectedETVal = value;
                                  selectedETIndex = accountTypesDropdownItems
                                      .indexWhere((i) => i.value == value);
                                });
                              }),
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
