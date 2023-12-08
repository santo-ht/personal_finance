import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:personal_finance/accounts/pages/accounts_page.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:personal_finance/settings/pages/currencies_page.dart';
import 'package:personal_finance/settings/pages/expenses_type_page.dart';

import 'accounts_type_page.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settingsPage';

  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var appStrings, lang;
/*   @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  } */
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            appStrings['settings'],
            style: appPrimaryTheme().textTheme.titleLarge,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              //padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(CurrenciesPage.routeName, arguments: {
                          "appStrings": appStrings,
                          "lang": lang,
                        }),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              children: [
                                Text(
                                  appStrings['currencies'],
                                  style: appPrimaryTheme().textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.currency_exchange_rounded,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(ExpensesTypePage.routeName, arguments: {
                          "appStrings": appStrings,
                          "lang": lang,
                        }),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              children: [
                                Text(
                                  appStrings['expense-types'],
                                  style: appPrimaryTheme().textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.payments_outlined,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(AccountsTypePage.routeName, arguments: {
                          "appStrings": appStrings,
                          "lang": lang,
                        }),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              children: [
                                Text(
                                  appStrings['account-types'],
                                  style: appPrimaryTheme().textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  MdiIcons.bank,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      /*  GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(ExpensesTypePage.routeName, arguments: {
                          "appStrings": appStrings,
                          "lang": lang,
                        }),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                            child: Column(
                              children: [
                                Text(
                                  appStrings['expense-types'],
                                  style: appPrimaryTheme().textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Icon(
                                  Icons.payments_outlined,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ), */
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
