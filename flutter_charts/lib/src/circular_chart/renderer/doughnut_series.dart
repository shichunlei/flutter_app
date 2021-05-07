part of flutter_charts;

//// Renders the doughnut series.
class DoughnutSeries<T, D> extends CircularSeries<T, D> {
  DoughnutSeries(
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
      String innerRadius,
      bool explode,
      bool explodeAll,
      int explodeIndex,
      String explodeOffset,
      ActivationMode explodeGesture,
      double groupTo,
      CircularChartGroupMode groupMode,
      EmptyPointSettings emptyPointSettings,
      Color strokeColor,
      double strokeWidth,
      DataLabelSettings dataLabelSettings,
      bool enableTooltip,
      bool enableSmartLabels,
      String name,
      double opacity,
      double animationDuration,
      SelectionSettings selectionSettings,
      SortingOrder sortingOrder,
      LegendIconType legendIconType,
      CornerStyle cornerStyle,
      List<int> initialSelectedDataIndexes})
      : super(
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
          animationDuration: animationDuration,
          startAngle: startAngle,
          endAngle: endAngle,
          radius: radius,
          innerRadius: innerRadius,
          explode: explode,
          opacity: opacity,
          explodeAll: explodeAll,
          explodeIndex: explodeIndex,
          explodeOffset: explodeOffset,
          explodeGesture: explodeGesture,
          groupMode: groupMode,
          groupTo: groupTo,
          emptyPointSettings: emptyPointSettings,
          borderColor: strokeColor,
          borderWidth: strokeWidth,
          dataLabelSettings: dataLabelSettings,
          enableTooltip: enableTooltip,
          name: name,
          selectionSettings: selectionSettings,
          legendIconType: legendIconType,
          sortingOrder: sortingOrder,
          enableSmartLabels: enableSmartLabels,
          cornerStyle: cornerStyle,
          initialSelectedDataIndexes: initialSelectedDataIndexes,
        );
}

class _DoughnutChartPainter extends CustomPainter {
  _DoughnutChartPainter({
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

  DoughnutSeries<dynamic, dynamic> series;

  num innerRadius;

  num radius;

  @override
  void paint(Canvas canvas, Size size) {
    num pointStartAngle;
    series = chart._chartSeries.visibleSeries[index];
    pointStartAngle = series._start;
    innerRadius = series._currentInnerRadius;
    radius = series._currentRadius;
    _ChartPoint<dynamic> point;
    series._pointRegions = <_Region>[];
    _ChartPoint<dynamic> oldPoint;
    final DoughnutSeries<dynamic, dynamic> oldSeries =
        (chart._chartState.widgetNeedUpdate &&
                !chart._chartState._isLegendToggled &&
                chart._chartState.prevSeries._seriesType == 'doughnut')
            ? chart._chartState.prevSeries
            : null;
    for (int i = 0; i < series._renderPoints.length; i++) {
      point = series._renderPoints[i];
      oldPoint = (oldSeries != null &&
              oldSeries._renderPoints != null &&
              (oldSeries._renderPoints.length - 1 >= i))
          ? oldSeries._renderPoints[i]
          : ((chart._chartState._isLegendToggled &&
                  chart._chartState.prevSeries._seriesType == 'doughnut')
              ? chart._chartState._oldPoints[i]
              : null);
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
          1,
          _checkIsAnyPointSelect(series, point, chart),
          oldPoint,
          chart._chartState._oldPoints);
    }
  }

  @override
  bool shouldRepaint(_DoughnutChartPainter oldDelegate) => isRepaint;
}
