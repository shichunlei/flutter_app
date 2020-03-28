import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

import '../../page_index.dart';
import 'count_view.dart';

class ForeignCountCardView extends StatelessWidget {
  final SARSCov data;

  ForeignCountCardView({Key key, this.data}) : super(key: key);

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
              Row(children: <Widget>[
                CountView(
                    textColor: Color(0xFFEA4333),
                    count: data?.foreignStatistics?.currentConfirmedCount,
                    addCount: data?.foreignStatistics?.currentConfirmedIncr,
                    title: "现存确诊"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFFEF8533),
                    count: data?.foreignStatistics?.suspectedCount,
                    addCount: data?.foreignStatistics?.suspectedIncr,
                    title: "现存疑似"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFFA12A35),
                    count: data?.foreignStatistics?.confirmedCount,
                    addCount: data?.foreignStatistics?.confirmedIncr,
                    title: "累计确诊"),
              ]),
              Gaps.vGap10,
              Row(children: <Widget>[
                CountView(
                    textColor: Color(0xFF55B19D),
                    count: data?.foreignStatistics?.curedCount,
                    addCount: data?.foreignStatistics?.curedIncr,
                    title: "累计治愈"),
                LineWidget(
                    lineType: LineType.vertical,
                    color: Color(0xFFE9E9E9),
                    height: 50.0,
                    width: 1),
                CountView(
                    textColor: Color(0xFF627387),
                    count: data?.foreignStatistics?.deadCount,
                    addCount: data?.foreignStatistics?.deadIncr,
                    title: "累计死亡"),
              ])
            ])));
  }
}
