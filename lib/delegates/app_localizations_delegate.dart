import 'package:flutter/material.dart';
import '../lang/index.dart';
import '../utils/sp_util.dart';

import '../lang/config.dart' as I18NConfig;

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
    String lang = SPUtil.getString('lang');
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
