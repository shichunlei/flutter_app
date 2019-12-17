import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class CurrentAppBar extends StatelessWidget {
  final Widget title;
  final bool centerTitle;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onPressed;
  final Widget action;
  final Brightness brightness;

  CurrentAppBar({
    Key key,
    this.title,
    this.centerTitle: true,
    this.bgColor: Colors.white,
    this.iconColor: Colors.black,
    this.onPressed,
    this.action,
    this.brightness: Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      child: Container(
        height: Utils.navigationBarHeight,
        padding: EdgeInsets.only(top: Utils.topSafeHeight),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Utils.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: iconColor,
                ),
                onPressed: () => Navigator.pop(context)),
            Expanded(
              child: Container(
                child: title,
                alignment:
                    centerTitle ? Alignment.center : Alignment.centerLeft,
              ),
            ),
            SizedBox(
              child: action,
              width: Utils.navigationBarHeight - Utils.topSafeHeight,
            ),
          ],
        ),
      ),
    );
  }
}
