import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sp_util.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;

class ConfigInfo {
  int theme = Colors.red.value;
}

class ConfigModel extends ConfigInfo with ChangeNotifier {
  Future $getTheme() async {
    int _theme = SPUtil.getInt('theme');
    print('config get Theme $_theme');
    if (null != _theme && 0 != _theme) {
      $setTheme(_theme);
    }
  }

  Future $setTheme(payload) async {
    theme = payload;
    SPUtil.putInt('theme', payload);
    notifyListeners();
  }
}
