import 'package:flutter/material.dart';

import '../index.dart';

class PlayerMatchTitle extends StatelessWidget {
  PlayerMatchTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          ItemCellView(title: '比分', width: 100),
          // 对手
          ItemCellView(width: 80, title: '对手'),
          // 主/客
          ItemCellView(title: "主/客"),
          // 上场时间（分钟）
          ItemCellView(width: 70, title: '上场时间'),
          // 得分
          ItemCellView(title: '得分'),
          // 命中数 - 出手数
          ItemCellView(title: '投篮'),
          // 命中率
          ItemCellView(width: 60, title: '命中率'),
          // 三分命中数 - 三分出手数
          ItemCellView(width: 60, title: '三分球'),
          // 三分命中率
          ItemCellView(width: 60, title: '三分%'),
          // 罚球命中数 - 罚球数
          ItemCellView(width: 60, title: '罚球'),
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
          // 失误
          ItemCellView(title: '失误'),
          // 犯规
          ItemCellView(title: '犯规')
        ],
      ),
    );
  }
}
