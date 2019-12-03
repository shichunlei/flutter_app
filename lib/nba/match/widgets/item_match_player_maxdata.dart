import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../../index.dart';

class ItemMatchPlayerMaxDataView extends StatelessWidget {
  final MaxPlayersBean item;
  final Color leftColor;
  final Color rightColor;

  ItemMatchPlayerMaxDataView({
    Key key,
    @required this.item,
    @required this.leftColor,
    @required this.rightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int value = max(int.parse(item.leftVal), int.parse(item.rightVal));

    return Container(
      margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: ImageLoadView(
                        '${item.leftPlayer.icon}',
                        width: 70,
                        height: 50,
                        fit: BoxFit.fitHeight,
                      ),
                      onTap: () => pushNewPage(context,
                          PlayerHomePage(id: item.rightPlayer.playerId)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13.0),
                      child: Text(
                        '${item.leftVal}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: leftColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 80 * int.parse(item.leftVal) / value,
                      color: leftColor,
                    )
                  ],
                ),
              ),
              Gaps.hGap5,
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 25,
                      height: 80 * int.parse(item.rightVal) / value,
                      color: rightColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13.0),
                      child: Text(
                        '${item.rightVal}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: rightColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: ImageLoadView(
                        '${item.rightPlayer.icon}',
                        width: 70,
                        height: 50,
                        fit: BoxFit.fitHeight,
                      ),
                      onTap: () => pushNewPage(context,
                          PlayerHomePage(id: item.rightPlayer.playerId)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gaps.vGap5,
          Row(
            children: <Widget>[
              Expanded(child: Container(height: 3.0, color: leftColor)),
              Gaps.hGap5,
              Expanded(child: Container(height: 3.0, color: rightColor)),
            ],
          ),
          Gaps.vGap5,
          Stack(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text('${item.leftPlayer.name}'),
                  Text('${item.rightPlayer.name}'),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Text('${item.text}'),
            ],
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
