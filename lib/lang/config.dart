import 'package:flutter/material.dart';

class LanguageConfig {
  static List<Locale> supportedLocales = [
    Locale('zh', 'CH'),
    Locale('en', 'US')
  ];

  static Map<String, dynamic> supportLanguage = {
    "zh": {"code": "zh", "country_code": "CH"},
    "en": {"code": "en", "country_code": "US"},
  };

  static dynamic defaultLanguage = {"code": "zh", "country_code": "CH"};
}
