import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:shared_preferences/shared_preferences.dart';

class ConfigInfo {
  int theme = Colors.red.value;
}

class ConfigModel extends ConfigInfo with ChangeNotifier {
  Future $getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int _theme = prefs.getInt('theme');
    print('config get Theme $_theme');
    if (null != _theme && 0 != _theme) {
      $setTheme(_theme);
    }
  }

  Future $setTheme(theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.theme = theme;
    prefs.setInt('theme', theme);
    notifyListeners();
  }
}
