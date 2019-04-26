import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:flutter_app/page/mine_page.dart';
import 'package:flutter_app/utils/route_util.dart';

class HomeDrawableHeader extends StatelessWidget {
  final bool isLogin;
  final String userName;
  final String email;
  final String avatar;

  HomeDrawableHeader(
      {Key key, this.isLogin, this.avatar, this.email, this.userName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      /// 姓名
      accountName: Text(userName),

      /// 邮箱
      accountEmail: Text(email),

      /// 用户头像
      currentAccountPicture: InkWell(
        child: CircleAvatar(
          backgroundImage: NetworkImage(avatar),
        ),
        onTap: () {
          if (isLogin) {
            Navigator.pop(context);
            pushNewPageBack(context, MinePage());
          } else {
            pushAndRemovePage(context, LoginPage());
          }
        },
      ),
      otherAccountsPictures: <Widget>[
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://t1.onvshen.com:85/gallery/27062/29572/s/0.jpg"),
          ),
          onTap: () {},
        ),
        GestureDetector(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://t1.onvshen.com:85/gallery/27062/29572/s/014.jpg"),
          ),
          onTap: () {},
        ),
      ],

      /// 装饰器 header区域的decoration，通常用来设置背景颜色或者背景图片
      decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
