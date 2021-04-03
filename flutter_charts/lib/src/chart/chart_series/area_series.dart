part of flutter_charts;

/// Renders the area series.
class AreaSeries<T, D> extends XyDataSeries<T, D> {
  AreaSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      SortingOrder sortingOrder,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      bool enableTooltip,
      List<double> dashArray,
      double animationDuration,
      Color borderColor,
      double borderWidth,
      LinearGradient gradient,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      String legendItemText,
      double opacity,
      AreaBorderMode borderMode})
      : borderMode = borderMode ?? AreaBorderMode.top,
        super(
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            name: name,
            color: color,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            dashArray: dashArray,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            gradient: gradient,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity);

  ///Border type of area series.
  ///
  ///Defaults to AreaBorderMode.top
  ///
  ///Also refer [AreaBorderMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <AreaSeries<SalesData, num>>[
  ///                AreaSeries<SalesData, num>(
  ///                  borderMode: AreaBorderMode.all,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final AreaBorderMode borderMode;

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => AreaSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() => _createSegment(_dataPoints);

  /// Area segment is created here
  void _createSegment(List<_CartesianChartPoint<dynamic>> dataPoints) {
    final AreaSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.series = this;
      if (_chart._chartState.widgetNeedUpdate &&
          _xAxis._zoomFactor == 1 &&
          _yAxis._zoomFactor == 1 &&
          _chart._chartState.prevWidgetSeries != null &&
          _chart._chartState.prevWidgetSeries.isNotEmpty &&
          _chart._chartState.prevWidgetSeries.length - 1 >=
              segment._seriesIndex &&
          _chart._chartState.prevWidgetSeries[segment._seriesIndex]
                  ._seriesName ==
              segment.series._seriesName) {
        segment.oldSeries =
            _chart._chartState.prevWidgetSeries[segment._seriesIndex];
      }
      customizeSegment(segment);
      segment.strokePaint = segment.getStrokePaint();
      segment.fillPaint = segment.getFillPaint();
      segments.add(segment);
    }
  }

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    segment.color = segment.series._seriesColor;
    segment.strokeColor = segment.series.borderColor;
    segment.strokeWidth = segment.series.borderWidth;
  }

  /// Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY) {
    canvas.drawPath(_markerShapes[index], strokePaint);
    canvas.drawPath(_markerShapes[index], fillPaint);
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
          double pointY, int angle, ChartTextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);
}
