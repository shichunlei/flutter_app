import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/utils/sp_util.dart';
import 'package:rxdart/rxdart.dart';

class SettingBloc extends BaseBloc {
  Color _color = themeColors[SPUtil.getInt('themeIndex')];

  Color get color => _color;

  BehaviorSubject<Color> _colorController = BehaviorSubject();

  Observable<Color> get colorStream => Observable(_colorController.stream);

  /// 切换主题通知刷新
  switchTheme(int themeIndex) {
    _color = themeColors[themeIndex];
    _colorController.add(_color);
  }

  @override
  void dispose() {
    _colorController?.close();
  }
}
