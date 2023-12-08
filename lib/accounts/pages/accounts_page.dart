import 'package:flutter/material.dart';
import 'package:personal_finance/accounts/pages/accounts_add_page.dart';
import 'package:personal_finance/accounts/providers/accounts_provider.dart';

import 'package:personal_finance/config/app_strings.dart';
import 'package:personal_finance/lang/providers/english_string_provider.dart';
import 'package:personal_finance/lang/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../../config/app_config.dart';
import '../../config/app_theme.dart';
import '../widgets/accounts_widget.dart';

class AccountsPage extends StatefulWidget {
  static const routeName = '/accountsPage';

  const AccountsPage({super.key});
  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
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
          //print(appStrings);
        }

        if (value == null) {
          appStrings =
              Provider.of<EnglishStringProvider>(context, listen: false)
                  .fetchEnglishStringMap;
          lang = 'en';
          //print(appStrings);
        }

        Provider.of<AccountsProvider>(context, listen: false)
            .fetchSetAccountsQueryFromDb(AppConfig.accountsQuery)
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
          /*  FirebaseHelper.sendAnalyticsEvent(
            context: context,
            name: AppStrings.fbHomePage,
            params: eventParams,
          ); */
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
                appStrings['accounts'],
                style: appPrimaryTheme().textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: AccountsWidget(appStrings, lang),
            /*  Container(
              color: Colors.white,
              child: Text('Hi'),
            ), */
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AccountsAddPage.routeName, arguments: {
                'appStrings': appStrings,
                'lang': lang,
              }),
              child: const Icon(Icons.add),
            ),
          );
  }
}
