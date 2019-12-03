import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../../index.dart';

class ItemMatchTeamStatsView extends StatelessWidget {
  final TeamStatsBean item;
  final Color leftColor;
  final Color rightColor;

  ItemMatchTeamStatsView({
    Key key,
    this.item,
    @required this.leftColor,
    @required this.rightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = max(int.parse(item.leftVal.replaceAll("%", '')),
        int.parse(item.rightVal.replaceAll("%", '')));

    return Container(
      child: Column(children: [
        Stack(alignment: Alignment.center, children: <Widget>[
          Row(children: <Widget>[
            Text('${item?.leftVal}', style: TextStyle(fontSize: 20)),
            Text('${item?.rightVal}', style: TextStyle(fontSize: 20)),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          Text('${item?.text}')
        ]),
        Gaps.vGap5,
        Row(children: <Widget>[
          Expanded(
              child: Container(
                  height: 3.0,
                  color: value == int.parse(item.leftVal.replaceAll("%", ''))
                      ? leftColor
                      : Colors.grey[300])),
          Gaps.hGap5,
          Expanded(
              child: Container(
                  height: 3.0,
                  color: value == int.parse(item.rightVal.replaceAll("%", ''))
                      ? rightColor
                      : Colors.grey[300])),
        ]),
        Gaps.vGap10
      ]),
    );
  }
}
