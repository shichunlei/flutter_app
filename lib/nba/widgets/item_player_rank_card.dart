import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class ItemPlayerRankView extends StatelessWidget {
  final Player player;
  final bool isBig;
  final int rank;
  final String type;

  ItemPlayerRankView({
    Key key,
    this.isBig: false,
    @required this.player,
    @required this.rank,
    @required this.type,
  })  : assert(type != null),
        assert(rank != null),
        assert(player != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pushNewPage(context, PlayerHomePage(id: player?.playerId)),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                isBig
                    ? Text(
                        '$rank',
                        style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )
                    : TagView(
                        tag: '$rank',
                        borderColor: Colors.grey,
                        padding: EdgeInsets.all(5),
                        fontSize: 15,
                      ),
                Gaps.hGap10,
                ImageLoadView(
                  isBig ? "${player.bodyPic}" : '${player.avatar}',
                  height: isBig ? 140 : 44,
                  width: isBig ? 88 : 44,
                ),
                Gaps.hGap10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${player.cnName}',
                      style: TextStyles.textBoldDark20,
                    ),
                    Gaps.vGap5,
                    Text('${player.jerseyNum}号 / ${player.position}'),
                    Gaps.vGap5,
                    Text('${player.teamName}'),
                  ],
                ),
              ],
            ),
            Positioned(
              child: Center(
                child: Text(
                  '${double.parse(player.avgValue).toStringAsFixed(1)}',
                  style: TextStyle(
                      fontSize: isBig ? 30.0 : 20,
                      fontWeight: isBig ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
            )
          ],
        ),
      ),
    );
  }
}
