import 'package:flutter/material.dart';
import 'package:flutter_app/utils/route_util.dart';

import '../index.dart';

class ItemPlayerMatchView extends StatelessWidget {
  final Color bgColor;
  final PlayerMatch item;

  ItemPlayerMatchView({Key key, this.bgColor, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgColor,
      height: 40,
      child: Row(
        children: <Widget>[
          // 比分
          Container(
            width: 100,
            child: RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '${item.awayGoal}',
                    style: TextStyle(
                        color: item.isHome
                            ? Colors.black54
                            : (item.isWin ? Colors.green : Colors.red))),
                TextSpan(text: ' : ', style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: '${item.homeGoal}',
                    style: TextStyle(
                        color: item.isHome
                            ? (item.isWin ? Colors.green : Colors.red)
                            : Colors.black54)),
              ],
            )),
            alignment: Alignment.center,
          ),
          // 对手
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => pushNewPage(
                  context,
                  TeamHomePage(
                      title: '${item.opponent}',
                      id: item.isHome ? item.awayId : item.homeId)),
              child: Container(
                width: 80,
                child: Text('@${item.opponent}'),
                alignment: Alignment.center,
              ),
            ),
          ),
          // 主/客
          Container(
            width: 50,
            child: Text(
              '${item.isHome ? "主" : "客"}',
              style: TextStyle(color: item.isHome ? Colors.green : Colors.red),
            ),
            alignment: Alignment.center,
          ),
          // 上场时间（分钟）
          Container(
            width: 70,
            child: Text('${item.minutes}分钟'),
            alignment: Alignment.center,
          ),
          // 得分
          Container(
            width: 50,
            child: Text('${item.points}'),
            alignment: Alignment.center,
          ),
          // 命中数 - 出手数
          Container(
            width: 50,
            child: Text('${item.fieldGoals}-${item.fieldGoalsAttempted}'),
            alignment: Alignment.center,
          ),
          // 命中率
          Container(
            width: 60,
            child: Text(
                '${item.fieldGoalsAttempted == '0' ? 0.0 : (int.parse(item.fieldGoals) / int.parse(item.fieldGoalsAttempted) * 100).toStringAsFixed(1)}%'),
            alignment: Alignment.center,
          ),
          // 三分命中数 - 三分出手数
          Container(
            width: 60,
            child: Text('${item.threePointGoals}-${item.threePointAttempted}'),
            alignment: Alignment.center,
          ),
          // 三分命中率
          Container(
            width: 60,
            child: Text(
                '${item.threePointAttempted == '0' ? 0.0 : (int.parse(item.threePointGoals) / int.parse(item.threePointAttempted) * 100).toStringAsFixed(1)}%'),
            alignment: Alignment.center,
          ),
          // 罚球命中数 - 罚球数
          Container(
            width: 60,
            child: Text('${item.freeThrows}-${item.freeThrowsAttempted}'),
            alignment: Alignment.center,
          ),
          // 罚球命中率
          Container(
            width: 60,
            child: Text(
                '${item.freeThrowsAttempted == '0' ? 0.0 : (int.parse(item.freeThrows) / int.parse(item.freeThrowsAttempted) * 100).toStringAsFixed(1)}%'),
            alignment: Alignment.center,
          ),
          // 助攻
          Container(
            width: 50,
            child: Text('${item.assists}'),
            alignment: Alignment.center,
          ),
          // 篮板
          Container(
            width: 50,
            child: Text('${item.rebounds}'),
            alignment: Alignment.center,
          ),
          // 前场篮板
          Container(
            width: 60,
            child: Text('${item.offensiveRebounds}'),
            alignment: Alignment.center,
          ),
          // 后场篮板
          Container(
            width: 60,
            child: Text('${item.defensiveRebounds}'),
            alignment: Alignment.center,
          ),
          // 抢断
          Container(
            width: 50,
            child: Text('${item.steals}'),
            alignment: Alignment.center,
          ),
          // 盖帽
          Container(
            width: 50,
            child: Text('${item.blocked}'),
            alignment: Alignment.center,
          ),
          // 失误
          Container(
            width: 50,
            child: Text('${item.turnovers}'),
            alignment: Alignment.center,
          ),
          // 犯规
          Container(
            width: 50,
            child: Text('${item.personalFouls}'),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
