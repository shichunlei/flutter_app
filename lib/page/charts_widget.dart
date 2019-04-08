import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/global/data.dart';

class ChartsWidget extends StatefulWidget {
  ChartsWidget({Key key}) : super(key: key);

  @override
  _ChartsWidgetState createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  bool animate;
  List<Widget> widgetList = List();

  @override
  void initState() {
    super.initState();
    loadChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            //是否固定。
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'images/flutter.png',
                fit: BoxFit.cover,
              ),
              centerTitle: false,
              title: const Text('图表学习'),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widgetList[index];
              },
              childCount: widgetList.length,
            ),
          ),
        ],
      ),
    );
  }

  void loadChartData() async {
    //0.标题
    //1.折线图
    widgetList.add(
      charts.TimeSeriesChart(
        ChartFlutterBean.createSampleData0(),
        animate: animate,
        // Optionally pass in a [DateTimeFactory] used by the chart. The factory
        // should create the same type of [DateTime] as the data provided. If none
        // specified, the default creates local date time.
        dateTimeFactory: charts.LocalDateTimeFactory(),
      ),
    );

    //2.饼状图
    widgetList.add(
      charts.PieChart(
        ChartFlutterBean.createSampleData1(),
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: charts.ArcRendererConfig(arcWidth: 60),
      ),
    );

    //3.荧光棒图
    widgetList.add(
      charts.ScatterPlotChart(
        ChartFlutterBean.createSampleData3(),
        animate: animate,
        defaultRenderer: charts.PointRendererConfig(
          pointRendererDecorators: [
            charts.ComparisonPointsDecorator(
              symbolRenderer: charts.CylinderSymbolRenderer(),
            ),
          ],
        ),
      ),
    );

    // 条形
    widgetList.add(
      charts.BarChart(
        ChartFlutterBean.createSampleData(),
        animate: animate,
        barGroupingType: charts.BarGroupingType.groupedStacked,
      ),
    );

    // 柱状图
    widgetList.add(
      charts.BarChart(
        ChartFlutterBean().getData(),
        animate: animate,
        behaviors: [
          charts.SeriesLegend(
              position: charts.BehaviorPosition.end, desiredMaxRows: 2),
        ],
      ),
    );
  }
}
