part of flutter_charts;

/// Renders the pie series.
class PieSeries<T, D> extends CircularSeries<T, D> {
  PieSeries(
      {List<T> dataSource,
      ChartValueMapper<T, D> xValueMapper,
      ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> pointRadiusMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      ChartValueMapper<T, String> sortFieldValueMapper,
      int startAngle,
      int endAngle,
      String radius,
      bool explode,
      bool explodeAll,
      int explodeIndex,
      ActivationMode explodeGesture,
      String explodeOffset,
      double groupTo,
      CircularChartGroupMode groupMode,
      EmptyPointSettings emptyPointSettings,
      Color strokeColor,
      double strokeWidth,
      double opacity,
      DataLabelSettings dataLabelSettings,
      bool enableTooltip,
      bool enableSmartLabels,
      String name,
      double animationDuration,
      SelectionSettings selectionSettings,
      SortingOrder sortingOrder,
      LegendIconType legendIconType,
      List<int> initialSelectedDataIndexes})
      : super(
            animationDuration: animationDuration,
            dataSource: dataSource,
            xValueMapper: (int index) => xValueMapper(dataSource[index], index),
            yValueMapper: (int index) => yValueMapper(dataSource[index], index),
            pointColorMapper: (int index) => pointColorMapper != null
                ? pointColorMapper(dataSource[index], index)
                : null,
            pointRadiusMapper: pointRadiusMapper == null
                ? null
                : (int index) => pointRadiusMapper(dataSource[index], index),
            dataLabelMapper: (int index) => dataLabelMapper != null
                ? dataLabelMapper(dataSource[index], index)
                : null,
            sortFieldValueMapper: sortFieldValueMapper != null
                ? (int index) => sortFieldValueMapper(dataSource[index], index)
                : null,
            startAngle: startAngle,
            endAngle: endAngle,
            radius: radius,
            explode: explode,
            explodeAll: explodeAll,
            explodeIndex: explodeIndex,
            explodeOffset: explodeOffset,
            explodeGesture: explodeGesture,
            groupTo: groupTo,
            groupMode: groupMode,
            emptyPointSettings: emptyPointSettings,
            initialSelectedDataIndexes: initialSelectedDataIndexes,
            borderColor: strokeColor,
            borderWidth: strokeWidth,
            opacity: opacity,
            dataLabelSettings: dataLabelSettings,
            enableTooltip: enableTooltip,
            name: name,
            selectionSettings: selectionSettings,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            enableSmartLabels: enableSmartLabels);
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter({
    this.chart,
    this.index,
    this.isRepaint,
    this.animationController,
    this.seriesAnimation,
    ValueNotifier<num> notifier,
  }) : super(repaint: notifier);
  final SfCircularChart chart;
  final int index;
  final bool isRepaint;
  final AnimationController animationController;
  final Animation<double> seriesAnimation;
  PieSeries<dynamic, dynamic> series;
  static _ChartPoint<dynamic> point;
  @override
  void paint(Canvas canvas, Size size) {
    num pointStartAngle;
    series = chart._chartSeries.visibleSeries[index];
    pointStartAngle = series._start;
    series._pointRegions = <_Region>[];
    bool isAnyPointNeedSelect = false;
    if (chart._chartState.initialRender) {
      isAnyPointNeedSelect = _checkIsAnyPointSelect(series, point, chart);
    }
    _ChartPoint<dynamic> oldPoint;
    final PieSeries<dynamic, dynamic> oldSeries =
        (chart._chartState.widgetNeedUpdate &&
                !chart._chartState._isLegendToggled &&
                chart._chartState.prevSeries._seriesType == 'pie')
            ? chart._chartState.prevSeries
            : null;
    for (int i = 0; i < series._renderPoints.length; i++) {
      point = series._renderPoints[i];
      oldPoint = (oldSeries != null &&
              oldSeries._renderPoints != null &&
              (oldSeries._renderPoints.length - 1 >= i))
          ? oldSeries._renderPoints[i]
          : ((chart._chartState._isLegendToggled &&
                  chart._chartState.prevSeries._seriesType == 'pie')
              ? chart._chartState._oldPoints[i]
              : null);
      point.innerRadius = 0.0;
      pointStartAngle = series._renderPoint(
          chart,
          series,
          point,
          pointStartAngle,
          point.innerRadius,
          point.outerRadius,
          canvas,
          index,
          i,
          seriesAnimation != null ? seriesAnimation?.value : 1,
          seriesAnimation != null ? seriesAnimation?.value : 1,
          isAnyPointNeedSelect,
          oldPoint,
          chart._chartState._oldPoints);
    }
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) => isRepaint;
}
