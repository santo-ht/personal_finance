import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/config/app_strings.dart';
import '../widgets/currencies_page_widget.dart';
import '/config/app_config.dart';
import '../providers/currencies_provider.dart';
import '../widgets/currencies_add_widget.dart';

class CurrenciesPage extends StatefulWidget {
  static const routeName = '/currenciesPage';

  const CurrenciesPage({super.key});
  @override
  CurrenciesPageState createState() => CurrenciesPageState();
}

class CurrenciesPageState extends State<CurrenciesPage> {
  var isInit = true;
  bool isLoading = false;
  var appStrings, lang;
  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    appStrings = args['appStrings'];
    lang = args['lang'];
    if (isInit) {
      setState(() {
        isLoading = true;
      });

      Provider.of<CurrenciesProvider>(context)
          .fetchSetCurrenciesFromDb(AppConfig.currenciesTable)
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
    }
    super.didChangeDependencies();
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : SafeArea(
            child: Scaffold(
            appBar: AppBar(
              title: Text(appStrings['currencies']),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: const CurrenciesPageWidget(),
            floatingActionButton: CurrenciesAddWidget(appStrings, lang),
          ));
  }
}
