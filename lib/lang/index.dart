import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_app/lang/config.dart' as I18NConfig;
import 'package:flutter_app/utils/sp_util.dart';

class AppLocalizations {
  Locale _locale; // language
  static Function _setState; // setState
  static AppLocalizationsDelegate _delegate;
  static Map<String, dynamic> jsonLanguage;
  static AppLocalizations _inst; // inst

  AppLocalizations(this._locale);

  // init localizations
  static Future<AppLocalizations> init(Locale locale) async {
    _inst = AppLocalizations(locale);
    await getLanguageJson();
    return _inst;
  }

  // 设置语言切换代理
  static void setProxy(
      Function setState, AppLocalizationsDelegate delegate) async {
    _setState = setState;
    _delegate = delegate;
    print("_delegate = $_delegate");
  }

  static get languageCode => _inst._locale.languageCode;

  static Future getLanguageJson([Locale locale]) async {
    Locale _tmpLocale = _inst._locale;
    print(_tmpLocale.languageCode);
    String jsonLang;
    try {
      jsonLang =
          await rootBundle.loadString('local/${_tmpLocale.languageCode}.json');
    } catch (e) {
      _inst._locale = Locale(I18NConfig.LanguageConfig.defaultLanguage.code);
      jsonLang = await rootBundle.loadString(
          'local/${I18NConfig.LanguageConfig.defaultLanguage.code}.json');
    }
    json.decode(jsonLang);
    jsonLanguage = json.decode(jsonLang);
    print("当前语言： ${_inst._locale}");
    print("Json数据： ${jsonLanguage.toString()}");
  }

  static void changeLanguage([Locale locale]) {
    if (locale == null) {
      locale = AppLocalizations.languageCode == 'zh'
          ? Locale('en', "US")
          : Locale("zh", "CH");
    }
    _inst._locale = locale;
    SPUtil.putString('lang', locale.languageCode);
    getLanguageJson().then((v) {
      _setState(() {
        _delegate = AppLocalizationsDelegate(locale);
      });
    }); // 根据语言获取对应的国际化文件
  }

  // get local language
  _t(String key) {
    var _array = key.split('.');
    var _dict = jsonLanguage;
    var retValue = '';
    try {
      _array.forEach((item) {
        if (_dict[item].runtimeType == Null) {
          retValue = key;
          return;
        }
        if (_dict[item].runtimeType != String) {
          _dict = _dict[item];
        } else {
          retValue = _dict[item];
        }
      });
      retValue = retValue.isEmpty ? _dict : retValue;
    } catch (e) {
      print('i18n exception');
      print(e);
      retValue = key;
    }
    return retValue ?? '';
  }

  static String $t(String key) {
    return _inst._t(key);
  }
}

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
