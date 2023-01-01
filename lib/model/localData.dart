
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeSettingsModel extends ChangeNotifier {
  MyThemeSettingsModel({required this.sharedPreferences});
  final String key = "themessss";
  final SharedPreferences sharedPreferences;
  bool _isLightTheme = true;

  void changeThemesSettings() {
    _isLightTheme = sharedPreferences.getBool('themessss') ?? false;
    _isLightTheme = !_isLightTheme;
    sharedPreferences.setBool('themessss', _isLightTheme);
    notifyListeners();
  }

  bool? get isSettingsTheme {
    return sharedPreferences.getBool('themessss') != null
        ? sharedPreferences.getBool('themessss')
        : _isLightTheme;
  }
}

class MyThemeModeModel extends ChangeNotifier {
  MyThemeModeModel({required this.sharedPreferences});
  final String key = "themesss";
  final SharedPreferences sharedPreferences;
  bool _isLightTheme = true;

  void changeThemesMode() {
    _isLightTheme = sharedPreferences.getBool('themesss') ?? false;
    _isLightTheme = !_isLightTheme;
    sharedPreferences.setBool('themesss', _isLightTheme);
    notifyListeners();
  }

  bool? get isModeTheme {
    return sharedPreferences.getBool('themesss') != null
        ? sharedPreferences.getBool('themesss')
        : _isLightTheme;
  }
}
