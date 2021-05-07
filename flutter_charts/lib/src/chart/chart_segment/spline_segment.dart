part of flutter_charts;

/// Creates the segments for spline series.
class SplineSegment extends ChartSegment {
  num x1, y1, x2, y2, _x1Pos, _y1Pos, _x2Pos, _y2Pos;
  double startControlX, startControlY, endControlX, endControlY;
  _CartesianChartPoint<dynamic> _currentPoint;
  _CartesianChartPoint<dynamic> _nextPoint;
  Color _pointColorMapper;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    if (strokeColor != null) {
      fillPaint.color = strokeColor.withOpacity(series.opacity);
    }
    fillPaint.strokeWidth = strokeWidth;
    fillPaint.style = PaintingStyle.stroke;
    _defaultFillColor = fillPaint;
    return fillPaint;
  }

  /// Gets the stroke color of the series.
  @override
  Paint getStrokePaint() {
    final Paint strokePaint = Paint();
    if (series.gradient == null) {
      if (strokeColor != null) {
        strokePaint.color =
            _pointColorMapper ?? strokeColor.withOpacity(series.opacity);
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

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    x1 = _x1Pos;
    y1 = _y1Pos;
    x2 = _x2Pos;
    y2 = _y2Pos;
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    series.selectionSettings._selectionRenderer._checkWithSelectionState(
        series.segments[currentSegmentIndex], series._chart);

    /// Draw spline series
    if (series.animationDuration > 0 &&
        series._chart._chartState.widgetNeedUpdate &&
        !series._chart._chartState._isLegendToggled &&
        series._chart._chartState.prevWidgetSeries != null &&
        series._chart._chartState.prevWidgetSeries.isNotEmpty &&
        oldSeries != null &&
        oldSeries.segments.isNotEmpty &&
        oldSeries.segments[0] is SplineSegment &&
        series._chart._chartState.prevWidgetSeries.length - 1 >=
            series.segments[currentSegmentIndex]._seriesIndex &&
        series.segments[currentSegmentIndex].oldSeries.segments.isNotEmpty &&
        _currentPoint.isGap != true &&
        _nextPoint.isGap != true) {
      final SplineSegment currentSegment = series.segments[currentSegmentIndex];
      final SplineSegment oldSegment =
          (currentSegment.oldSeries.segments.length - 1 >= currentSegmentIndex)
              ? currentSegment.oldSeries.segments[currentSegmentIndex]
              : null;
      _animateLineTypeSeries(
        canvas,
        series,
        strokePaint,
        animationFactor,
        currentSegment.x1,
        currentSegment.y1,
        currentSegment.x2,
        currentSegment.y2,
        oldSegment?.x1,
        oldSegment?.y1,
        oldSegment?.x2,
        oldSegment?.y2,
        currentSegment?.startControlX,
        currentSegment?.startControlY,
        oldSegment?.startControlX,
        oldSegment?.startControlY,
        currentSegment.endControlX,
        currentSegment.endControlY,
        oldSegment?.endControlX,
        oldSegment?.endControlY,
      );
    } else {
      final Path path = Path();
      path.moveTo(x1, y1);
      if (_currentPoint.isGap != true && _nextPoint.isGap != true) {
        path.cubicTo(
            startControlX, startControlY, endControlX, endControlY, x2, y2);
        _drawDashedLine(canvas, series, strokePaint, path);
      }
    }
  }

  /// Method to set data.
  void _setData(List<num> values) {
    _x1Pos = values[0];
    _y1Pos = values[1];
    _x2Pos = values[2];
    _y2Pos = values[3];
    startControlX = values[4];
    startControlY = values[5];
    endControlX = values[6];
    endControlY = values[7];
  }
}
