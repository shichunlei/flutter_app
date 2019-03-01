import 'dart:convert';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/contact/model/contact.dart';
import 'package:flutter_app/contact/page/contact_page.dart';
import 'package:flutter_app/contact/ui/contact_list_header.dart';
import 'package:flutter_app/contact/ui/suspension_tag.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:azlistview/azlistview.dart';

class ContactListPage extends StatefulWidget {
  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  List<Contact> _contacts = [];

  int _suspensionHeight = 40;
  int _itemHeight = 60;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通讯录"),
        elevation: 0.0,
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: AzListView(
        data: _contacts,
        itemBuilder: (context, model) => _buildListItem(model),
        header: AzListViewHeader(
          height: 220,
          builder: (context) => Diagonal(
                axis: Axis.horizontal,
                position: DiagonalPosition.BOTTOM_LEFT,
                clipHeight: 50.0,
                child: ContactListHeader(name: "SCL", phone: "18601952581"),
              ),
        ),
        isUseRealIndex: true,
        itemHeight: _itemHeight,
        suspensionHeight: _suspensionHeight,
        indexBarBuilder: (BuildContext context, List<String> tags,
            IndexBarTouchCallback onTouch) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.grey[300], width: .5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: IndexBar(
                data: tags,
                itemHeight: 20,
                onTouch: (details) {
                  onTouch(details);
                },
              ),
            ),
          );
        },
        indexHintBuilder: (context, hint) {
          return Container(
            alignment: Alignment.center,
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.blue[700].withAlpha(200),
              shape: BoxShape.circle,
            ),
            child: Text(hint,
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          );
        },
      ),
    );
  }

  void getContacts() async {
    /// 读取本地json文件，获取联系人信息
    rootBundle.loadString('assets/data/contacts.json').then((value) {
      List list = json.decode(value);
      list.forEach((value) {
        _contacts.add(Contact(
            name: value['name'],
            phone: value['phone'],
            avatar: value['avatar']));
      });

      _handleList(_contacts);
      setState(() {});
    });
  }

  void _handleList(List<Contact> contacts) {
    if (contacts == null || contacts.isEmpty) return;
    for (int i = 0, length = contacts.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(contacts[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      contacts[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        contacts[i].tagIndex = tag;
      } else {
        contacts[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_contacts);
  }

  Widget _buildListItem(Contact model) {
    String susTag = model.getSuspensionTag();
    return Column(children: <Widget>[
      Offstage(
          offstage: model.isShowSuspension != true,
          child: SuspensionTag(susTag: susTag, susHeight: _suspensionHeight)),
      SizedBox(
          height: _itemHeight.toDouble(),
          child: ListTile(
              leading: model.avatar == ""
                  ? CircleAvatar(child: Text(model.name[0]))
                  : CircleAvatar(
                      backgroundImage: NetworkImage(model.avatar),
                    ),
              title: Text(model.name),
              onTap: () => pushNewPage(
                  context,
                  ContactPage(
                    name: model.name,
                    phone: model.phone,
                    avatar: model.avatar,
                  ))))
    ]);
  }
}
