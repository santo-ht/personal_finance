import 'package:flutter/material.dart';
import 'package:personal_finance/accounts/providers/accounts_provider.dart';
import 'package:personal_finance/settings/providers/account_trans_type_provider.dart';

import 'package:provider/provider.dart';

import '../../settings/providers/currencies_provider.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../widgets/trans_add_widget.dart';

class TransAddPage extends StatefulWidget {
  static const routeName = '/transAddPage';
  const TransAddPage({super.key});

  @override
  State<TransAddPage> createState() => TransAddPageState();
}

class TransAddPageState extends State<TransAddPage> {
  var isLoading = false;

  var appStrings, lang;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];
    Provider.of<CurrenciesProvider>(context, listen: false)
        .fetchSetCurrenciesFromDb(AppConfig.currenciesTable)
        .then((_) {
      Provider.of<AccountsProvider>(context, listen: false)
          .fetchSetAccountsFromDb(AppConfig.accountsTable)
          .then((_) {
        Provider.of<AccountTransTypeProvider>(context, listen: false)
            .fetchSetAccountTransTypesFromDb(AppConfig.accountsTransTypeTable)
            .then((_) {});
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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              title: Text(
                appStrings['create-trans'],
                style: const TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            body: TransAddWidget(appStrings, lang),
          );
  }
}
