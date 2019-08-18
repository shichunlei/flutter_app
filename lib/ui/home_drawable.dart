import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/contact/page/contact_list_page.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:flutter_app/store/index.dart';
import 'package:path_provider/path_provider.dart';

import '../page_index.dart';
import 'update_dialog.dart';

class HomeDrawable extends StatelessWidget {
  HomeDrawable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: <Widget>[
          HomeDrawableHeader(),
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
                    builder: (context) => UpdateDialog(
                        url:
                            'https://cdn.jsdelivr.net/gh/flutterchina/flutter-in-action@1.0/docs/imgs/book.jpg',
                        savePath: "${appDocPath.toString()}/temp.jpg"));
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
                                  Store.value<UserModel>(context)
                                      .cleanUserInfo();
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
