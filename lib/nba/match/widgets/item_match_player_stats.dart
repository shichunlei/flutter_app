import 'package:flutter/material.dart';

import '../../index.dart';

class ItemMatchPlayerStatsView extends StatelessWidget {
  final List<PlayerMatchStats> data;

  ItemMatchPlayerStatsView({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: data.length * 40.0,
      width: 650.0,
      child: Table(
          children: data.map((item) {
        int index = data.indexOf(item);
        return TableRow(
          decoration:
              BoxDecoration(color: index < 5 ? Colors.grey[300] : Colors.white),
          children: [
            ItemCellView(title: '${index < 5 ? "是" : "否"}'),
            ItemCellView(title: '${item?.row[2]}'),
            ItemCellView(title: '${item?.row[3]}'),
            ItemCellView(title: '${item?.row[4]}'),
            ItemCellView(title: '${item?.row[5]}'),
            ItemCellView(title: '${item?.row[6]}'),
            ItemCellView(title: '${item?.row[7]}'),
            ItemCellView(title: '${item?.row[8]}'),
            ItemCellView(title: '${item?.row[9]}'),
            ItemCellView(title: '${item?.row[10]}'),
            ItemCellView(title: '${item?.row[11]}'),
            ItemCellView(title: '${item?.row[12]}'),
            ItemCellView(title: '${item?.row[13]}'),
          ],
        );
      }).toList()),
    );
  }
}
