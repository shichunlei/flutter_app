import 'package:flutter/material.dart';

import '../../page_index.dart';

class ConfigModel extends ChangeNotifier {
  int getTheme() {
    int theme = SpUtil.getInt('theme', defValue: Colors.red.value);
    debugPrint('config get Theme $theme');
    return theme;
  }

  $setTheme(theme) async {
    SpUtil.setInt('theme', theme);
    notifyListeners();
  }

  int getLocal() {
    int local = SpUtil.getInt('key_support_locale', defValue: 0);
    debugPrint('config get Local $local');
    return local;
  }

  $setLocal(local) async {
    SpUtil.setInt('key_support_locale', local);
    notifyListeners();
  }
}
