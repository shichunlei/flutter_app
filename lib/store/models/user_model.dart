import 'package:flutter/material.dart';

import '../../page_index.dart';

class UserModel extends ChangeNotifier {
  bool isLogin() {
    bool isLogin = SpUtil.getBool('isLogin', defValue: false);
    debugPrint('================getIsLogin()---$isLogin');
    return isLogin;
  }

  String getName() {
    String name = SpUtil.getString('name', defValue: 'SCL');
    debugPrint('================getName()---$name');
    return name;
  }

  String getEmail() {
    String _email = SpUtil.getString('email', defValue: '');
    debugPrint('================getEmail()---$_email');
    return _email;
  }

  String getAvatarPath() {
    String _avatarPath = SpUtil.getString('avatarPath',
        defValue:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571745949856&di=19adcf4537b23919f479d7348e065c12&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F09%2F20180709235634_HEh8H.thumb.700_0.jpeg');
    debugPrint('================getAvatarPath()---$_avatarPath');

    return _avatarPath;
  }

  bool isLocal() {
    bool _isLocal = SpUtil.getBool('isLocal', defValue: false);

    debugPrint('================getIsLocal()---$_isLocal');

    return _isLocal;
  }

  setUser({
    String name,
    String email,
    String avatarPath,
    bool isLocalImage,
  }) async {
    String _name = name ?? getName();
    String _email = email ?? getEmail();
    String _avatarPath = avatarPath ?? getAvatarPath();
    bool _isLocal = isLocalImage ?? isLocal();

    debugPrint(
        '========setUser()---$_name|====|$_email|---|$_avatarPath|=-=-=-=-|$_isLocal');

    SpUtil.setString('name', _name);
    SpUtil.setString('email', _email);
    SpUtil.setString('avatarPath', _avatarPath);
    SpUtil.setBool('isLocal', _isLocal);
    notifyListeners();
  }

  initLogin(bool value) async {
    bool _isLogin = value ?? isLogin();

    debugPrint('================initLogin()---$_isLogin');

    SpUtil.setBool('isLogin', _isLogin);
    notifyListeners();
  }

  cleanUserInfo() async {
    SpUtil.remove('isLogin');
    SpUtil.remove('isLocal');
    SpUtil.remove('avatarPath');
    SpUtil.remove('email');
    SpUtil.remove('name');

    debugPrint('================cleanUserInfo()');

    notifyListeners();
  }
}
