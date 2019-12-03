import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class ItemRank extends StatelessWidget {
  final int rank;
  final Rank item;
  final int type;

  ItemRank({Key key, @required this.rank, @required this.item, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyles.textGrey16;
    if (type == 1) {
      style = rank < 9 ? TextStyles.textRed16 : TextStyles.textGrey16;
    }

    Color bgColor = Colors.white;
    if (type == 1) {
      bgColor = rank < 9 ? Colors.grey[200] : Colors.white;
    }

    return Material(
      color: bgColor,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text(
                      '$rank.',
                      style: style,
                    ),
                    Gaps.hGap5,
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('${item.logoNew}'),
                      radius: 16.0,
                    ),
                    Gaps.hGap5,
                    Text('${item.name}')
                  ],
                ),
                flex: 5,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Text('${item.wins}', textAlign: TextAlign.center),
                    Text('${item.losses}', textAlign: TextAlign.center),
                    Text('${item.winingPercentage}%',
                        textAlign: TextAlign.center),
                    Text('${item.gamesBack}', textAlign: TextAlign.center),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                flex: 9,
              ),
            ],
          ),
        ),
        onTap: () => pushNewPage(
            context, TeamHomePage(id: item.teamId, title: item.name)),
      ),
    );
  }
}
