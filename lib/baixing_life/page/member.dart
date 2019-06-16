import 'dart:ui';

import 'package:flutter/material.dart';
import '../page/order_home_page.dart';
import '../ui/IconText.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../page_index.dart';
import 'address/address_page.dart';

class MemberPage extends StatefulWidget {
  final String title;

  MemberPage(this.title, {Key key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  var avatarImage =
      'https://wx1.sinaimg.cn/bmiddle/0060lm7Tgy1g2qrfsns92j30u013y0x3.jpg';

  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  String _phone = '0393-8800315';

  @override
  void initState() {
    super.initState();

    headerHeight = 170.0;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < headerHeight) {
        setState(() {
          navAlpha = 1 - (headerHeight - offset) / headerHeight;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
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
        backgroundColor: Colors.grey[200],
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(children: <Widget>[
                _buildHeader(),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      ListTile(
                        title: Text('我的订单'),
                        onTap: () => pushNewPage(context, OrderHomePage()),
                        leading: Icon(CustomIcon.order),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Container(height: 0.5, color: Colors.grey[200]),
                      Row(
                        children: orderTitles.map((title) {
                          int index = orderTitles.indexOf(title);
                          if (index > 0) {
                            return Expanded(
                                child: IconText(
                                    onPressed: () => pushNewPage(
                                        context, OrderHomePage(index: index)),
                                    text: '${title['title']}',
                                    icon: title['icon']));
                          }
                          return Container();
                        }).toList(),
                      )
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      ListTile(
                        title: Text('优惠券'),
                        onTap: () {
                          Toast.show('优惠券', context);

                          /// TODO
                        },
                        leading: Icon(CustomIcon.coupon),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                      Container(height: 0.5, color: Colors.grey[200]),
                      ListTile(
                          title: Text('收货地址'),
                          onTap: () => pushNewPage(context, AddressPage()),
                          leading: Icon(CustomIcon.address),
                          trailing: Icon(Icons.keyboard_arrow_right))
                    ])),
                Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      ListTile(
                          title: Text('客服电话'),
                          onTap: () => Utils.launchURL('tel:$_phone'),
                          leading: Icon(CustomIcon.custom_service),
                          trailing: Row(children: <Widget>[
                            Text(_phone),
                            SizedBox(width: 10.0),
                            Icon(Icons.keyboard_arrow_right)
                          ], mainAxisSize: MainAxisSize.min)),
                      Container(height: 0.5, color: Colors.grey[200]),
                      ListTile(
                          title: Text('关于商城'),
                          onTap: () {
                            /// TODO
                            Toast.show('关于商城', context);
                          },
                          leading: Icon(CustomIcon.about),
                          trailing: Icon(Icons.keyboard_arrow_right))
                    ]))
              ])),
          ChangeAppBar(
              title: widget.title,
              backgroundColor: Colors.green,
              navAlpha: navAlpha)
        ]));
  }

  Widget _buildHeader() {
    return Container(
        height: headerHeight + Utils.navigationBarHeight,
        child: Stack(children: <Widget>[
          ImageLoadView(backgroundImage,
              placeholder: kTransparentImage,
              fit: BoxFit.fill,
              height: headerHeight + Utils.navigationBarHeight,
              width: Utils.width),
          Container(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    CircleAvatar(
                        backgroundImage: NetworkImage(avatarImage),
                        radius: 40.0),
                    Text('张三',
                        style: TextStyle(color: Colors.white, fontSize: 24.0))
                  ])),
              padding: EdgeInsets.only(top: Utils.navigationBarHeight / 2))
        ]));
  }
}
