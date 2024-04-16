import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale {
  Locale locale;

  AppLocale(this.locale);

  Map<String, String>? _loadedLocalizedValues;

  static AppLocale of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale)!;
  }

  Future<void> loadLang() async {
    String _langFile =
    await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) =>
        MapEntry(key, value.toString())) as Map<String, String>;
  }

  String? getTranslated(String key) {
    if (_loadedLocalizedValues == null) {
      // Handle the case where translations haven't been loaded yet
      return null;
    }
    return _loadedLocalizedValues![key];
  }

  static const LocalizationsDelegate<AppLocale> delegate =
  _AppLocalDelegate();
}

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
