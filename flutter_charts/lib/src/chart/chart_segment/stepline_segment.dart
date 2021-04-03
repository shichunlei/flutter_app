part of flutter_charts;

/// Creates the segments for step line series.
class StepLineSegment extends ChartSegment {
  num x1, y1, x2, y2, x3, y3, _x1Pos, _y1Pos, _x2Pos, _y2Pos, _midX, _midY;
  _CartesianChartPoint<dynamic> _presentPoint;
  Color _pointColorMapper;

  /// Gets the color of the series.
  @override
  Paint getFillPaint() {
    final Paint fillPaint = Paint();
    if (color != null) {
      fillPaint.color = color.withOpacity(series.opacity);
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
    strokePaint.strokeCap = StrokeCap.square;
    _defaultStrokeColor = strokePaint;
    return strokePaint;
  }

  /// Calculates the rendering bounds of a segment.
  @override
  void calculateSegmentPoints() {
    final dynamic start = series._xAxis._visibleRange.minimum;
    final dynamic end = series._xAxis._visibleRange.maximum;
    x1 = y1 = x2 = y2 = double.nan;
    final Rect rect = _calculatePlotOffset(
        series._chart._chartAxis._axisClipRect,
        Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
    if ((_x1Pos != null &&
            _x2Pos != null &&
            _y1Pos != null &&
            _y2Pos != null) &&
        ((_x1Pos >= start && _x1Pos <= end) ||
            (_x2Pos >= start && _x2Pos <= end) ||
            (start >= _x1Pos && start <= _x2Pos))) {
      final _ChartLocation currentPoint = _calculatePoint(
          _x1Pos,
          _y1Pos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);
      final _ChartLocation nextPoint = _calculatePoint(
          _x2Pos,
          _y2Pos,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);
      final _ChartLocation midPoint = _calculatePoint(
          _midX,
          _midY,
          series._xAxis,
          series._yAxis,
          series._chart._requireInvertedAxis,
          series,
          rect);
      x1 = currentPoint.x;
      y1 = currentPoint.y;
      x2 = nextPoint.x;
      y2 = nextPoint.y;
      x3 = midPoint.x;
      y3 = midPoint.y;
      segmentRect = RRect.fromRectAndRadius(_presentPoint.region, Radius.zero);
    }
  }

  /// Draws segment in series bounds.
  @override
  void onPaint(Canvas canvas) {
    final Path path = Path();
    series.selectionSettings._selectionRenderer._checkWithSelectionState(
        series.segments[currentSegmentIndex], series._chart);
    if (series.animationDuration > 0 &&
        series._chart._chartState.widgetNeedUpdate &&
        !series._chart._chartState._isLegendToggled &&
        series._chart._chartState.prevWidgetSeries != null &&
        series._chart._chartState.prevWidgetSeries.isNotEmpty &&
        oldSeries != null &&
        oldSeries.segments.isNotEmpty &&
        oldSeries.segments[0] is StepLineSegment &&
        series._chart._chartState.prevWidgetSeries.length - 1 >=
            series.segments[currentSegmentIndex]._seriesIndex &&
        series.segments[currentSegmentIndex].oldSeries.segments.isNotEmpty) {
      final StepLineSegment currentSegment =
          series.segments[currentSegmentIndex];
      final StepLineSegment oldSegment =
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
        currentSegment.x3,
        currentSegment.y3,
        oldSegment?.x3,
        oldSegment?.y3,
      );
    } else {
      path.moveTo(x1, y1);
      path.lineTo(x3, y3);
      path.lineTo(x2, y2);
      _drawDashedLine(canvas, series, strokePaint, path);
    }
  }

  /// Method to set data.
  void setData(List<num> values) {
    _x1Pos = values[0];
    _y1Pos = values[1];
    _x2Pos = values[2];
    _y2Pos = values[3];
    _midX = _x2Pos;
    _midY = _y1Pos;
  }
}
