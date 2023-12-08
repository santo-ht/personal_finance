import 'package:flutter/material.dart';
import 'package:personal_finance/settings/providers/accounts_type_provider.dart';
import 'package:provider/provider.dart';

import '../../settings/providers/currencies_provider.dart';
import '../../config/app_config.dart';
import '../../config/app_strings.dart';
import '../widgets/account_add_widget.dart';

class AccountsAddPage extends StatefulWidget {
  static const routeName = '/accountsAddPage';
  const AccountsAddPage({super.key});

  @override
  State<AccountsAddPage> createState() => AccountsAddPageState();
}

class AccountsAddPageState extends State<AccountsAddPage> {
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
      Provider.of<AccountsTypeProvider>(context, listen: false)
          .fetchSetAccountTypesFromDb(AppConfig.accountsTypeTable)
          .then((_) {});
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
                appStrings['create-account'],
                style: const TextStyle(color: Colors.black),
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
            ),
            body: AccountAddWidget(appStrings, lang),
          );
  }
}
