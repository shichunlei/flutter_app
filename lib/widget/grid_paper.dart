import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';

class GridPaperWidget extends StatelessWidget {
  ///  interval参数表示2条线之间的间隔，默认是100逻辑像素，注意单位是逻辑像素，而不是物理像素。
  ///  divisions参数表示每个主网格的分割数。
  ///  subdivisions参数表示次网格的分割数，包含它自身。

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('GridPaper')),
        body: SingleChildScrollView(
          child: Column(children: [
            Text('divisions = 1 & subdivisions = 1'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 1, subdivisions: 1)),
            Gaps.vGap10,
            Text('divisions = 2 & subdivisions = 1'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 2, subdivisions: 1)),
            Gaps.vGap10,
            Text('divisions = 4 & subdivisions = 1'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 4, subdivisions: 1)),
            Gaps.vGap10,
            Text('divisions = 2 & subdivisions = 1'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 2, subdivisions: 1)),
            Gaps.vGap10,
            Text('divisions = 2 & subdivisions = 2'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 2, subdivisions: 2)),
            Gaps.vGap10,
            Text('divisions = 2 & subdivisions = 4'),
            Gaps.vGap10,
            Container(
                height: 200,
                width: 200,
                child:
                    GridPaper(color: Colors.red, divisions: 2, subdivisions: 4)),
            Gaps.vGap10
          ]),
        ));
  }
}
