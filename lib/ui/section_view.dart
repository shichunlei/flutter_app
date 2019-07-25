import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class SectionView extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String more;
  final bool hiddenMore;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  SectionView(
    this.title, {
    Key key,
    this.onPressed,
    this.more: "更多",
    this.hiddenMore: false,
    this.textColor = Colors.black,
    this.padding,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("$title",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        Gaps.vGap5,
                        Container(
                            width: title.length * 20.0,
                            height: 2,
                            color: textColor)
                      ]),
                  height: 36.0),
              Offstage(
                  child: InkWell(
                      child: Container(
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('$more',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: textColor)),
                              Gaps.hGap3,
                              Icon(CupertinoIcons.forward,
                                  size: 18, color: textColor)
                            ]),
                      ),
                      onTap: onPressed),
                  offstage: hiddenMore)
            ]));
  }
}
