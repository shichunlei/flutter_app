import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_app/ui/line.dart';

import 'count_view.dart';

class ChinaCountCardView extends StatelessWidget {
  final SARSCov data;

  ChinaCountCardView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14.0))),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Text('较昨日变化数据：待国家卫健委数据公布',
                      style: TextStyle(color: Colors.grey[500], fontSize: 10)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3)),
              Line(color: Colors.grey[500]),
              Row(children: <Widget>[
                CountView(
                    textColor: Color(0xFFEA4333),
                    count: data?.currentConfirmedCount,
                    addCount: data?.currentConfirmedIncr,
                    title: "现存确诊"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFFEF8533),
                    count: data?.suspectedCount,
                    addCount: data?.suspectedIncr,
                    title: "现存疑似"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFF55B19D),
                    count: data?.curedCount,
                    addCount: data?.curedIncr,
                    title: "累计治愈")
              ]),
              Gaps.vGap10,
              Row(children: <Widget>[
                CountView(
                    textColor: Color(0xFFA12A35),
                    count: data?.confirmedCount,
                    addCount: data?.confirmedIncr,
                    title: "累计确诊"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFF985E53),
                    count: data?.seriousCount,
                    addCount: data?.seriousIncr,
                    title: "现存重症"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFF627387),
                    count: data?.deadCount,
                    addCount: data?.deadIncr,
                    title: "累计死亡")
              ])
            ])));
  }
}
