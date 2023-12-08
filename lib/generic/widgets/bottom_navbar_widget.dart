import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:personal_finance/budgets/pages/budgets_page.dart';
import 'package:personal_finance/expenses/pages/expenses_page.dart';
import 'package:personal_finance/goals/pages/goals_page.dart';
import 'package:personal_finance/home_page.dart';
import 'package:personal_finance/transactions/pages/trans_page.dart';

import '../../config/app_strings.dart';
import '../../utils/hex_color.dart';
import '/lang/providers/english_string_provider.dart';

import 'package:provider/provider.dart';

import '/lang/providers/language_provider.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int loadIndex, currentPosition;
  const BottomNavBarWidget(this.loadIndex, this.currentPosition, {super.key});
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int? _selectedIndex;
  var appStrings;
  bool isLoading = false;
  var userDetails;
  bool isInit = true;
  String? lang;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.loadIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          isInit = false;
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void _tabPress(int position) {
      if (position == 0 && widget.currentPosition != 0) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      } else if (position == 1 && widget.currentPosition != 1) {
        //Navigator.of(context).pushReplacementNamed(ExamsPage.routeName);
        Navigator.of(context).pushReplacementNamed(TransPage.routeName);
      } else if (position == 2 && widget.currentPosition != 2) {
        Navigator.of(context).pushReplacementNamed(
          GoalsPage.routeName,
        );
      } else if (position == 3 && widget.currentPosition != 3) {
        Navigator.of(context).pushReplacementNamed(
          BudgetsPage.routeName,
          //ProfilePage.routeName,
        );
        //Navigator.of(context).pushReplacementNamed(AccountPage.routeName);
      }
    }

    return (isLoading
        ? Container()
        : BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            //HexColor("#5669FF"),
            selectedLabelStyle: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.bold),
            unselectedItemColor: HexColor("#858585"),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _selectedIndex!,

/*   labelColor: HexColor("#5669FF"),
          unselectedLabelColor: HexColor("#858585"),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5.0),
          indicatorColor: Colors.transparent,
          labelPadding: const EdgeInsets.all(0.0),
          tabs: _homeTabs,
          labelStyle:
              GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.bold),
          //TextStyle(fontSize: 15, fontFamily: 'Roboto'),
          unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 13), */

            onTap: (indexVal) => _tabPress(indexVal),
            items: [
              BottomNavigationBarItem(
                activeIcon: const Icon(
                  Icons.home,
                  size: 30.0,
                  color: Colors.black,
                  // HexColor("#5669FF"),
                ),
                icon: Icon(
                  Icons.home,
                  size: 30.0,
                  color: HexColor("#858585"),
                ),
                label: appStrings['home'],
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(
                  MdiIcons.cashRegister,
                  size: 30.0,
                  color: Colors.black,
                  // HexColor("#5669FF"),
                ),
                icon: Icon(
                  MdiIcons.cashRegister,
                  size: 30.0,
                  color: HexColor("#858585"),
                ),
                label: appStrings['transactions'],
              ),
              BottomNavigationBarItem(
                activeIcon: const Icon(
                  MdiIcons.timer,
                  size: 30.0,
                  color: Colors.black,
                  //HexColor("#5669FF"),
                ),
                icon: Icon(
                  MdiIcons.timer,
                  size: 30.0,
                  color: HexColor("#858585"),
                ),
                label: appStrings['goals'],
              ),
              BottomNavigationBarItem(
                activeIcon:
                    /*   const ImageIcon(
                  AssetImage("assets/community/community.png"),
                ), */
                    const Icon(
                  MdiIcons.cashMultiple,
                  size: 30.0,
                  color: Colors.black,
                  // HexColor("#5669FF"),
                ),
                icon: /* const ImageIcon(
                  AssetImage("assets/community/community_grey.png"),
                ), */
                    Icon(
                  MdiIcons.cashMultiple,
                  size: 30.0,
                  color: HexColor("#858585"),
                ),
                label: appStrings['budgets'],
                //appStrings['account'],
              ),
            ],
          ));
    // : BottomAppBar());
  }
}
