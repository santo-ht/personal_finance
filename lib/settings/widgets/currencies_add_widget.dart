import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../../utils/db_helper.dart';
import '../pages/currencies_page.dart';

class CurrenciesAddWidget extends StatefulWidget {
  final appStrings, lang;
  const CurrenciesAddWidget(this.appStrings, this.lang, {super.key});

  @override
  CurrenciesAddWidgetState createState() => CurrenciesAddWidgetState();
}

class CurrenciesAddWidgetState extends State<CurrenciesAddWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isInit = true;
  bool isLoading = false;
  late String currencyName;
  late String currencyShortName;
  String currencyIcon = '';

  void validateSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        _formKey.currentState!.save();
        final Map<String, Object> dbmap = {
          'currency_name': currencyName,
          'currency_short_name': currencyShortName,
          'currency_icon': currencyIcon,
        };
        DBHelper.insertDataToDB(AppConfig.currenciesTable, dbmap);
        Navigator.of(context).pop();
        //Provider.of<CoinsProvider>(context).
        // Navigator.of(context).pushReplacementNamed(CoinsPage.routeName);
      } catch (error) {
        // print(error);
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
    return (FloatingActionButton(
      backgroundColor: Colors.black,
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
                              widget.appStrings['add-currencies'],
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
                      /*  Container(
                              margin: EdgeInsets.fromLTRB(15, 0, 0, 5),
                              child: Text(''),
                            ),
                            SizedBox(
                              height: 20,
                            ), */
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Text(
                          widget.appStrings['currency-name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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
                            /* if (value!.isEmpty) {
                              return (AppStrings.wifiPasswordValidate);
                            } */

                            return null;
                          },

                          onSaved: (value) {
                            setState(() {
                              currencyName = value!;
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
                          widget.appStrings['currency-short-name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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
                            /*  if (value!.isEmpty) {
                              return (AppStrings.wifiPasswordValidate);
                            } */

                            return null;
                          },

                          onSaved: (value) {
                            setState(() {
                              currencyShortName = value!;
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
                          widget.appStrings['currency-icon'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
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
                            /*  if (value!.isEmpty) {
                              return (AppStrings.wifiPasswordValidate);
                            } */

                            return null;
                          },

                          onSaved: (value) {
                            setState(() {
                              currencyIcon = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                          onTap: () {
                            validateSubmit();
                            Navigator.of(context).pushReplacementNamed(
                                CurrenciesPage.routeName,
                                arguments: {
                                  "appStrings": widget.appStrings,
                                  "lang": widget.lang,
                                });
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
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    ));
  }
}
