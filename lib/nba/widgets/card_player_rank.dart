import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class CardPlayerRank extends StatelessWidget {
  final String title;
  final List<Player> players;
  final String sort;

  CardPlayerRank(
      {Key key,
      @required this.title,
      @required this.players,
      @required this.sort})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0),
              color: Colors.blue[200],
              child: Row(
                children: <Widget>[
                  Text('$title', style: TextStyles.textBoldDark26),
                  FlatButton(onPressed: () => {}, child: Text('查看更多 >'))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            ListView.builder(
              itemBuilder: (_, index) => ItemPlayerRankView(
                player: players[index],
                rank: index + 1,
                isBig: index == 0,
                type: title,
              ),
              itemCount: players.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}
