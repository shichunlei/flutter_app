part of flutter_charts;

/// Creates the segments for stacked area series.
class StackedAreaSegment extends ChartSegment {
  Path _path, _strokePath;
  Rect _pathRect;

  ///Area series
  XyDataSeries<dynamic, dynamic> series;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    fillPaint = Paint();
    if (series.gradient == null) {
      if (color != null) {
        fillPaint.color = color;
        fillPaint.style = PaintingStyle.fill;
      }
    } else {
      fillPaint = (_pathRect != null)
          ? _getLinearGradientPaint(
              series.gradient, _pathRect, series._chart._requireInvertedAxis)
          : fillPaint;
    }
    fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (strokeColor != null) {
      strokePaint
        ..color = series.borderColor.withOpacity(series.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = series.borderWidth;
      series.borderWidth == 0
          ? strokePaint.color = Colors.transparent
          : strokePaint.color;
    }
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {}

  CartesianSeries<dynamic, dynamic> getPreviousSeries(
      List<CartesianSeries<dynamic, dynamic>> seriesCollection,
      num seriesIndex) {
    for (int i = 0; i < seriesCollection.length; i++) {
      if (seriesIndex == seriesCollection.indexOf(seriesCollection[i]) &&
          i != 0) {
        return seriesCollection[i - 1];
      }
    }
    return seriesCollection[0];
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    final Rect rect = series._chart._chartAxis._axisClipRect;
    _ChartLocation point1, point2;
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    _CartesianChartPoint<dynamic> point;
    StackedAreaSeries<dynamic, dynamic> stackedAreaSeries;
    stackedAreaSeries = series;
    int startPoint = 0;
    final _StackedValues stackedValues = series._stackingValues[0];
    List<CartesianSeries<dynamic, dynamic>> seriesCollection;
    CartesianSeries<dynamic, dynamic> previousSeries;
    _path = Path();
    _strokePath = Path();
    seriesCollection = _findSeriesCollection(series._chart);
    point1 = _calculatePoint(
        series._dataPoints[0].xValue,
        math_lib.max(yAxis._visibleRange.minimum, stackedValues.startValues[0]),
        xAxis,
        yAxis,
        series._chart._requireInvertedAxis,
        series,
        rect);
    _path.moveTo(point1.x, point1.y);
    _strokePath.moveTo(point1.x, point1.y);
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      point.symbolLocations = <_ChartLocation>[];
      point.regions = <Rect>[];
      if (point.isVisible) {
        point1 = _calculatePoint(
            series._dataPoints[pointIndex].xValue,
            stackedValues.endValues[pointIndex],
            xAxis,
            yAxis,
            series._chart._requireInvertedAxis,
            series,
            rect);
        _path.lineTo(point1.x, point1.y);
        _strokePath.lineTo(point1.x, point1.y);
      } else {
        if (series.emptyPointSettings.mode != EmptyPointMode.drop) {
          for (int j = pointIndex - 1; j >= startPoint; j--) {
            point2 = _calculatePoint(
                series._dataPoints[j].xValue,
                stackedValues.startValues[j],
                xAxis,
                yAxis,
                series._chart._requireInvertedAxis,
                series,
                rect);
            _path.lineTo(point2.x, point2.y);
            if (stackedAreaSeries.borderMode == AreaBorderMode.excludeBottom)
              _strokePath.lineTo(point1.x, point2.y);
            else if (stackedAreaSeries.borderMode == AreaBorderMode.all)
              _strokePath.lineTo(point2.x, point2.y);
          }
          if (series._dataPoints.length > pointIndex + 1 &&
              series._dataPoints[pointIndex + 1] != null &&
              series._dataPoints[pointIndex + 1].isVisible) {
            point1 = _calculatePoint(
                series._dataPoints[pointIndex + 1].xValue,
                stackedValues.startValues[pointIndex + 1],
                xAxis,
                yAxis,
                series._chart._requireInvertedAxis,
                series,
                rect);
            _path.moveTo(point1.x, point1.y);
            _strokePath.moveTo(point1.x, point1.y);
          }
          startPoint = pointIndex + 1;
        }
      }
    }
    for (int j = series._dataPoints.length - 1; j >= startPoint; j--) {
      previousSeries = getPreviousSeries(seriesCollection, _seriesIndex);
      if (previousSeries.emptyPointSettings.mode != EmptyPointMode.drop ||
          previousSeries._dataPoints[j].isVisible) {
        point2 = _calculatePoint(
            series._dataPoints[j].xValue,
            stackedValues.startValues[j],
            xAxis,
            yAxis,
            series._chart._requireInvertedAxis,
            series,
            rect);
        _path.lineTo(point2.x, point2.y);
        if (stackedAreaSeries.borderMode == AreaBorderMode.excludeBottom)
          _strokePath.lineTo(point1.x, point2.y);
        else if (stackedAreaSeries.borderMode == AreaBorderMode.all)
          _strokePath.lineTo(point2.x, point2.y);
      }
    }

    _pathRect = _path.getBounds();
    series.selectionSettings._selectionRenderer
        ._checkWithSelectionState(series.segments[0], series._chart);
    canvas.drawPath(
        _path, (series.gradient == null) ? fillPaint : getFillPaint());

    if (strokePaint.color != Colors.transparent)
      _drawDashedLine(canvas, series, strokePaint, _strokePath);
  }
}
