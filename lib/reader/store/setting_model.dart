import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ReaderSettingModel extends ChangeNotifier {
  /// 页面背景
  Color _bgColor = colorMintCream;

  Color get bgColor => _bgColor;

  /// 左侧菜单（小说目录）背景色
  Color _drawerBgColor = Color(0xFA303030);

  Color get drawerBgColor => _drawerBgColor;

  /// AppBar高度，使用高度控制控件隐藏于显示
  double _appBarHeight = 0;

  double get appBarHeight => _appBarHeight;

  changeAppBarHeight() {
    _appBarHeight == Utils.navigationBarHeight
        ? _appBarHeight = 0.0
        : _appBarHeight = Utils.navigationBarHeight;
  }

  setAppBarHeight(double value) {
    _appBarHeight = value;
  }

  /// BottomBar高度，使用高度控制控件隐藏于显示
  double _bottomBarHeight = 0;

  double get bottomBarHeight => _bottomBarHeight;

  changeBottomBarHeight() {
    _bottomBarHeight == 0 ? _bottomBarHeight = 220.0 : _bottomBarHeight = 0;
  }

  setBottomBarHeight(double value) {
    _bottomBarHeight = value;
  }

  /// 字号
  double _textSize = 14;

  double get textSize => _textSize;

  changeTextSize(double value) {
    _textSize = value;
    notifyListeners();
  }

  /// 字间距
  double _spaceValue = 1.5;

  double get spaceValue => _spaceValue;

  spaceAdd() {
    _spaceValue = _spaceValue + 0.1;
    notifyListeners();
  }

  spaceMinus() {
    _spaceValue = _spaceValue - 0.1;
    notifyListeners();
  }

  ReaderTheme _themeType = ReaderTheme.moon;

  ReaderTheme get themeType => _themeType;

  IconData _themeIcon = Feather.moon;

  IconData get themeIcon => _themeIcon;

  Brightness _brightness = Brightness.dark;

  Brightness get brightness => _brightness;

  changeTheme() {
    if (_themeType == ReaderTheme.moon) {
      _themeType = ReaderTheme.sun;
      _bgColor = colorMintCream;
      _themeIcon = Feather.moon;
      _drawerBgColor = Color(0xFA303030);
    } else {
      _themeType = ReaderTheme.moon;
      _bgColor = Colors.black26;
      _themeIcon = Feather.sun;
      _drawerBgColor = colorSnow;
    }
    notifyListeners();
  }

  changeSettingView() {
    this.changeAppBarHeight();
    this.changeBottomBarHeight();

    _appBarHeight == 0
        ? _themeType == ReaderTheme.moon
            ? _brightness = Brightness.dark
            : _brightness = Brightness.light
        : _brightness = Brightness.dark;

    notifyListeners();
  }

  hiddenSettingView() {
    this.setBottomBarHeight(0.0);
    this.setAppBarHeight(0.0);
    notifyListeners();
  }

  showSettingView() {
    this.setBottomBarHeight(220.0);
    this.setAppBarHeight(Utils.navigationBarHeight);
    notifyListeners();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
