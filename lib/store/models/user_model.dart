import 'package:flutter/material.dart';
import 'package:flutter_app/bean/user.dart';

import '../../page_index.dart';

class UserModel extends ChangeNotifier {
  bool isLogin() {
    bool isLogin = SpUtil.getBool('isLogin', defValue: false);
    debugPrint('================getIsLogin()---$isLogin');
    return isLogin;
  }

  String getName() {
    String name = SpUtil.getString('name', defValue: '未填写');
    debugPrint('================getName()---$name');
    return name;
  }

  String getEmail() {
    String _email = SpUtil.getString('email', defValue: '');
    debugPrint('================getEmail()---$_email');
    return _email;
  }

  String getMobile() {
    String mobile = SpUtil.getString('mobile', defValue: '未填写');
    debugPrint('================getMobile()---$mobile');
    return mobile;
  }

  int getUserId() {
    int id = SpUtil.getInt('id', defValue: -1);
    debugPrint('================getUserId()---$id');
    return id;
  }

  String getAvatarPath() {
    String _avatarPath = SpUtil.getString('avatarPath',
        defValue:
            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571745949856&di=19adcf4537b23919f479d7348e065c12&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201807%2F09%2F20180709235634_HEh8H.thumb.700_0.jpeg');
    debugPrint('================getAvatarPath()---$_avatarPath');

    return _avatarPath;
  }

  Future<User> getUser() async {
    String name = SpUtil.getString('name', defValue: '未填写');
    String email = SpUtil.getString('email', defValue: '');
    String mobile = SpUtil.getString('mobile', defValue: '未填写');
    String avatarPath = SpUtil.getString('avatarPath', defValue: '');
    int id = SpUtil.getInt('id', defValue: -1);
    User user = User(
        name: name,
        email: email,
        avatarUrl: avatarPath,
        id: id,
        mobile: mobile);

    return user;
  }

  void setUser({
    int id,
    String name,
    String email,
    String mobile,
    String avatarPath,
    bool login,
  }) async {
    User user = await getUser();

    String _name = name ?? user.name;
    String _email = email ?? user.email;
    String _avatarPath = avatarPath ?? user.avatarUrl;
    String _mobile = mobile ?? user.mobile;
    bool _isLogin = login ?? isLogin();
    int _id = id ?? user.id;

    debugPrint(
        '========setUser()---$_name|====|$_email|---|$_avatarPath|=-=-=-=-|$_isLogin');

    SpUtil.setInt('id', _id);
    SpUtil.setString('name', _name);
    SpUtil.setString('mobile', _mobile);
    SpUtil.setString('email', _email);
    SpUtil.setString('avatarPath', _avatarPath);
    SpUtil.setBool('isLogin', _isLogin);
    notifyListeners();
  }

  void cleanUserInfo() async {
    SpUtil.remove('isLogin');
    SpUtil.remove('avatarPath');
    SpUtil.remove('email');
    SpUtil.remove('name');
    SpUtil.remove('mobile');
    SpUtil.remove('id');

    debugPrint('================cleanUserInfo()');

    notifyListeners();
  }
}
