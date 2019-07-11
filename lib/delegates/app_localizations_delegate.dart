import 'package:flutter/material.dart';
import '../lang/index.dart';

import '../lang/config.dart' as I18NConfig;
import '../page_index.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale locale;

  AppLocalizationsDelegate([this.locale]);

  @override
  bool isSupported(Locale locale) {
    return I18NConfig.LanguageConfig.supportLanguage.keys
        .toList()
        .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale _locale) async {
    String lang = SpUtil.getString('lang');
    Locale __locale = locale ?? _locale;
    if (null != lang && '' != lang) {
      __locale = Locale(lang);
    }
    return await AppLocalizations.init(__locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    // false时 不执行上述重写函数
    return false;
  }
}
