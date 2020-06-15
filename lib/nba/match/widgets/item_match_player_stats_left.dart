import 'package:flutter/material.dart';

import '../../index.dart';

class ItemMatchPlayerStatsLeftView extends StatelessWidget {
  final String playerNo;
  final String playerName;
  final Color bgColor;
  final Color textColor;

  ItemMatchPlayerStatsLeftView(
      {Key key,
      @required this.playerName,
      this.playerNo,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Row(
        children: <Widget>[
          ItemCellView(title: '$playerNo', textColor: textColor),
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Text(
                '$playerName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor ?? Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
