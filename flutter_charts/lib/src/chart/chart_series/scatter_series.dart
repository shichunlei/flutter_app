part of flutter_charts;

/// Renders the scatter series.
class ScatterSeries<T, D> extends XyDataSeries<T, D> {
  ScatterSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      bool isVisible,
      DataLabelSettings dataLabelSettings,
      bool enableTooltip,
      double animationDuration,
      Color borderColor,
      double borderWidth,
      LinearGradient gradient,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      SortingOrder sortingOrder,
      String legendItemText,
      double opacity,
      List<int> initialSelectedDataIndexes})
      : super(
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
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            isVisible: isVisible,
            animationDuration: animationDuration,
            borderColor: borderColor,
            borderWidth: borderWidth,
            gradient: gradient,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            initialSelectedDataIndexes: initialSelectedDataIndexes);

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => ScatterSegment();

  _CartesianChartPoint<dynamic> _point;

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() {
    int segmentIndex = 0;
    for (int i = 0; i < _dataPoints.length; i++) {
      if (_dataPoints[i].isVisible && _dataPoints[i].isGap != true) {
        final List<num> values = <num>[];
        values.add(_dataPoints[i].xValue);
        values.add(_dataPoints[i].yValue);
        values.add(markerSettings.width);
        _point = _dataPoints[i];
        _createSegment(values, _dataPoints[i], segmentIndex);
        segmentIndex++;
      }
    }
  }

  /// Scatter segment is created here
  void _createSegment(List<num> values,
      _CartesianChartPoint<dynamic> currentPoint, int segmentIndex) {
    final ScatterSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.currentSegmentIndex = segmentIndex;
      segment.series = this;
      segment._point = currentPoint;
      segment._currentPoint = currentPoint;
      segment._setData(values);
      segment.calculateSegmentPoints();
      if (_chart._chartState.widgetNeedUpdate &&
          !_chart._chartState._isLegendToggled &&
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
        segment._oldPoint = (segment.oldSeries.segments.isNotEmpty &&
                segment.oldSeries.segments[0] is ScatterSegment &&
                segment.oldSeries._dataPoints.length - 1 >= segmentIndex)
            ? segment.oldSeries._dataPoints[segmentIndex]
            : null;
      }
      segment.segmentRect =
          RRect.fromRectAndRadius(currentPoint.region, Radius.zero);
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
