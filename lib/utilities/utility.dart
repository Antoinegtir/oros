// ignore_for_file: avoid_print, deprecated_member_use, prefer_if_null_operators

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utility {
  static launchURL(String url) async {
    await launch(url);
  }
}

class MyThemeModel extends ChangeNotifier {
  MyThemeModel({required this.sharedPreferences});
  final String key = "theme";
  final SharedPreferences sharedPreferences;
  bool _isLightTheme = true;

  void changeTheme() {
    _isLightTheme = sharedPreferences.getBool('theme') ?? false;
    _isLightTheme = !_isLightTheme;
    sharedPreferences.setBool('theme', _isLightTheme);
    notifyListeners();
  }

  bool? get isAnimated {
    return sharedPreferences.getBool('theme') != null
        ? sharedPreferences.getBool('theme')
        : _isLightTheme;
  }
}
