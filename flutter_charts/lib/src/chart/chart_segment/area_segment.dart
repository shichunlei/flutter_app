part of flutter_charts;

/// Creates the segments for area series.
class AreaSegment extends ChartSegment {
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

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    final Rect rect = series._chart._chartAxis._axisClipRect;
    _CartesianChartPoint<dynamic> prevPoint;
    _ChartLocation currentPoint, originPoint, oldPoint;
    final ChartAxis xAxis = series._xAxis;
    final ChartAxis yAxis = series._yAxis;
    _CartesianChartPoint<dynamic> point, _point;
    final AreaSeries<dynamic, dynamic> areaSeries = series;
    _path = Path();
    _strokePath = Path();
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      if (point.isVisible || point.isDrop) {
        _point = (series.animationDuration > 0 &&
                series._chart._chartState.widgetNeedUpdate &&
                !series._chart._chartState._isLegendToggled &&
                series._chart._chartState.prevWidgetSeries != null &&
                series._chart._chartState.prevWidgetSeries.isNotEmpty &&
                oldSeries != null &&
                oldSeries.segments.isNotEmpty &&
                oldSeries.segments[0] is AreaSegment &&
                series._chart._chartState.prevWidgetSeries.length - 1 >=
                    _seriesIndex &&
                oldSeries._dataPoints.length - 1 >= pointIndex)
            ? oldSeries._dataPoints[pointIndex]
            : null;
        oldPoint = _point != null
            ? _calculatePoint(
                _point.xValue,
                _point.yValue,
                oldSeries._xAxis,
                oldSeries._yAxis,
                series._chart._requireInvertedAxis,
                oldSeries,
                rect)
            : null;
        currentPoint = _calculatePoint(point.xValue, point.yValue, xAxis, yAxis,
            series._chart._requireInvertedAxis, series, rect);
        originPoint = _calculatePoint(
            point.xValue,
            math_lib.max(yAxis._visibleRange.minimum, 0),
            xAxis,
            yAxis,
            series._chart._requireInvertedAxis,
            series,
            rect);
        num x = currentPoint.x;
        num y = currentPoint.y;
        if (oldPoint != null) {
          if (series._chart.isTransposed) {
            x = _getValue(animationFactor, x, oldPoint.x, currentPoint.x);
          } else {
            y = _getValue(animationFactor, y, oldPoint.y, currentPoint.y);
          }
        }
        if (prevPoint == null ||
            series._dataPoints[pointIndex - 1].isGap == true ||
            (series._dataPoints[pointIndex].isGap == true) ||
            (series._dataPoints[pointIndex - 1].isVisible == false &&
                series.emptyPointSettings.mode == EmptyPointMode.gap)) {
          _path.moveTo(originPoint.x, originPoint.y);
          if (areaSeries.borderMode == AreaBorderMode.excludeBottom) {
            if (series._dataPoints[pointIndex].isGap != true) {
              _strokePath.moveTo(originPoint.x, originPoint.y);
              _strokePath.lineTo(x, y);
            }
          } else if (areaSeries.borderMode == AreaBorderMode.all) {
            if (series._dataPoints[pointIndex].isGap != true) {
              _strokePath.moveTo(originPoint.x, originPoint.y);
              _strokePath.lineTo(x, y);
            }
          } else if (areaSeries.borderMode == AreaBorderMode.top) {
            _strokePath.moveTo(x, y);
          }
          _path.lineTo(x, y);
        } else if (pointIndex == series._dataPoints.length - 1 ||
            series._dataPoints[pointIndex + 1].isGap == true) {
          _strokePath.lineTo(x, y);
          if (areaSeries.borderMode == AreaBorderMode.excludeBottom)
            _strokePath.lineTo(originPoint.x, originPoint.y);
          else if (areaSeries.borderMode == AreaBorderMode.all) {
            _strokePath.lineTo(originPoint.x, originPoint.y);
            _strokePath.close();
          }
          _path.lineTo(x, y);
          _path.lineTo(originPoint.x, originPoint.y);
        } else {
          _strokePath.lineTo(x, y);
          _path.lineTo(x, y);
        }
        prevPoint = point;
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
