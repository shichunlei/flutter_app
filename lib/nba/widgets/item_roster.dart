import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemRoster extends StatelessWidget {
  final Player player;
  final VoidCallback onPressed;

  ItemRoster({Key key, @required this.player, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,

      /// z轴的高度，设置card的阴影
      elevation: 20.0,

      /// 对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Material(
        color: Colors.deepPurpleAccent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage('${player.avatar}'),
                    radius: 40),
                Gaps.hGap8,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('${player.cnName}',
                              style: TextStyles.textWhite16),
                          Gaps.hGap8,
                          Text('${player.position}',
                              style: TextStyles.textWhite16)
                        ],
                      ),
                      Gaps.vGap16,
                      Row(
                        children: <Widget>[
                          Text('${player.height} CM',
                              style: TextStyles.textWhite16),
                          Gaps.hGap8,
                          Text('${player.weight} KG',
                              style: TextStyles.textWhite16),
                          Gaps.hGap16,
                          TagView(
                            tag: '${player.jerseyNum}',
                            padding: EdgeInsets.fromLTRB(12, 2, 12, 2),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
