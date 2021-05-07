part of flutter_charts;

/// Creates the segments for bar series.
class BarSegment extends ChartSegment {
  num x1, y1, x2, y2;
  BorderRadius _borderRadius;
  RRect _trackBarRect;
  _CartesianChartPoint<dynamic> _currentPoint;
  Paint _trackerFillPaint;
  Paint _trackerStrokePaint;
  dynamic topLeft, topRight, bottomRight, bottomLeft, borderWidth;
  Path path;

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
    strokePaint = Paint()
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

  /// Method to get series tracker fill.
  Paint _getTrackerFillPaint() {
    final BarSeries<dynamic, dynamic> barSeries = series;
    if (color != null) {
      _trackerFillPaint = Paint()
        ..color = barSeries.trackColor
        ..style = PaintingStyle.fill;
    }
    return _trackerFillPaint;
  }

  /// Method to get series tracker stroke color.
  Paint _getTrackerStrokePaint() {
    final BarSeries<dynamic, dynamic> barSeries = series;
    _trackerStrokePaint = Paint()
      ..color = barSeries.trackBorderColor
      ..strokeWidth = barSeries.trackBorderWidth
      ..style = PaintingStyle.stroke;
    barSeries.trackBorderWidth == 0
        ? _trackerStrokePaint.color = Colors.transparent
        : _trackerStrokePaint.color;
    return _trackerStrokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final BarSeries<dynamic, dynamic> barSeries = series;
    _borderRadius = barSeries.borderRadius;
    if (_currentPoint.region != null) {
      segmentRect = RRect.fromRectAndCorners(
        _currentPoint.region,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
      );
      //Tracker rect
      if (barSeries.isTrackVisible) {
        _trackBarRect = RRect.fromRectAndCorners(
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
    final BarSeries<dynamic, dynamic> barSeries = series;
    series.selectionSettings._selectionRenderer._checkWithSelectionState(
        series.segments[currentSegmentIndex], series._chart);
    if (_trackerFillPaint != null && barSeries.isTrackVisible) {
      series.animationDuration > 0
          ? _animateRectSeries(
              canvas,
              series,
              _trackerFillPaint,
              _trackBarRect,
              _currentPoint.yValue,
              animationFactor,
              _oldPoint != null ? _oldPoint.region : _oldRegion,
              _oldPoint?.yValue,
              _oldSeriesVisible)
          : canvas.drawRRect(_trackBarRect, _trackerFillPaint);
    }
    if (_trackerStrokePaint != null && barSeries.isTrackVisible) {
      series.animationDuration > 0
          ? _animateRectSeries(
              canvas,
              series,
              _trackerStrokePaint,
              _trackBarRect,
              _currentPoint.yValue,
              animationFactor,
              _oldPoint != null ? _oldPoint.region : _oldRegion,
              _oldPoint?.yValue,
              _oldSeriesVisible)
          : canvas.drawRRect(_trackBarRect, _trackerStrokePaint);
    }

    if (fillPaint != null) {
      series.animationDuration > 0
          ? _animateRectSeries(
              canvas,
              series,
              fillPaint,
              segmentRect,
              _currentPoint.yValue,
              animationFactor,
              _oldPoint != null ? _oldPoint.region : _oldRegion,
              _oldPoint?.yValue,
              _oldSeriesVisible)
          : canvas.drawRRect(segmentRect, fillPaint);
    }
    if (strokePaint != null) {
      if (series.dashArray[0] != 0 && series.dashArray[1] != 0) {
        _drawDashedLine(canvas, series, strokePaint, path);
      } else {
        series.animationDuration > 0
            ? _animateRectSeries(
                canvas,
                series,
                strokePaint,
                segmentRect,
                _currentPoint.yValue,
                animationFactor,
                _oldPoint != null ? _oldPoint.region : _oldRegion,
                _oldPoint?.yValue,
                _oldSeriesVisible)
            : canvas.drawRRect(segmentRect, strokePaint);
      }
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    x1 = values[0];
    y1 = values[1];
  }
}
