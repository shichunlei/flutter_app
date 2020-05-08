import 'package:flutter/material.dart';
import 'package:flutter_app/contact/page/contact_list_page.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:flutter_app/store/index.dart';

import '../page_index.dart';
import 'update_dialog.dart';

class HomeDrawable extends StatelessWidget {
  HomeDrawable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          HomeDrawableHeader(),
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
                var apkPath =
                    await FileUtil.getInstance().getFolderPath('apk/');

                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => UpdateDialog(
                      url:
                          'https://qd.myapp.com/myapp/qqteam/AndroidQQi/qq_6.0.1.6600_android_r25029_GuanWang_537057608_release.apk',
                      savePath: apkPath + "temp.apk"),
                );
              }),
          Divider(),
          ListTile(
              title: Text(S.of(context).exit),
              leading: Icon(Icons.exit_to_app),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Store.value<UserModel>(context, listen: false).cleanUserInfo();
                Navigator.of(context).pop();
                pushAndRemovePage(context, LoginPage());
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
