import 'package:flutter/material.dart';

import '../../index.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ItemCellView(title: '首发', textColor: Colors.white),
      ItemCellView(title: '时间', textColor: Colors.white),
      ItemCellView(title: '得分', textColor: Colors.white),
      ItemCellView(title: '篮板', textColor: Colors.white),
      ItemCellView(title: '助攻', textColor: Colors.white),
      ItemCellView(title: '投篮', textColor: Colors.white),
      ItemCellView(title: '三分', textColor: Colors.white),
      ItemCellView(title: '罚球', textColor: Colors.white),
      ItemCellView(title: '抢断', textColor: Colors.white),
      ItemCellView(title: '盖帽', textColor: Colors.white),
      ItemCellView(title: '失误', textColor: Colors.white),
      ItemCellView(title: '犯规', textColor: Colors.white),
      ItemCellView(title: '+/-', textColor: Colors.white)
    ]);
  }
}
