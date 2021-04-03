part of flutter_charts;

/// Creates the segments for range column series.
class RangeColumnSegment extends ChartSegment {
  num x1;
  dynamic topLeft, topRight, bottomRight, bottomLeft, borderWidth;
  Path path;
  num low1, high1;
  BorderRadius _borderRadius;
  RRect _trackRect;
  _CartesianChartPoint<dynamic> _currentPoint;
  Paint _trackerFillPaint;
  Paint _trackerStrokePaint;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final bool hasPointColor = series.pointColorMapper != null ? true : false;

    /// Get and set the paint options for range column series.
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
    final RangeColumnSeries<dynamic, dynamic> _series = series;
    if (color != null) {
      _trackerFillPaint = Paint()
        ..color = _series.trackColor
        ..style = PaintingStyle.fill;
    }
    return _trackerFillPaint;
  }

  /// Method to get series tracker stroke color.
  Paint _getTrackerStrokePaint() {
    final RangeColumnSeries<dynamic, dynamic> _series = series;
    _trackerStrokePaint = Paint()
      ..color = _series.trackBorderColor
      ..strokeWidth = _series.trackBorderWidth
      ..style = PaintingStyle.stroke;
    _series.trackBorderWidth == 0
        ? _trackerStrokePaint.color = Colors.transparent
        : _trackerStrokePaint.color;
    return _trackerStrokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final RangeColumnSeries<dynamic, dynamic> _series = series;
    _borderRadius = _series.borderRadius;
    if (_currentPoint.region != null) {
      segmentRect = RRect.fromRectAndCorners(
        _currentPoint.region,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
      );
      //Tracker rect
      if (_series.isTrackVisible) {
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
    final RangeColumnSeries<dynamic, dynamic> _series = series;

    series.selectionSettings._selectionRenderer._checkWithSelectionState(
        series.segments[currentSegmentIndex], series._chart);

    if (_trackerFillPaint != null && _series.isTrackVisible) {
      canvas.drawRRect(_trackRect, _trackerFillPaint);
    }

    if (_trackerStrokePaint != null && _series.isTrackVisible) {
      canvas.drawRRect(_trackRect, _trackerStrokePaint);
    }

    if (fillPaint != null) {
      series.animationDuration > 0
          ? _animateRangeColumn(
              canvas, series, fillPaint, segmentRect, animationFactor)
          : canvas.drawRRect(segmentRect, fillPaint);
    }
    if (strokePaint != null) {
      if (series.dashArray[0] != 0 && series.dashArray[1] != 0) {
        _drawDashedLine(canvas, series, strokePaint, path);
      } else {
        series.animationDuration > 0
            ? _animateRangeColumn(
                canvas, series, strokePaint, segmentRect, animationFactor)
            : canvas.drawRRect(segmentRect, strokePaint);
      }
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    x1 = values[0];
    low1 = values[1];
    high1 = values[2];
  }
}
