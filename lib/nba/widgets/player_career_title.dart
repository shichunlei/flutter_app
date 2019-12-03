import 'package:flutter/material.dart';

import '../index.dart';

class PlayerCareerTitle extends StatelessWidget {
  PlayerCareerTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          ItemCellView(title: '赛季', width: 150),
          ItemCellView(width: 80, title: '球队'),
          // 上场时间（分钟）
          ItemCellView(width: 70, title: '时间'),
          // 得分
          ItemCellView(title: '得分'),
          // 命中数 - 出手数
          ItemCellView(width: 80, title: '投篮'),
          // 命中率
          ItemCellView(width: 60, title: '命中率'),
          // 三分命中数 - 三分出手数
          ItemCellView(width: 80, title: '三分球'),
          // 三分命中率
          ItemCellView(width: 60, title: '三分%'),
          // 罚球命中数 - 罚球数
          ItemCellView(width: 80, title: '罚球'),
          // 罚球命中率
          ItemCellView(width: 60, title: '罚球%'),
          // 助攻
          ItemCellView(title: '助攻'),
          // 篮板
          ItemCellView(title: '篮板'),
          // 前场篮板
          ItemCellView(title: '前场板', width: 60.0),
          // 后场篮板
          ItemCellView(title: '后场板', width: 60.0),
          // 抢断
          ItemCellView(title: '抢断'),
          // 盖帽
          ItemCellView(title: '盖帽'),
          // 犯规
          ItemCellView(title: '犯规')
        ],
      ),
    );
  }
}
