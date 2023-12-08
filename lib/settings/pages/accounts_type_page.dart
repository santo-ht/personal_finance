import 'package:flutter/material.dart';
import 'package:personal_finance/settings/providers/accounts_type_provider.dart';
import 'package:personal_finance/settings/widgets/accounts_type_add_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/accounts_type_widget.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';

class AccountsTypePage extends StatefulWidget {
  static const routeName = '/accountsTypePage';

  const AccountsTypePage({super.key});
  @override
  AccountsTypePageState createState() => AccountsTypePageState();
}

class AccountsTypePageState extends State<AccountsTypePage> {
  bool isLoading = false;
  var appStrings, lang;
  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];

    setState(() {
      isLoading = true;
    });

    Provider.of<AccountsTypeProvider>(context, listen: false)
        .fetchSetAccountTypesFromDb(AppConfig.accountsTypeTable)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      // print(error);
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

    super.didChangeDependencies();
    // isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: Text(appStrings['account-types']),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: const AccountsTypeWidget(),
            floatingActionButton: AccountsTypeAddWidget(appStrings, lang),
          ));
  }
}
