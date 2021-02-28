import 'dart:convert';

import 'package:flutter_app/page_index.dart';

class UserRepository {
  /// 登录
  ///
  /// [email] 邮箱
  /// [password] 密码
  ///
  static Future<User> login(String email, String password) async {
    Response response = await HttpUtils().request(ApiUrl.LOGIN,
        data: {'email': email, 'password': password}, method: HttpUtils.POST);
    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      BaseResult result = BaseResult.fromMap(json.decode(response.data));

      if (result.code == '0') {
        return User.fromMap(result.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// 修改头像
  ///
  /// [data] 数据
  ///
  static Future<User> updateAvatar(FormData data) async {
    Response response =
        await HttpUtils().uploadFile(ApiUrl.UPDATE_AVATAR, data: data);

    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      BaseResult result = BaseResult.fromMap(response.data);

      if (result.code == '0') {
        return User.fromMap(result.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
