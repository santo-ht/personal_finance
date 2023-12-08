import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;

class SharedPrefs {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();
}