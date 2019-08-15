import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/contact/page/contact_list_page.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:flutter_app/ui/update_dialog.dart';
import 'package:path_provider/path_provider.dart';

import '../page_index.dart';

class HomeDrawable extends StatefulWidget {
  HomeDrawable({Key key}) : super(key: key);

  @override
  _HomeDrawableState createState() => _HomeDrawableState();
}

class _HomeDrawableState extends State<HomeDrawable> {
  bool isLogin;
  String userName;
  String email;
  String avatar;

  @override
  void initState() {
    super.initState();

    isLogin = SpUtil.getBool("isLogin", defValue: false);

    userName = isLogin ? "SCL" : "未登录";
    email = isLogin ? "1558053958@qq.com" : "";
    avatar = isLogin
        ? "http://hbimg.b0.upaiyun.com/63ddc018b96442eeb24c73f393f5ae066d58fb7e6607e-WScNBs_fw658"
        : "https://user-gold-cdn.xitu.io/2019/1/27/1688f8ce3151738a?imageView2/1/w/180/h/180/q/85/format/webp/interlace/1";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          HomeDrawableHeader(
              isLogin: isLogin,
              avatar: avatar,
              userName: userName,
              email: email),
          Divider(),
          ListTile(
              title: Text("${S.of(context).poetry}"),
              leading: Icon(Icons.book),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                pushNewPageBack(context, RandomPoetryPage());
              }),
          Divider(),
          ListTile(
              title: Text(S.of(context).contact),
              leading: Icon(Icons.supervisor_account),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                pushNewPageBack(context, ContactListPage());
              }),
          Divider(),
          ListTile(
              title: Text(S.of(context).update),
              leading: Icon(Icons.update),
              trailing: Icon(Icons.chevron_right),
              onTap: () async {
                Directory appDocDir = await getApplicationDocumentsDirectory();
                String appDocPath = appDocDir.path;

                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return UpdateDialog(
                        url:
                            'https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg',
                        savePath: "${appDocPath.toString()}/temp.jpg",
                      );
                    });
              }),
          Divider(),
          ListTile(
              title: Text(S.of(context).exit),
              leading: Icon(Icons.exit_to_app),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text("退出账号"),
                          content: Text("您确定要退出账号吗？"),
                          actions: <Widget>[
                            FlatButton(
                                child: Text("退出"),
                                onPressed: () {
                                  SpUtil.remove('isLogin');
                                  pushAndRemovePage(context, LoginPage());
                                }),
                            FlatButton(
                                child: Text("再想想",
                                    style: Theme.of(context).textTheme.button),
                                onPressed: () => Navigator.of(context).pop())
                          ]);
                    });
              }),
          Divider(),
          ListTile(
              title: Text(S.of(context).setting),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).pop();
                pushNewPageBack(context, SettingPage());
              }),
          Divider(),
        ],
      ),
    );
  }
}
