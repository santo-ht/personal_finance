import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:personal_finance/expenses/pages/expenses_add_page.dart';
import 'package:personal_finance/generic/widgets/drawer_widget.dart';
import 'package:personal_finance/config/app_strings.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:personal_finance/goals/pages/goals_add_page.dart';
import 'package:provider/provider.dart';

import 'accounts/pages/accounts_add_page.dart';
import 'config/app_config.dart';
import 'expenses/providers/expenses_provider.dart';
import 'generic/widgets/bottom_navbar_widget.dart';
import 'home_page_widget.dart';
import 'income/pages/income_add_page.dart';
import 'income/providers/income_provider.dart';
import 'lang/providers/english_string_provider.dart';
import 'lang/providers/language_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/homePage";

  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isInit = true;
  var isLoading = false;

  var appStrings, lang;

  //List<Tab> _homeTabs = [];

  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  void dispose() {
    // _tabController.dispose();

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
          //print(appStrings);
        }

        if (value == null) {
          appStrings =
              Provider.of<EnglishStringProvider>(context, listen: false)
                  .fetchEnglishStringMap;
          lang = 'en';
        }

        Provider.of<ExpenseProvider>(context, listen: false)
            .fetchSetAllExpensesQueryFromDb(AppConfig.allExpensesTotalQuery)
            //.fetchSetExpensesFromDb(AppConfig.expenseTable)
            .then((_) {
          Provider.of<IncomeProvider>(context, listen: false)
              .fetchSetAllIncomeQueryFromDb(AppConfig.allIncomeTotalQuery)
              .then((_) {})
              .catchError((onError) {
            setState(() {
              isLoading = false;
            });
          });
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
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                appStrings['summary'],
                style: appPrimaryTheme().textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                color: Colors.white,
                child: const HomePageWidget(),
              ),
            ),
            bottomNavigationBar: const BottomNavBarWidget(0, 0),
            floatingActionButton: SpeedDial(
              activeIcon: Icons.close,
              icon: Icons.add,
              // animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                  child: const Icon(
                    MdiIcons.cashRegister,
                  ),
                  label: appStrings['expenses'],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ExpensesAddPage.routeName, arguments: {
                      'appStrings': appStrings,
                      'lang': lang,
                    }).then((value) {});
                  },
                ),
                SpeedDialChild(
                  child: const Icon(
                    MdiIcons.bankTransfer,
                  ),
                  label: appStrings['income'],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(IncomeAddPage.routeName, arguments: {
                      'appStrings': appStrings,
                      'lang': lang,
                    }).then((value) {});
                  },
                ),
                SpeedDialChild(
                  child: const Icon(
                    MdiIcons.timer,
                  ),
                  label: appStrings['goals'],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(GoalsAddPage.routeName, arguments: {
                      'appStrings': appStrings,
                      'lang': lang,
                    }).then((value) {});
                  },
                ),
                SpeedDialChild(
                  child: const Icon(
                    MdiIcons.cashMultiple,
                  ),
                  label: appStrings['budgets'],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(ExpensesAddPage.routeName, arguments: {
                      'appStrings': appStrings,
                      'lang': lang,
                    }).then((value) {});
                  },
                ),
                SpeedDialChild(
                  child: const Icon(
                    MdiIcons.bankTransfer,
                  ),
                  label: appStrings['accounts'],
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AccountsAddPage.routeName, arguments: {
                      'appStrings': appStrings,
                      'lang': lang,
                    }).then((value) {});
                  },
                ),
              ],
            ),
            drawer: const DrawerWidget(),
          );
  }
}
