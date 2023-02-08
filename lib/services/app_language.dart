import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { lo, en, zh }

class AppLanguage extends ChangeNotifier {
  static Locale _appLocale = const Locale('lo');

  Locale get appLocal => _appLocale;
  static Locale get appLocalStt => _appLocale;
  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = const Locale('lo');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return Null;
  }

  Future<void> changeLanguage(Language language) async {
    var prefs = await SharedPreferences.getInstance();
    // if (_appLocale == type) {
    //   return;
    // }
    if (language == Language.lo) {
      _appLocale = const Locale("lo");
      await prefs.setString('language_code', 'lo');
      await prefs.setString('countryCode', 'LA');
    } else if (language == Language.zh) {
      _appLocale = const Locale("zh");
      await prefs.setString('language_code', 'zh');
      await prefs.setString('countryCode', 'CN');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }

    notifyListeners();
  }
}
