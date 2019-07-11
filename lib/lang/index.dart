import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/utils/sp_util.dart';
import '../delegates/app_localizations_delegate.dart';

import '../lang/config.dart' as I18NConfig;

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
    debugPrint("_delegate = $_delegate");
  }

  static get languageCode => _inst._locale.languageCode;

  static Future getLanguageJson([Locale locale]) async {
    Locale _tmpLocale = _inst._locale;
    debugPrint(_tmpLocale.languageCode);
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
    debugPrint("当前语言： ${_inst._locale}");
    debugPrint("Json数据： ${jsonLanguage.toString()}");
  }

  static void changeLanguage([Locale locale]) async {
    if (locale == null) {
      locale = AppLocalizations.languageCode == 'zh'
          ? Locale('en', "US")
          : Locale("zh", "CH");
    }
    _inst._locale = locale;
    SpUtil.setString('lang', locale.languageCode);
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
      debugPrint('i18n exception');
      debugPrint(e);
      retValue = key;
    }
    return retValue ?? '';
  }

  static String $t(String key) {
    return _inst._t(key);
  }
}
