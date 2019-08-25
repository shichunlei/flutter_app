import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  IconText({Key key, this.icon, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            onTap: onPressed,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      icon,
                      SizedBox(height: 8.0),
                      Text('$text')
                    ]))));
  }
}
