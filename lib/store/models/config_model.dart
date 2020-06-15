import 'package:flutter/material.dart';

import '../../page_index.dart';

class ConfigModel extends ChangeNotifier {
  int _theme = Colors.red.value;
  int _localIndex = 0;

  void init() {
    _theme = SpUtil.getInt('theme', defValue: Colors.red.value);
    debugPrint('config get Theme $_theme');
    _localIndex = SpUtil.getInt('key_support_locale', defValue: 0);
    debugPrint('config get Local $_localIndex');
  }

  int get theme => _theme;

  void setTheme(theme) async {
    _theme = theme;
    SpUtil.setInt('theme', theme);
    notifyListeners();
  }

  int get localIndex => _localIndex;

  void setLocal(local) async {
    _localIndex = local;
    SpUtil.setInt('key_support_locale', local);
    notifyListeners();
  }
}
