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
  final Widget child;

  SectionView(
    this.title, {
    Key key,
    this.onPressed,
    this.more: "更多",
    this.hiddenMore: false,
    this.textColor = Colors.black,
    this.padding,
    @required this.child,
  })  : assert(title != null, child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: padding ?? EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "$title",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.5),
                      ),
                      decoration: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 2.0, color: Colors.white),
                          insets: EdgeInsets.fromLTRB(0, 10, 0, 0))),
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
                      offstage: hiddenMore),
                ])),
        child
      ],
    );
  }
}
