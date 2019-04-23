import 'package:flutter/material.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/utils.dart';

class ChangeAppBar extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final double navAlpha;

  ChangeAppBar({Key key, this.title, this.backgroundColor, this.navAlpha})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ToolBar(backgroundColor: Colors.transparent, title: title),
        Container(
          padding: EdgeInsets.fromLTRB(20, Utils.topSafeHeight, 0, 0),
          height: Utils.navigationBarHeight,
          child: Align(
            child: Text(
              '${title}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            alignment: Alignment.centerLeft,
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: ToolBar(backgroundColor: backgroundColor, title: title),
        ),
      ],
    );
  }
}
