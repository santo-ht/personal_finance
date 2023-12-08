import 'package:flutter/material.dart';
import 'package:personal_finance/settings/providers/expenses_type_provider.dart';
import 'package:personal_finance/settings/widgets/expenses_type_add_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/expenses_type_widget.dart';
import '/config/app_strings.dart';
import '/config/app_config.dart';

class ExpensesTypePage extends StatefulWidget {
  static const routeName = '/expensesTypePage';

  const ExpensesTypePage({super.key});
  @override
  ExpensesTypePageState createState() => ExpensesTypePageState();
}

class ExpensesTypePageState extends State<ExpensesTypePage> {
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

    Provider.of<ExpensesTypeProvider>(context, listen: false)
        .fetchSetExpensesTypeFromDb(AppConfig.expensesTypeTable)
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
              title: Text(appStrings['expense-types']),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: const ExpensesTypeWidget(),
            floatingActionButton: ExpensesTypeAddWidget(appStrings, lang),
          ));
  }
}
