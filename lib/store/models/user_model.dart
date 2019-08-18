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
            'http://hbimg.b0.upaiyun.com/63ddc018b96442eeb24c73f393f5ae066d58fb7e6607e-WScNBs_fw658');
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
