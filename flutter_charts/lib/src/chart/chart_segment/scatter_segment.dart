part of flutter_charts;

/// Creates the segments for scatter series.
class ScatterSegment extends ChartSegment {
  ///X position of the scatter
  num centerX;

  ///Y position of the scatter
  num centerY;

  ///Radius of the scatter
  num radius;

  ///X value of the scatter
  num xData;

  ///Y value of the scatter
  num yData;

  ///Size of the scatter
  num size;
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
              : (((hasPointColor && _currentPoint.pointColorMapper != null) &&
                      _currentPoint.pointColorMapper != null)
                  ? _currentPoint.pointColorMapper
                  : color)
          ..style = PaintingStyle.fill;
      }
    } else {
      fillPaint = _getLinearGradientPaint(series.gradient, _currentPoint.region,
          series._chart._requireInvertedAxis);
    }
    _defaultFillColor = fillPaint;
    fillPaint.color = fillPaint.color.withOpacity(series.opacity);
    return fillPaint;
  }

  /// Gets the border color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint()
      ..color = _currentPoint.isEmpty == true
          ? series.emptyPointSettings.borderColor
          : series.markerSettings.isVisible
              ? series.markerSettings.borderColor ?? series._seriesColor
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
    if (fillPaint != null) {
      series.animationDuration > 0
          ? _animateScatterSeries(series, _point, _oldPoint, animationFactor,
              canvas, fillPaint, strokePaint)
          : series.drawDataMarker(currentSegmentIndex, canvas, fillPaint,
              strokePaint, _point.markerPoint.x, _point.markerPoint.y);
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    xData = values[0];
    yData = values[1];
    size = values[2];
  }
}
