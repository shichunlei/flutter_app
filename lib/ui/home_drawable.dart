import 'package:flutter/material.dart';
import 'package:flutter_app/contact/page/contact_list_page.dart';
import 'package:flutter_app/lang/index.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:package_info/package_info.dart';

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

  String appName;
  String packageName;
  String version;
  String buildNumber;

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
    isLogin = SPUtil.getBool("isLogin");

    userName = isLogin ? "SCL" : "未登录";
    email = isLogin ? "1558053958@qq.com" : "";
    avatar = isLogin
        ? "http://hbimg.b0.upaiyun.com/63ddc018b96442eeb24c73f393f5ae066d58fb7e6607e-WScNBs_fw658"
        : "https://user-gold-cdn.xitu.io/2019/1/27/1688f8ce3151738a?imageView2/1/w/180/h/180/q/85/format/webp/interlace/1";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 10.0,
        child: _bulderMenuView(),
        semanticLabel: AppLocalizations.$t('menu'));
  }

  Widget _bulderMenuView() {
    return ListView(children: <Widget>[
      HomeDrawableHeader(
          isLogin: isLogin, avatar: avatar, userName: userName, email: email),
      Divider(),
      ListTile(
          title: Text("${AppLocalizations.$t('poetry')}"),
          leading: Icon(Icons.book),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            pushNewPageBack(context, RandomPoetryPage());
          }),
      Divider(),
      ListTile(
        title: Text(AppLocalizations.$t('contact')),
        leading: Icon(Icons.supervisor_account),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).pop();
          pushNewPageBack(context, ContactListPage());
        },
      ),
      Divider(),
      AboutListTile(
        icon: CircleAvatar(
            child: Icon(
              Icons.update,
              color: Colors.white,
              size: 20.0,
            ),
            maxRadius: 15),
        child: Row(
          children: <Widget>[
            Text(AppLocalizations.$t('update')),
            Icon(Icons.chevron_right),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        applicationName: '${appName}',
        applicationIcon: Image.asset(
          'images/flutter_logo.png',
          width: 64.0,
          height: 64.0,
        ),
        applicationVersion: '${version}',
        //版本号，默认为空
        applicationLegalese: '版权所有：${userName}',
        aboutBoxChildren: <Widget>[Text("BoxChildren"), Text("box child 2")],
      ),
      Divider(),
      ListTile(
          title: Text(AppLocalizations.$t('exit')),
          leading: Icon(Icons.exit_to_app),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                      title: Text("退出账号"),
                      content: Text("您确定要退出账号吗？"),
                      actions: <Widget>[
                        FlatButton(
                            child: Text("退出"),
                            onPressed: () {
                              SPUtil.remove('isLogin');
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
          title: Text(AppLocalizations.$t('setting')),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            pushNewPageBack(context, SettingPage());
          }),
      Divider(),
    ]);
  }

  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });

    print(
        'APP名称：$appName-====包名：$packageName=====版本名：$version======版本号：$buildNumber');
  }
}
