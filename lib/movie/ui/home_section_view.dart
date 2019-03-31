import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeSectionView extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String more;
  final bool hiddenMore;
  final Color backgroundColor;
  final Color textColor;

  HomeSectionView(
    this.title, {
    Key key,
    this.onPressed,
    this.more = "更多",
    this.hiddenMore = false,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(15, 15, 5, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              SizedBox(height: 5),
              Container(
                  width: title.length * 20.0, height: 2, color: textColor),
            ],
          ),
          Offstage(
            child: FlatButton(
              color: backgroundColor,
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '$more',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: textColor),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    CupertinoIcons.forward,
                    size: 14,
                    color: textColor,
                  ),
                ],
              ),
            ),
            offstage: hiddenMore,
          ),
        ],
      ),
    );
  }
}
