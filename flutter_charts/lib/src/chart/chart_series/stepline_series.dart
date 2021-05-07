part of flutter_charts;

/// Renders the step line series.
class StepLineSeries<T, D> extends XyDataSeries<T, D> {
  StepLineSeries(
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
      double width,
      LinearGradient gradient,
      MarkerSettings markerSettings,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      bool enableTooltip,
      List<double> dashArray,
      double animationDuration,
      SelectionSettings selectionSettings,
      SortingOrder sortingOrder,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      String legendItemText,
      double opacity})
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
            width: width ?? 2,
            gradient: gradient,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            dashArray: dashArray,
            isVisible: isVisible,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity);

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => StepLineSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() {
    List<num> values = <num>[];
    int segmentIndex = 0;
    for (int i = 0; i < _dataPoints.length; i++) {
      if (_dataPoints.length > 1) {
        if (values != null && values.isNotEmpty && values.length > 2) {
          values[0] = values[2];
          values[1] = values[3];
          values.removeRange(2, 4);
        }
        if (_dataPoints[i].isVisible) {
          if (_dataPoints[i].isGap != true) {
            if (values.isEmpty ||
                (values.isNotEmpty &&
                    !(values[0] == _dataPoints[i].xValue &&
                        values[1] == _dataPoints[i].yValue))) {
              values.add(_dataPoints[i].xValue);
              values.add(_dataPoints[i].yValue);
            }
          }
          if ((i == 0 || _dataPoints[i - 1].isGap == true) &&
              _dataPoints[i].isGap != true &&
              _dataPoints[i + 1].isGap != true &&
              _dataPoints[i + 1].isVisible) {
            values.add(_dataPoints[i + 1].xValue);
            values.add(_dataPoints[i + 1].yValue);
          } else if (_dataPoints[i].isGap == true) {
            values = <num>[];
          }
        }
      }

      if (values != null && values.isNotEmpty && values.length > 2) {
        _createSegment(values, _dataPoints[i], segmentIndex,
            _dataPoints[segmentIndex].pointColorMapper);
        segmentIndex++;
      }
    }
  }

  /// StepLine segment is created here
  void _createSegment(
      List<num> values,
      _CartesianChartPoint<dynamic> currentPoint,
      int segmentIndex,
      Color pointColorMapper) {
    final StepLineSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment.currentSegmentIndex = segmentIndex;
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.series = this;
      segment._presentPoint = currentPoint;
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
      segment._pointColorMapper = pointColorMapper;
      segment.setData(values);
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
