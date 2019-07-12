import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../page_index.dart';

class ConfigInfo {
  int theme = Colors.red.value;
  int local = 0;
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

  Future $getLocal() async {
    int _local = SpUtil.getInt('key_support_locale', defValue: 0);
    print('config get Local $_local');
    if (null != _local && 0 != _local) {
      $setLocal(_local);
    }
  }

  Future $setLocal(local) async {
    this.local = local;
    SpUtil.setInt('key_support_locale', local);
    notifyListeners();
  }
}
