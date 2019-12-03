import 'package:flutter/material.dart';

import '../index.dart';

class PlayerCareerBody extends StatelessWidget {
  final List<SeasonDataStat> list;

  PlayerCareerBody({Key key, @required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: list.length * 40.0,
      child: Column(
        children: list.map((item) {
          int index = list.indexOf(item);
          return Container(
            color: index % 2 == 1 ? Colors.grey[300] : Colors.white,
            child: Row(
              children: [
                ItemCellView(
                    width: 150,
                    title:
                        '${item.seasonId} - ${int.parse(item.seasonId) + 1} ${item.seasonType == '0' ? "季前赛" : item.seasonType == '1' ? "常规赛" : "季后赛"}'),
                ItemCellView(width: 80, title: '${item.teamName}'),
                // 上场时间（分钟）
                ItemCellView(width: 70, title: '${item.minutesPG}'),
                // 得分
                ItemCellView(title: '${item.pointsPG}'),
                // 命中数 - 出手数
                ItemCellView(
                    width: 80, title: '${item.fgMadePG}/${item.fgAttemptedPG}'),
                // 命中率
                ItemCellView(
                    width: 60,
                    title:
                        '${(double.parse(item.fgPCT) * 100).toStringAsFixed(1)}%'),
                // 三分命中数 - 三分出手数
                ItemCellView(
                    width: 80,
                    title: '${item.threesMadePG}/${item.threesAttemptedPG}'),
                // 三分命中率
                ItemCellView(
                    width: 60,
                    title:
                        '${(double.parse(item.threesPCT) * 100).toStringAsFixed(1)}%'),
                // 罚球命中数 - 罚球数
                ItemCellView(
                    width: 80, title: '${item.ftMadePG}/${item.ftAttemptedPG}'),
                // 罚球命中率
                ItemCellView(
                    width: 60,
                    title:
                        '${(double.parse(item.ftPCT) * 100).toStringAsFixed(1)}%'),
                // 助攻
                ItemCellView(title: '${item.assistsPG}'),
                // 篮板
                ItemCellView(title: '${item.reboundsPG}'),
                // 前场篮板
                ItemCellView(title: '${item.offensiveReboundsPG}', width: 60.0),
                // 后场篮板
                ItemCellView(title: '${item.defensiveReboundsPG}', width: 60.0),
                // 抢断
                ItemCellView(title: '${item.stealsPG}'),
                // 盖帽
                ItemCellView(title: '${item.blocksPG}'),
                // 犯规
                ItemCellView(title: '${item.foulsPG}')
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
