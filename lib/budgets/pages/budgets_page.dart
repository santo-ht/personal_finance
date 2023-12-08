import 'package:flutter/material.dart';

import 'package:personal_finance/generic/widgets/bottom_navbar_widget.dart';
import 'package:personal_finance/generic/widgets/drawer_widget.dart';
import 'package:personal_finance/config/app_strings.dart';
import 'package:personal_finance/lang/providers/english_string_provider.dart';
import 'package:personal_finance/lang/providers/language_provider.dart';
import 'package:provider/provider.dart';

import '../../config/app_theme.dart';

class BudgetsPage extends StatefulWidget {
  static const routeName = '/budgetsPage';

  const BudgetsPage({super.key});
  @override
  State<BudgetsPage> createState() => BudgetsPageState();
}

class BudgetsPageState extends State<BudgetsPage> {
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
                appStrings['budgets'],
                style: appPrimaryTheme().textTheme.titleLarge,
              ),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              child: const Text('Hi'),
            ),
            bottomNavigationBar: const BottomNavBarWidget(3, 3),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            drawer: const DrawerWidget(),
          );
  }
}
