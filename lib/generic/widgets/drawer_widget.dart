import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:personal_finance/accounts/pages/accounts_page.dart';
import 'package:personal_finance/config/app_config.dart';
import 'package:personal_finance/income/pages/income_page.dart';
import 'package:personal_finance/settings/pages/settings_page.dart';
import 'package:provider/provider.dart';

import '../../config/app_strings.dart';
import '../../lang/providers/english_string_provider.dart';
import '../../lang/providers/language_provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
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
        : SafeArea(
            child: Container(
              width: 300,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        //color: const Color(AppConfig.blueColor),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppConfig.logoImage,
                              height: 75,
                            ),
                            // userId == null

                            Text(
                              appStrings['app-title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                            // : Text(userId)
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(AccountsPage.routeName),
                        //Navigator.of(context).pushNamed(ProfilePage.routeName),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              const Icon(
                                MdiIcons.bank,
                                color: Color(
                                  AppConfig.blueColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(appStrings['accounts']),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(IncomePage.routeName),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              const Icon(
                                MdiIcons.bankTransferIn,
                                color: Color(
                                  AppConfig.blueColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(appStrings['income']),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        //Navigator.of(context).pushNamed(OrderPage.routeName),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: const [
                              Icon(
                                MdiIcons.cartOutline,
                                color: Color(
                                  AppConfig.blueColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Orders'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: const [
                            Icon(
                              MdiIcons.phoneOutline,
                              color: Color(
                                AppConfig.blueColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Contact Support'),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: const [
                            Icon(
                              MdiIcons.whatsapp,
                              color: Color(
                                AppConfig.blueColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Whatsapp'),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          children: const [
                            Icon(
                              MdiIcons.informationOutline,
                              color: Color(
                                AppConfig.blueColor,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('About'),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.of(context)
                            .pushNamed(SettingsPage.routeName, arguments: {
                          "appStrings": appStrings,
                          "lang": lang,
                        }),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: [
                              const Icon(
                                MdiIcons.apps,
                                color: Color(
                                  AppConfig.blueColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(appStrings['settings']),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(
                        thickness: 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              MdiIcons.facebook,
                              color: Color(AppConfig.blueColor),
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              MdiIcons.instagram,
                              color: Color(AppConfig.blueColor),
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              MdiIcons.youtube,
                              color: Color(AppConfig.blueColor),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
