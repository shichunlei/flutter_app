import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';

class IconText extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final double width;
  final double height;

  IconText({
    Key key,
    @required this.icon,
    this.onPressed,
    @required this.text,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width ?? 88.0,
          height: height,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              Gaps.vGap8,
              Text('$text'),
            ],
          ),
        ),
      ),
    );
  }
}
