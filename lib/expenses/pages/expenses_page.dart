import 'package:flutter/material.dart';
import 'package:personal_finance/expenses/providers/expenses_provider.dart';

import 'package:personal_finance/generic/widgets/bottom_navbar_widget.dart';
import 'package:personal_finance/generic/widgets/drawer_widget.dart';
import 'package:personal_finance/config/app_config.dart';
import 'package:personal_finance/config/app_strings.dart';
import 'package:personal_finance/lang/providers/english_string_provider.dart';
import 'package:personal_finance/lang/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/expenses_widget.dart';
import 'expenses_add_page.dart';

class ExpensesPage extends StatefulWidget {
  static const routeName = '/expensesPage';

  const ExpensesPage({super.key});
  @override
  State<ExpensesPage> createState() => ExpensesPageState();
}

class ExpensesPageState extends State<ExpensesPage> {
  var isInit = true;
  var isLoading = false;

  var appStrings, lang;

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setData() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<LanguageProvider>(context, listen: false)
          .fetchLanguageString
          .then((value) {
        if (value == AppStrings.englishDesc) {
          appStrings =
              Provider.of<EnglishStringProvider>(context, listen: false)
                  .fetchEnglishStringMap;
          lang = 'en';
        }

        if (value == null) {
          appStrings =
              Provider.of<EnglishStringProvider>(context, listen: false)
                  .fetchEnglishStringMap;
          lang = 'en';
        }

        Provider.of<ExpenseProvider>(context, listen: false)
            .fetchSetExpensesQueryFromDb(AppConfig.expensesQuery)
            // .fetchSetExpensesFromDb(AppConfig.expenseTable)
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

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              //  iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                appStrings['expenses'],
                style: const TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: ExpensesWidget(appStrings, lang),
            //  bottomNavigationBar: const BottomNavBarWidget(1, 1),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(ExpensesAddPage.routeName, arguments: {
                "appStrings": appStrings,
                "lang": lang,
              }),
              child: const Icon(Icons.add),
            ),
            //drawer: const DrawerWidget(),
          );
  }
}
