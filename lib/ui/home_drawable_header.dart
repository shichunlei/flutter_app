import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/login_page.dart';
import '../page/mine_page.dart';
import '../page_index.dart';
import '../store/index.dart';

class HomeDrawableHeader extends StatelessWidget {
  HomeDrawableHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.connect<UserModel>(builder: (_, UserModel _data, __) {
      return UserAccountsDrawerHeader(

          /// 姓名
          accountName: Text('${_data.getName()}'),

          /// 邮箱
          accountEmail: Text('${_data.getEmail()}'),

          /// 用户头像
          currentAccountPicture: InkWell(
              child: Hero(
                  child: ImageLoadView('${_data.getAvatarPath()}',
                      shape: BoxShape.circle,
                      width: 80,
                      height: 80,
                      elevation: 10.0),
                  tag: 'user_avatar'),
              onTap: () {
                if (_data.isLogin()) {
                  Navigator.pop(context);
                  pushNewPageBack(context, MinePage());
                } else {
                  pushAndRemovePage(context, LoginPage());
                }
              }),
          otherAccountsPictures: <Widget>[
            GestureDetector(
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://wx1.sinaimg.cn/bmiddle/0060lm7Tgy1g2qrft0upcj30u01hcwpa.jpg")),
                onTap: () {}),
            GestureDetector(
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://wx1.sinaimg.cn/bmiddle/0060lm7Tgy1g2qrf51edvj30u01hbgse.jpg")),
                onTap: () {})
          ],

          /// 装饰器 header区域的decoration，通常用来设置背景颜色或者背景图片
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.2), BlendMode.multiply),
                image: NetworkImage(backgroundImage),
                fit: BoxFit.cover),
          ));
    });
  }
}
