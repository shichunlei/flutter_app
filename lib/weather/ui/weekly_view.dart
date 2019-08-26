import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/ui/line.dart';
import 'package:flutter_app/utils/date_format.dart';

class WeeklyView extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  WeeklyView(this.dailyForecast, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        color: Color(0x2a000000),
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('未来一周天气预报', style: TextStyle(color: Colors.white)),
              Line(),
              Row(
                  children: dailyForecast.map((daily) {
                DateTime dt = DateTime.parse(daily.date);
                return Expanded(
                    child: Center(
                        child: Text(
                            isToday(daily.date)
                                ? "今天"
                                : formatDate(dt, formats: [EE_ZH]),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Text(daily.cond_txt_d,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Image.network(daily.cond_code_d,
                            width: 20.0, height: 20.0)));
              }).toList()),
              SizedBox.fromSize(
                  size: Size.fromHeight(150.0),
                  child: charts.LineChart(_createDailyTmps(),
                      animate: true,
                      flipVerticalAxis: false,
                      defaultRenderer: charts.LineRendererConfig(
                        /// 是否显示点
                        includePoints: true,

                        /// 点的半径
                        radiusPx: 2.0,

                        /// 是否显示线
                        includeLine: true,

                        /// 线的宽度
                        strokeWidthPx: 1.0,

                        /// 是否显示线下面的区域
                        includeArea: false,
                        stacked: false,
                        // ID used to link series to this renderer.
                        customRendererId: 'customArea',
                      ),
                      customSeriesRenderers: [])),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Text(daily.cond_txt_n,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Image.network(daily.cond_code_n,
                            width: 20.0, height: 20.0)));
              }).toList()),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Text(daily.wind_dir,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList()),
              Row(
                  children: dailyForecast.map((daily) {
                return Expanded(
                    child: Center(
                        child: Text('${daily.wind_sc}级',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))));
              }).toList())
            ]));
  }

  List<charts.Series<LinearSales, num>> _createDailyTmps() {
    final List<LinearSales> max = dailyForecast.map((daily) {
      return LinearSales(
          dailyForecast.indexOf(daily), int.parse(daily.tmp_max));
    }).toList();

    final List<LinearSales> min = dailyForecast.map((daily) {
      return LinearSales(
          dailyForecast.indexOf(daily), int.parse(daily.tmp_min));
    }).toList();

    return [
      charts.Series<LinearSales, int>(
          id: '高温',
          displayName: '高温',
          // colorFn specifies that the line will be deepOrange.
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.time,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: max),
      charts.Series<LinearSales, int>(
          id: '低温',
          displayName: '低温',
          colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.time,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: min)
    ];
  }
}
