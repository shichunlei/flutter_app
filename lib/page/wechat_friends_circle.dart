import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bean/friends_dynamic.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/ui/item_dynamic.dart';
import 'package:flutter_app/utils/utils.dart';

class WeChatFriendsCircle extends StatefulWidget {
  WeChatFriendsCircle({Key key}) : super(key: key);

  @override
  createState() => _WeChatFriendsCircleState();
}

class _WeChatFriendsCircleState extends State<WeChatFriendsCircle> {
  List<FriendsDynamic> friends_dynamic = [];

  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  Color c = Colors.grey;
  String title = '';

  @override
  void initState() {
    super.initState();

    getData();

    headerHeight = 250;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() => navAlpha = 0);
        }
      } else if (offset < headerHeight) {
        if (headerHeight - offset <= Utils.navigationBarHeight) {
          setState(() {
            c = Colors.black;
            title = '朋友圈';
          });
        } else {
          c = Colors.white;
          title = '';
        }
        setState(() => navAlpha = 1 - (headerHeight - offset) / headerHeight);
      } else if (navAlpha != 1) {
        setState(() => navAlpha = 1);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: scrollController,
              child: Column(children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                        child: ImageLoadView(backgroundImage,
                            fit: BoxFit.cover,
                            height: headerHeight,
                            width: Utils.width),
                        margin: EdgeInsets.only(bottom: 30.0)),
                    Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: Text('张三',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                              ),
                              ImageLoadView(
                                'http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg',
                                height: 70,
                                width: 70,
                                borderRadius: BorderRadius.circular(5.0),
                              )
                            ]),
                        margin: EdgeInsets.only(right: 10))
                  ],
                ),
                SizedBox(height: 10),
                ListView.builder(
                    itemBuilder: (context, index) =>
                        ItemDynamic(friends_dynamic[index]),
                    itemCount: friends_dynamic.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false)
              ]),
            ),
            Container(
              height: Utils.navigationBarHeight,
              child: AppBar(
                titleSpacing: 0,
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context)),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.add_a_photo), onPressed: () {})
                ],
                iconTheme: IconThemeData(color: c, size: 20),
                elevation: 0.0,
                backgroundColor:
                    Color.fromARGB((navAlpha * 255).toInt(), 180, 180, 180),
                title: Text(title,
                    style: TextStyle(
                        fontSize: 16.0,
                        color:
                            Color.fromARGB((navAlpha * 255).toInt(), 0, 0, 0))),
              ),
            )
          ],
        ));
  }

  void getData() async {
    rootBundle.loadString('assets/data/friends.json').then((value) {
      friends_dynamic = FriendsDynamic.fromMapList(json.decode(value));
      setState(() {});
    });
  }
}
