import 'package:flutter/material.dart';

import '../../../page_index.dart';
import '../../index.dart';

class ItemMatchHead extends StatelessWidget {
  final ScheduleList teamInfo;

  ItemMatchHead({Key key, @required this.teamInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 返回字段没有状态字段，只能靠下面两个字段判断比赛是否结束，NBA历史上最多加时为4个加时，所以这里只考虑到4个加时
    String matchState = (teamInfo.quarterDesc == '第4节 00:00' ||
                teamInfo.quarterDesc == '加时1 00:00' ||
                teamInfo.quarterDesc == '加时2 00:00' ||
                teamInfo.quarterDesc == '加时3 00:00' ||
                teamInfo.quarterDesc == '加时4 00:00') &&
            teamInfo.leftGoal != teamInfo.rightGoal
        ? "已结束"
        : "进行中";

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(Utils.getColorHexFromStr(teamInfo.leftTeamColor)),
            Color(Utils.getColorHexFromStr(teamInfo.rightTeamColor))
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      margin: EdgeInsets.only(top: 2.0),
      padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
              child: Column(children: [
                ImageLoadView('${teamInfo?.leftBadge}', width: 50, height: 50),
                Gaps.vGap5,
                Text('${teamInfo?.leftName}',
                    style: TextStyle(color: Colors.white))
              ]),
              onTap: () => pushNewPage(
                  context,
                  TeamHomePage(
                    title: teamInfo.leftName,
                    id: teamInfo.leftId,
                  ))),
          Text('${teamInfo?.leftGoal}',
              style: TextStyle(color: Colors.red, fontSize: 22.0)),
          Column(
            children: [
              Text('$matchState', style: TextStyle(color: Colors.red)),
              Gaps.vGap3,
              Container(width: 60.0, height: 1.0, color: Colors.black54),
              Gaps.vGap3,
              Text('常规赛', style: TextStyle(color: Colors.grey))
            ],
          ),
          Text('${teamInfo?.rightGoal}',
              style: TextStyle(color: Colors.red, fontSize: 22.0)),
          InkWell(
            child: Column(
              children: [
                ImageLoadView('${teamInfo?.rightBadge}', width: 50, height: 50),
                Gaps.vGap5,
                Text('${teamInfo?.rightName}',
                    style: TextStyle(color: Colors.white))
              ],
            ),
            onTap: () => pushNewPage(
                context,
                TeamHomePage(
                  title: teamInfo.rightName,
                  id: teamInfo.rightId,
                )),
          )
        ],
      ),
    );
  }
}
