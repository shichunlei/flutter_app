import 'package:flutter/material.dart';

import '../page/analyze.dart';
import '../page/same_ride.dart';
import '../page/trajectory/trajectory.dart';
import '../../page_index.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        color: Color(0xFFEFF4FE),
        child: Row(children: [
          Expanded(
              child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      onTap: () => pushNewPage(context, AnalyzePage()),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(children: <Widget>[
                            Image.asset('images/icon_rili.png',
                                width: 20, height: 20),
                            Gaps.hGap5,
                            Text('战役分析',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15))
                          ], mainAxisSize: MainAxisSize.min))))),
          Expanded(
              child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      onTap: () => pushNewPage(context, TrajectoryPage()),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(children: <Widget>[
                            Image.asset('images/icon_guiji.png',
                                width: 20, height: 20),
                            Gaps.hGap5,
                            Text('病患轨迹',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15))
                          ], mainAxisSize: MainAxisSize.min))))),
          Expanded(
              child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      onTap: () => pushNewPage(context, SameRidePage()),
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Row(children: <Widget>[
                            Image.asset('images/icon_train.png',
                                width: 20, height: 20),
                            Gaps.hGap5,
                            Text('同乘查询',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15))
                          ], mainAxisSize: MainAxisSize.min)))))
        ]));
  }
}
