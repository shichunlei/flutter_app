import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_charts/flutter_charts.dart';

import '../../../../page_index.dart';

class AreaDataView extends StatelessWidget {
  final ProvinceDataBean data;
  final List<HistoryBean> history;

  AreaDataView({Key key, @required this.data, @required this.history})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xFF4E79F3),
                ),
                child: Text(
                  '${data?.province}',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              Text(
                '${data?.times}(北京时间) 数据统计',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
            mainAxisSize: MainAxisSize.min,
          ),
          Row(
            children: <Widget>[
              Text(
                '确诊',
                style: TextStyle(fontSize: 13),
              ),
              Text(
                '死亡',
                style: TextStyle(fontSize: 13),
              ),
              Text(
                '治愈',
                style: TextStyle(fontSize: 13),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${data?.conTotal}',
                        style:
                            TextStyle(color: Color(0xFF4E79F3), fontSize: 15),
                      ),
                      Gaps.hGap5,
                      Text(
                        '例',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${data?.deathTotal}',
                        style:
                            TextStyle(color: Color(0xFF4E79F3), fontSize: 15),
                      ),
                      Gaps.hGap5,
                      Text(
                        '例',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${data?.cureTotal}',
                        style:
                            TextStyle(color: Color(0xFF4E79F3), fontSize: 15),
                      ),
                      Gaps.hGap5,
                      Text(
                        '例',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Text(
              '${data?.province}疫情地图',
              style: TextStyle(color: Color(0xFF4E79F3)),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            height: 400,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Text(
              '${data?.province}疫情趋势图',
              style: TextStyle(color: Color(0xFF4E79F3)),
            ),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              height: 300,
              child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<HistoryBean, String>>[
                    SplineSeries<HistoryBean, String>(
                      name: "确诊",
                      dataSource: history,
                      xValueMapper: (HistoryBean sales, _) => sales.date,
                      yValueMapper: (HistoryBean sales, _) =>
                          sales.confirmedCount,
                      color: Color(0xFFEE836C),
                    ),
                    SplineSeries<HistoryBean, String>(
                      name: "死亡",
                      dataSource: history,
                      xValueMapper: (HistoryBean sales, _) => sales.date,
                      yValueMapper: (HistoryBean sales, _) => sales.deadCount,
                      color: Color(0xFF164F81),
                    ),
                    SplineSeries<HistoryBean, String>(
                      name: "治愈",
                      dataSource: history,
                      xValueMapper: (HistoryBean sales, _) => sales.date,
                      yValueMapper: (HistoryBean sales, _) => sales.curedCount,
                      color: Color(0xFFF8DD7F),
                    ),
                  ])),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10.0),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Text(
              '${data?.province}疫情病例分布',
              style: TextStyle(color: Color(0xFF4E79F3)),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text('区/县'),
                    height: 35.0,
                    color: Color(0xFFCCCEEC),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '确诊',
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 35.0,
                    color: Color(0xFFEE836C),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      '死亡',
                      style: TextStyle(color: Colors.white),
                    ),
                    height: 35.0,
                    color: Color(0xFF164F81),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text('治愈'),
                    height: 35.0,
                    color: Color(0xFFF8DD7F),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
