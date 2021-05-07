part of flutter_charts;

/// Creates the segments for fast line series.
class FastLineSegment extends ChartSegment {
  Path _path;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    if (color != null) {
      fillPaint.color = color.withOpacity(series.opacity);
    }
    fillPaint.style = PaintingStyle.fill;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the stroke color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (series.gradient == null) {
      if (strokeColor != null) {
        strokePaint.color = strokeColor.withOpacity(series.opacity);
      }
    } else {
      strokePaint.color = series.gradient.colors[0];
    }
    strokePaint.strokeWidth = strokeWidth;
    strokePaint.style = PaintingStyle.stroke;
    strokePaint.strokeCap = StrokeCap.round;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    series.selectionSettings._selectionRenderer
        ._checkWithSelectionState(series.segments[0], series._chart);
    series.dashArray != null
        ? _drawDashedLine(canvas, series, strokePaint, _path)
        : canvas.drawPath(_path, strokePaint);
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    final Rect rect = _calculatePlotOffset(
        series._chart._chartAxis._axisClipRect,
        Offset(xAxis.plotOffset, yAxis.plotOffset));
    _CartesianChartPoint<dynamic> prevPoint, point;
    _ChartLocation currentLocation;
    _path = Path();
    final _VisibleRange xVisibleRange = series._xAxis._visibleRange;
    final _VisibleRange yVisibleRange = series._yAxis._visibleRange;
    final List<_CartesianChartPoint<dynamic>> seriesPoints = series._dataPoints;
    final Rect areaBounds = series._chart._chartAxis._axisClipRect;
    final num xTolerance = (xVisibleRange.delta / areaBounds.width).abs();
    final num yTolerance = (yVisibleRange.delta / areaBounds.height).abs();
    num prevXValue = (seriesPoints.isNotEmpty &&
            seriesPoints[0] != null &&
            seriesPoints[0].xValue > xTolerance)
        ? 0
        : xTolerance;
    num prevYValue = (seriesPoints.isNotEmpty &&
            seriesPoints[0] != null &&
            seriesPoints[0].yValue > yTolerance)
        ? 0
        : yTolerance;
    num xVal = 0;
    num yVal = 0;

    ///Eliminating nearest points
    dynamic currentPoint;
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      currentPoint = series._dataPoints[pointIndex];
      xVal = currentPoint.xValue != null
          ? currentPoint.xValue
          : xVisibleRange.minimum;
      yVal = currentPoint.yValue != null
          ? currentPoint.yValue
          : yVisibleRange.minimum;
      if ((prevXValue - xVal).abs() >= xTolerance ||
          (prevYValue - yVal).abs() >= yTolerance) {
        point = currentPoint;
        if (point.isVisible) {
          currentLocation = _calculatePoint(point.xValue, point.yValue, xAxis,
              yAxis, series._chart._requireInvertedAxis, series, rect);
          point.markerPoint = currentLocation;
          if (prevPoint == null)
            _path.moveTo(currentLocation.x, currentLocation.y);
          else if (series._dataPoints[pointIndex - 1].isVisible == false &&
              series.emptyPointSettings.mode == EmptyPointMode.gap)
            _path.moveTo(currentLocation.x, currentLocation.y);
          else if (point.isGap != true &&
              series._dataPoints[pointIndex - 1].isGap != true &&
              series._dataPoints[pointIndex].isVisible == true)
            _path.lineTo(currentLocation.x, currentLocation.y);
          else
            _path.moveTo(currentLocation.x, currentLocation.y);
        }
        prevPoint = point;
        prevXValue = xVal;
        prevYValue = yVal;
      }
    }
  }
}
