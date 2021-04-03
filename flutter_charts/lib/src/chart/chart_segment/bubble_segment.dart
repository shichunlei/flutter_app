part of flutter_charts;

/// Creates the segments for bubble series.
class BubbleSegment extends ChartSegment {
  ///X position of the bubble
  num centerX;

  ///Y position of the bubble
  num centerY;

  ///Radius of the bubble
  num radius;

  ///X value of the bubble
  num xData;

  ///Y value of the bubble
  num yData;

  ///Size of the bubble
  num size;

  ///Bubble series.
  XyDataSeries<dynamic, dynamic> series;

  _CartesianChartPoint<dynamic> _currentPoint;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final bool hasPointColor = series.pointColorMapper != null ? true : false;
    if (series.gradient == null) {
      if (color != null) {
        fillPaint = Paint()
          ..color = _currentPoint.isEmpty == true
              ? series.emptyPointSettings.color
              : ((hasPointColor && _currentPoint.pointColorMapper != null)
                  ? _currentPoint.pointColorMapper
                  : color)
          ..style = PaintingStyle.fill;
      }
    } else {
      fillPaint = _getLinearGradientPaint(series.gradient, _currentPoint.region,
          series._chart._requireInvertedAxis);
    }
    fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint()
      ..color = _currentPoint.isEmpty == true
          ? series.emptyPointSettings.borderColor
          : strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _currentPoint.isEmpty == true
          ? series.emptyPointSettings.borderWidth
          : strokeWidth;
    series.borderWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color;
    strokePaint.color = strokePaint.color == Colors.transparent
        ? strokePaint.color
        : strokePaint.color.withOpacity(series.opacity);
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    centerX = centerY = double.nan;
    final Rect rect = _calculatePlotOffset(
        series._chart._chartAxis._axisClipRect,
        Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
    final _ChartLocation currentPoint = _calculatePoint(
        xData,
        yData,
        series._xAxis,
        series._yAxis,
        series._chart._requireInvertedAxis,
        series,
        rect);
    centerX = currentPoint.x;
    centerY = currentPoint.y;
    radius = size;
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    series.selectionSettings._selectionRenderer._checkWithSelectionState(
        series.segments[currentSegmentIndex], series._chart);
    segmentRect = RRect.fromRectAndRadius(_currentPoint.region, Radius.zero);
    if (series._chart._chartState.widgetNeedUpdate &&
        !series._chart._chartState._isLegendToggled &&
        series._chart._chartState.prevWidgetSeries != null &&
        series._chart._chartState.prevWidgetSeries.isNotEmpty &&
        oldSeries.segments.isNotEmpty &&
        oldSeries.segments[0] is BubbleSegment &&
        series.animationDuration > 0 &&
        _oldPoint != null) {
      final BubbleSegment currentSegment = series.segments[currentSegmentIndex];
      final BubbleSegment oldSegment =
          (currentSegment.oldSeries.segments.length - 1 >= currentSegmentIndex)
              ? currentSegment.oldSeries.segments[currentSegmentIndex]
              : null;
      _animateBubbleSeries(
          canvas,
          centerX,
          centerY,
          oldSegment.centerX,
          oldSegment.centerY,
          oldSegment?.size,
          animationFactor,
          radius,
          strokePaint,
          fillPaint,
          series._chart.isTransposed);
    } else {
      canvas.drawCircle(
          Offset(centerX, centerY), radius * animationFactor, fillPaint);
      canvas.drawCircle(
          Offset(centerX, centerY), radius * animationFactor, strokePaint);
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    xData = values[0];
    yData = values[1];
    size = values[2];
  }
}
