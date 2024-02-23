import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";
  ThemeMode appTheme = ThemeMode.light;

  AppConfigProvider(bool isDark, bool isEN) {
    if (isDark) {
      appTheme == ThemeMode.dark;
    } else {
      appTheme == ThemeMode.light;
    }
    if (isEN) {
      appLanguage = "en";
    } else {
      appLanguage = "ar";
    }
  }

  void changeLanguage(String newLanguage) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    if (appLanguage == newLanguage) {
      sharedpref.setBool("isEN", true);
      return;
    }
    sharedpref.setBool("isEN", false);
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    if (appLanguage == newTheme) {
      sharedPref.setBool("isDark", true);
      return;
    }
    sharedPref.setBool("isDark", false);
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }
}
