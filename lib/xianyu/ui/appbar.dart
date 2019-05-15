import 'package:flutter/material.dart';
import 'package:flutter_app/global/custom_icon.dart';
import 'package:flutter_app/ui/gradual_change_view.dart';
import 'package:flutter_app/utils/utils.dart';

class MyAppBar extends StatelessWidget {
  final List<Color> colors;
  final Color iconColor;
  final Color searchViewBoderColor;
  final Color searchViewColor;
  final Color backgroundColor;
  final VoidCallback rightIconPressed;

  MyAppBar(
      {Key key,
      this.backgroundColor = Colors.transparent,
      this.colors,
      this.iconColor,
      this.searchViewBoderColor = Colors.transparent,
      this.searchViewColor,
      this.rightIconPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.navigationBarHeight,
      child: AppBar(
          flexibleSpace: GradualChangeView(
              rotation: Rotation.LR,
              colors: colors ?? [backgroundColor, backgroundColor]),
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Row(children: <Widget>[
                Icon(Icons.search, color: Colors.grey[300]),
                Text('关键字',
                    style: TextStyle(fontSize: 14, color: Colors.grey[300]))
              ]),
              decoration: BoxDecoration(
                  border: Border.all(color: searchViewBoderColor),
                  color: searchViewColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
          automaticallyImplyLeading: false,
          leading: Container(
              child: Image.asset('images/xianyu.png', color: iconColor),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20)),
          actions: <Widget>[
            IconButton(
                icon: Icon(CustomIcon.scan, color: iconColor),
                onPressed: rightIconPressed)
          ]),
    );
  }
}
