import 'package:flutter/material.dart';
import 'package:personal_finance/config/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/lang/models/language_model.dart';

class LanguageProvider with ChangeNotifier {
  Future<void> setLanguage(String langSelected) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('languageSelected', langSelected);
  }

  Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('languageSelected');
  }

  List<LanguageModel> languageModelList = [
    LanguageModel(
      id: 1,
      languageCode: AppStrings.englishCode,
      languageDesc: AppStrings.englishDesc,
      isSelected: false,
    ),
    LanguageModel(
      id: 2,
      languageCode: AppStrings.spanishDesc,
      languageDesc: AppStrings.spanishDesc,
      isSelected: false,
    ),
    LanguageModel(
      id: 3,
      languageCode: AppStrings.frenchCode,
      languageDesc: AppStrings.frenchDesc,
      isSelected: false,
    ),
    /* LanguageModel(
      id: 4,
      languageCode: AppStrings.hindiCode,
      languageDesc: AppStrings.hindiDesc,
      isSelected: false,
    ), */
  ];

  List<LanguageModel> get fetchLanguageList {
    return [...languageModelList];
  }

  Future<String?> get fetchLanguageString async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic lang = prefs.getString('languageSelected');
    return lang;
  }
}
