import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../page_index.dart';

class ConfigInfo {
  int theme = Colors.red.value;
}

class ConfigModel extends ConfigInfo with ChangeNotifier {
  Future $getTheme() async {
    int _theme = SpUtil.getInt('theme', defValue: Colors.red.value);
    print('config get Theme $_theme');
    if (null != _theme && 0 != _theme) {
      $setTheme(_theme);
    }
  }

  Future $setTheme(theme) async {
    this.theme = theme;
    SpUtil.setInt('theme', theme);
    notifyListeners();
  }
}
