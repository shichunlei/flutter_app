import 'package:flutter/material.dart';
import 'package:flutter_app/bean/hourly.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/global/data.dart';

class HourlyView extends StatelessWidget {
  final List<Hourly> hourly;

  HourlyView(this.hourly, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('24小时预报', style: TextStyle(color: Colors.white)),
          Container(
            height: 0.2,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 10.0),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(150.0),
            child: charts.LineChart(
              _createHourlyTmps(),
              animate: true,
              flipVerticalAxis: false,
              defaultRenderer: charts.LineRendererConfig(
                /// 是否显示点
                includePoints: true,

                /// 点的半径
                radiusPx: 2.0,

                /// 线的宽度
                strokeWidthPx: 1.0,
              ),
              customSeriesRenderers: [],
            ),
          ),
          Row(
            children: hourly.map((hour) {
              return Expanded(
                child: Center(
                  child: Text(
                    hour.time.substring(10),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            children: hourly.map((hour) {
              return Expanded(
                child: Center(
                  child: Text(
                    hour.cond_txt,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
          Row(
            children: hourly.map((hour) {
              return Expanded(
                child: Center(
                  child:
                      Image.network(hour.cond_code, width: 20.0, height: 20.0),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<charts.Series<LinearSales, num>> _createHourlyTmps() {
    final List<LinearSales> tmp = hourly.map((hour) {
      return LinearSales(hourly.indexOf(hour), int.parse(hour.tmp));
    }).toList();

    return [
      charts.Series<LinearSales, int>(
        id: 'tmp',
        displayName: '温度',
        // colorFn specifies that the line will be deepOrange.
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: tmp,
      ),
    ];
  }
}
