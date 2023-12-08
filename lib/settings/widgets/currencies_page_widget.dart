import 'package:flutter/material.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:provider/provider.dart';

import '../providers/currencies_provider.dart';

class CurrenciesPageWidget extends StatefulWidget {
  const CurrenciesPageWidget({super.key});

  @override
  CurrenciesPageWidgetState createState() => CurrenciesPageWidgetState();
}

class CurrenciesPageWidgetState extends State<CurrenciesPageWidget> {
  // final currenciesList = AppCurrencies.currencies;

  @override
  Widget build(BuildContext context) {
    final currenciesList =
        Provider.of<CurrenciesProvider>(context).fetchCurrenciesList;
    return currenciesList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${currenciesList[index].currencyName} (${currenciesList[index].currencyShortName})',
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        Text(
                          currenciesList[index].iconName,
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        //Text(String.fromCharCodes(a3)),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            itemCount: currenciesList.length,
          )
        : Container();
  }
}
