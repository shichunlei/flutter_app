part of flutter_charts;

/// Creates the segments for stacked column series.
class StackedColumnSegment extends ChartSegment {
  num x1, y1, x2, y2;
  double stackValues;
  BorderRadius _borderRadius;
  _CartesianChartPoint<dynamic> _currentPoint;
  Path path;
  RRect _trackRect;
  dynamic topLeft, topRight, bottomRight, bottomLeft, borderWidth;
  Paint _trackerFillPaint;
  Paint _trackerStrokePaint;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final bool hasPointColor = series.pointColorMapper != null ? true : false;

    /// Get and set the paint options for column series.
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
    if (fillPaint.color != Colors.transparent)
      fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    if (strokeColor != null) {
      strokePaint = Paint()
        ..color = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderColor
            : strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _currentPoint.isEmpty == true
            ? series.emptyPointSettings.borderWidth
            : strokeWidth;
      _defaultStrokeColor = strokePaint;
    }
    series.borderWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color;
    strokePaint.color = strokePaint.color == Colors.transparent
        ? strokePaint.color
        : strokePaint.color.withOpacity(series.opacity);
    return strokePaint;
  }

  /// Method to get series tracker fill.
  Paint _getTrackerFillPaint() {
    final StackedColumnSeries<dynamic, dynamic> columnSeries = series;
    if (color != null) {
      _trackerFillPaint = Paint()
        ..color = columnSeries.trackColor
        ..style = PaintingStyle.fill;
    }
    return _trackerFillPaint;
  }

  /// Method to get series tracker stroke color.
  Paint _getTrackerStrokePaint() {
    final StackedColumnSeries<dynamic, dynamic> columnSeries = series;
    _trackerStrokePaint = Paint()
      ..color = columnSeries.trackBorderColor
      ..strokeWidth = columnSeries.trackBorderWidth
      ..style = PaintingStyle.stroke;
    columnSeries.trackBorderWidth == 0
        ? _trackerStrokePaint.color = Colors.transparent
        : _trackerStrokePaint.color;
    return _trackerStrokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final StackedColumnSeries<dynamic, dynamic> stackedColumnSeries = series;
    _borderRadius = stackedColumnSeries.borderRadius;
    if (_currentPoint.region != null) {
      segmentRect = RRect.fromRectAndCorners(
        _currentPoint.region,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
      );
      if (stackedColumnSeries.isTrackVisible) {
        _trackRect = RRect.fromRectAndCorners(
          _currentPoint.trackerRectRegion,
          bottomLeft: _borderRadius.bottomLeft,
          bottomRight: _borderRadius.bottomRight,
          topLeft: _borderRadius.topLeft,
          topRight: _borderRadius.topRight,
        );
      }
    }

    topLeft = _currentPoint.region.topLeft;
    topRight = _currentPoint.region.topRight;
    bottomLeft = _currentPoint.region.bottomLeft;
    bottomRight = _currentPoint.region.bottomRight;
    borderWidth = series.borderWidth / 2;
    path = Path();
    path.moveTo(topLeft.dx + borderWidth, topLeft.dy + borderWidth);
    path.lineTo(topRight.dx - borderWidth, topRight.dy + borderWidth);
    path.lineTo(bottomRight.dx - borderWidth, bottomRight.dy - borderWidth);
    path.lineTo(bottomLeft.dx + borderWidth, bottomLeft.dy - borderWidth);
    path.lineTo(topLeft.dx + borderWidth, topLeft.dy + borderWidth);
    path.close();
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    final StackedColumnSeries<dynamic, dynamic> stackedColumnSeries = series;

    if (_trackerFillPaint != null && stackedColumnSeries.isTrackVisible) {
      canvas.drawRRect(_trackRect, _trackerFillPaint);
    }

    if (_trackerStrokePaint != null && stackedColumnSeries.isTrackVisible) {
      canvas.drawRRect(_trackRect, _trackerStrokePaint);
    }

    if (fillPaint != null) {
      series.animationDuration > 0
          ? _animateStackedRectSeries(canvas, segmentRect, fillPaint, series,
              animationFactor, _currentPoint, series._chart)
          : canvas.drawRRect(segmentRect, fillPaint);
    }
    if (strokePaint != null) {
      if (series.dashArray[0] != 0 && series.dashArray[1] != 0) {
        series.animationDuration > 0
            ? _animateStackedRectSeries(canvas, segmentRect, strokePaint,
                series, animationFactor, _currentPoint, series._chart)
            : _drawDashedLine(canvas, series, strokePaint, path);
      } else
        series.animationDuration > 0
            ? _animateStackedRectSeries(canvas, segmentRect, strokePaint,
                series, animationFactor, _currentPoint, series._chart)
            : canvas.drawPath(path, strokePaint);
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    x1 = values[0];
    y1 = values[1];
  }
}
