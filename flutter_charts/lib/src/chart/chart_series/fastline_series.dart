part of flutter_charts;

/// Renders the fast line series.
class FastLineSeries<T, D> extends XyDataSeries<T, D> {
  FastLineSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      String xAxisName,
      String yAxisName,
      Color color,
      double width,
      List<double> dashArray,
      LinearGradient gradient,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      SortingOrder sortingOrder,
      bool isVisible,
      String name,
      bool enableTooltip,
      double animationDuration,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      String legendItemText,
      double opacity})
      : super(
            name: name,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            color: color,
            width: width ?? 2,
            gradient: gradient,
            dashArray: dashArray,
            markerSettings: markerSettings,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabelSettings,
            isVisible: isVisible,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity);

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => FastLineSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() => _createSegment(_dataPoints);

  /// FastLine segment is created here
  void _createSegment(List<_CartesianChartPoint<dynamic>> values) {
    final FastLineSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.series = this;
      segment.calculateSegmentPoints();
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
    segment.strokeColor = segment.series._seriesColor;
    segment.strokeWidth = segment.series.width;
  }

  ///Draws marker with different shape and color of the appropriate data point in the series.
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
