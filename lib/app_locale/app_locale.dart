import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocale {
  Locale locale;
  late SharedPreferences _prefs; // create object from sharedPreference to store the language


  AppLocale(this.locale) {
    _initPreferences(); // call it to initialize the sharedPreference when create appLocale
  }
  // the following method to initialize the sharedPreference
  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Map<String, String>? _loadedLocalizedValues;

  static AppLocale of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale)!;
  }

  Future<void> loadLang() async {
    // Ensure that SharedPreferences is initialized before accessing it
    await _initPreferences();
    String langCode = _prefs.getString('lang') ?? locale.languageCode;
    locale = Locale(langCode);
    String _langFile =
    await rootBundle.loadString('assets/lang/$langCode.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    Map<String, String> loadedLocalizedValues = _loadedValues.map(
            (key, value) => MapEntry(key, value.toString())) as Map<String, String>;
    _loadedLocalizedValues = loadedLocalizedValues;
  }

  String? getTranslated(String key) {
    if (_loadedLocalizedValues == null) {
      return null;
    }
    return _loadedLocalizedValues![key];
  }

  // the following method will use to update the language and set from initial
  Future<void> setLanguage(String languageCode) async {
    await _prefs.setString('lang', languageCode);
    await loadLang();
  }

  static const LocalizationsDelegate<AppLocale> delegate =
  _AppLocalDelegate();
}
// class inherit LocalizationDelegate
class _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLang();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}

String? getLang(BuildContext context, String key) {
  return AppLocale.of(context).getTranslated(key);
}
