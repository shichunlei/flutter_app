import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

import '../../page_index.dart';

class ConfigModel extends ChangeNotifier {
  int _theme = Colors.red.value;
  int _local = 0;

  get theme => _theme;

  get local => _local;

  $initTheme() async {
    int _theme = SpUtil.getInt('theme', defValue: Colors.red.value);
    print('config get Theme $_theme');
    if (null != _theme && 0 != _theme) {
      $setTheme(_theme);
    }
  }

  $setTheme(theme) async {
    _theme = theme;
    SpUtil.setInt('theme', _theme);
    notifyListeners();
  }

  $initLocal() async {
    int _local = SpUtil.getInt('key_support_locale', defValue: 0);
    print('config get Local $_local');
    if (null != _local && 0 != _local) {
      $setLocal(_local);
    }
  }

  $setLocal(local) async {
    _local = local;
    SpUtil.setInt('key_support_locale', _local);
    notifyListeners();
  }
}
