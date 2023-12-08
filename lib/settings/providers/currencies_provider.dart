import 'package:flutter/material.dart';
import 'package:personal_finance/utils/db_helper.dart';

import '../models/currencies_model.dart';

class CurrenciesProvider with ChangeNotifier {
  List<CurrenciesModel> currenciesList = [];

  Future<void> fetchSetCurrenciesFromDb(String tableName) async {
    final List<Map<String, dynamic>> dbVal =
        await DBHelper.getDataFromDB(tableName);
    if (dbVal.isNotEmpty) {
      List<CurrenciesModel> currenciesListLocal = [];
      for (int i = 0; i < dbVal.length; i++) {
        currenciesListLocal.add(CurrenciesModel(
          currencyId: dbVal[i]['currency_id'],
          currencyName: dbVal[i]['currency_name'],
          iconName: dbVal[i]['currency_icon'],
          currencyShortName: dbVal[i]['currency_short_name'],
        ));
      }
      currenciesList = currenciesListLocal;
      notifyListeners();
    }
  }

  List<CurrenciesModel> get fetchCurrenciesList {
    return [...currenciesList];
  }
}
