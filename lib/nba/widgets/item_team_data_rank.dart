import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemTeamDataRank extends StatelessWidget {
  final SeasonDataStat item;
  final int rank;

  ItemTeamDataRank({Key key, @required this.item, @required this.rank})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 30.0,
                child: Text('$rank.',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ),
              Gaps.hGap5,
              CircleAvatar(
                backgroundImage: NetworkImage('${item.logo}'),
                backgroundColor: Colors.transparent,
                radius: 20.0,
              ),
              Gaps.hGap5,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${item.cnName}'),
                  Gaps.vGap5,
                  Text('${item.wins}胜，${item.losses}负'),
                ],
              ),
              Expanded(
                child: Text(
                  '${item.valuePG.toStringAsFixed(1)}',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        onTap: () => pushNewPage(
            context,
            TeamHomePage(
              title: item.cnName,
              id: item.teamId,
            )),
      ),
    );
  }
}
