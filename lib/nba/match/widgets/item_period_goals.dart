import 'package:flutter/material.dart';

import '../../../page_index.dart';
import '../../index.dart';

class ItemPeriodGoalsView extends StatelessWidget {
  const ItemPeriodGoalsView({
    Key key,
    @required this.width,
    this.item,
  }) : super(key: key);

  final double width;
  final PeriodGoalsBean item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('${item.title}'),
          item.isPic
              ? ImageLoadView('${item.leftValue}', width: 33.0, height: 33.0)
              : Container(
                  child: Text(
                    '${item.leftValue}',
                    style: TextStyle(
                        color: item.action ? Colors.white : Colors.black),
                  ),
                  height: 33.0,
                  alignment: Alignment.center,
                  color: item.action ? Colors.grey : Colors.white),
          item.isPic
              ? ImageLoadView('${item.rightValue}', width: 33.0, height: 33.0)
              : Container(
                  child: Text(
                    '${item.rightValue}',
                    style: TextStyle(
                        color: item.action ? Colors.white : Colors.black),
                  ),
                  height: 33.0,
                  alignment: Alignment.center,
                  color: item.action ? Colors.grey : Colors.white),
        ],
      ),
    );
  }
}
