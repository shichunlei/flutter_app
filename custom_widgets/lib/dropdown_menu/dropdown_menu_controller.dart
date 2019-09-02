import 'package:flutter/foundation.dart';

class DropdownMenuController extends ChangeNotifier {
  double dropDownHearderHeight;

  int menuIndex = 0;

  bool isShow = false;

  void show(int index) {
    isShow = true;
    menuIndex = index;
    notifyListeners();
  }

  void hide() {
    isShow = false;
    notifyListeners();
  }
}
