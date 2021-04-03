part of flutter_charts;

class _CrosshairPainter extends CustomPainter {
  _CrosshairPainter({this.chart, this.valueNotifier})
      : super(repaint: valueNotifier) {
    canResetPath = null;
  }
  final SfCartesianChart chart;
  ValueNotifier<int> valueNotifier;
  double pointerLength;
  double pointerWidth;
  double nosePointY = 0;
  double nosePointX = 0;
  double totalWidth = 0;
  double x;
  double y;
  double xPos;
  double yPos;
  bool isTop = false;
  double cornerRadius;
  Path backgroundPath = Path();
  bool canResetPath;
  bool isLeft = false;
  bool isRight = false;
  bool enable;
  double padding = 0;
  List<String> stringValue = <String>[];
  Rect boundaryRect = const Rect.fromLTWH(0, 0, 0, 0);
  double leftPadding = 0;
  double topPadding = 0;
  bool isHorizontalOrientation = false;
  TextStyle labelStyle;

  @override
  void paint(Canvas canvas, Size size) {
    if (canResetPath != null && !canResetPath) {
      chart.crosshairBehavior.onPaint(canvas);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  /// calculate trackball points
  void _generateAllPoints(Offset position) {
    final Rect seriesBounds = chart._chartAxis._axisClipRect;
    if (seriesBounds.contains(position)) {
      chart.crosshairBehavior._position = position;
    }
  }

  Paint _getLinePainter(Paint crosshairLinePaint) => crosshairLinePaint;

  void _drawCrosshairLine(Canvas canvas, Paint paint, int index) {
    if (chart.crosshairBehavior._position != null) {
      final Path dashArrayPath = Path();
      if (chart.crosshairBehavior.lineType == CrosshairLineType.both) {
        final Path dashArrayVerticalPath = Path();
        dashArrayVerticalPath.moveTo(chart._chartAxis._axisClipRect.left,
            chart.crosshairBehavior._position.dy);
        dashArrayVerticalPath.lineTo(chart._chartAxis._axisClipRect.right,
            chart.crosshairBehavior._position.dy);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayVerticalPath)
            : canvas.drawPath(dashArrayVerticalPath, paint);
        final Path dashArrayHorizontalPath = Path();
        dashArrayHorizontalPath.moveTo(chart.crosshairBehavior._position.dx,
            chart._chartAxis._axisClipRect.top);
        dashArrayHorizontalPath.lineTo(chart.crosshairBehavior._position.dx,
            chart._chartAxis._axisClipRect.bottom);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayHorizontalPath)
            : canvas.drawPath(dashArrayHorizontalPath, paint);
      } else if (chart.crosshairBehavior.lineType ==
          CrosshairLineType.horizontal) {
        dashArrayPath.moveTo(chart._chartAxis._axisClipRect.left,
            chart.crosshairBehavior._position.dy);
        dashArrayPath.lineTo(chart._chartAxis._axisClipRect.right,
            chart.crosshairBehavior._position.dy);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      } else if (chart.crosshairBehavior.lineType ==
          CrosshairLineType.vertical) {
        dashArrayPath.moveTo(chart.crosshairBehavior._position.dx,
            chart._chartAxis._axisClipRect.top);
        dashArrayPath.lineTo(chart.crosshairBehavior._position.dx,
            chart._chartAxis._axisClipRect.bottom);
        chart.crosshairBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      }
    }
  }

  void _drawDashedLine(Paint paint, Canvas canvas, Path dashArrayPath) {
    bool even = false;
    for (int i = 1;
        i < chart.crosshairBehavior.lineDashArray.length;
        i = i + 2) {
      if (chart.crosshairBehavior.lineDashArray[i] == 0) {
        even = true;
      }
    }
    if (even == false) {
      paint.isAntiAlias = false;
      canvas.drawPath(
          _dashPath(
            dashArrayPath,
            dashArray: _CircularIntervalList<double>(
                chart.crosshairBehavior.lineDashArray),
          ),
          paint);
    } else {
      canvas.drawPath(dashArrayPath, paint);
    }
  }

  void _drawCrosshair(Canvas canvas) {
    const double paddingForRect = 10;
    RRect tooltipRect;
    dynamic value;
    Size labelSize;
    Rect labelRect;
    Rect validatedRect;
    ChartAxis axis;
    Color crosshairLineColor;
    final Paint fillPaint = Paint()
      ..color = chart._chartTheme.crosshairFillColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = false
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = chart._chartTheme.crosshairFillColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = false
      ..style = PaintingStyle.stroke;
    chart.crosshairBehavior.lineWidth == 0
        ? strokePaint.color = Colors.transparent
        : strokePaint.color = strokePaint.color;

    final Paint crosshairLinePaint = Paint();
    final Path backgroundPath = Path();
    if (chart.crosshairBehavior._position != null) {
      final Offset position = chart.crosshairBehavior._position;
      CrosshairRenderArgs crosshairEventArgs;

      for (int index = 0;
          index < chart._chartAxis._bottomAxesCount.length;
          index++) {
        axis = chart._chartAxis._bottomAxesCount[index].axis;
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs();
          crosshairEventArgs.axis = axis;
          crosshairEventArgs.orientation = axis._orientation;
          crosshairEventArgs.axisName = axis._name;
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chart._chartTheme.crosshairLineColor;
          chart.onCrosshairPositionChanging(crosshairEventArgs);
          crosshairLineColor = crosshairEventArgs.lineColor;
        }
      }

      for (int index = 0;
          index < chart._chartAxis._topAxesCount.length;
          index++) {
        axis = chart._chartAxis._topAxesCount[index].axis;
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs();
          crosshairEventArgs.axis = axis;
          crosshairEventArgs.orientation = axis._orientation;
          crosshairEventArgs.axisName = axis._name;
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chart._chartTheme.crosshairLineColor;
          chart.onCrosshairPositionChanging(crosshairEventArgs);
          crosshairLineColor = crosshairEventArgs.lineColor;
        }
      }

      for (int index = 0;
          index < chart._chartAxis._leftAxesCount.length;
          index++) {
        axis = chart._chartAxis._leftAxesCount[index].axis;
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs();
          crosshairEventArgs.axis = axis;
          crosshairEventArgs.orientation = axis._orientation;
          crosshairEventArgs.axisName = axis._name;
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chart._chartTheme.crosshairLineColor;
          chart.onCrosshairPositionChanging(crosshairEventArgs);
          crosshairLineColor = crosshairEventArgs.lineColor;
        }
      }

      for (int index = 0;
          index < chart._chartAxis._rightAxesCount.length;
          index++) {
        axis = chart._chartAxis._rightAxesCount[index].axis;
        if (chart.onCrosshairPositionChanging != null) {
          crosshairEventArgs = CrosshairRenderArgs();
          crosshairEventArgs.axis = axis;
          crosshairEventArgs.orientation = axis._orientation;
          crosshairEventArgs.axisName = axis._name;
          crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
              chart._chartTheme.crosshairLineColor;
          chart.onCrosshairPositionChanging(crosshairEventArgs);
          crosshairLineColor = crosshairEventArgs.lineColor;
        }
      }

      crosshairLinePaint.color = crosshairLineColor ??
          chart.crosshairBehavior.lineColor ??
          chart._chartTheme.crosshairLineColor;
      crosshairLinePaint.strokeWidth = chart.crosshairBehavior.lineWidth;
      crosshairLinePaint.style = PaintingStyle.stroke;
      chart.crosshairBehavior._drawLine(canvas,
          chart.crosshairBehavior._linePainter(crosshairLinePaint), null);

      for (int index = 0;
          index < chart._chartAxis._bottomAxesCount.length;
          index++) {
        axis = chart._chartAxis._bottomAxesCount[index].axis;
        if (axis.interactiveTooltip.enable && axis._visibleLabels.isNotEmpty) {
          fillPaint.color = axis.interactiveTooltip.color != null
              ? axis.interactiveTooltip?.color
              : chart._chartTheme.crosshairFillColor;
          strokePaint.color = axis.interactiveTooltip.borderColor != null
              ? axis.interactiveTooltip?.borderColor
              : chart._chartTheme.crosshairFillColor;
          strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
          value = _pointToXVal(
              chart,
              axis,
              axis._bounds,
              position.dx -
                  (chart._chartAxis._axisClipRect.left + axis.plotOffset),
              position.dy -
                  (chart._chartAxis._axisClipRect.top + axis.plotOffset));
          value = _getInteractiveTooltipLabel(value, axis);
          if (chart.onCrosshairPositionChanging != null) {
            crosshairEventArgs = CrosshairRenderArgs();
            crosshairEventArgs.axis = axis;
            crosshairEventArgs.orientation = axis._orientation;
            crosshairEventArgs.axisName = axis._name;
            crosshairEventArgs.text = value.toString();
            crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
                chart._chartTheme.crosshairLineColor;
            crosshairEventArgs.value = value;
            chart.onCrosshairPositionChanging(crosshairEventArgs);
            value = crosshairEventArgs.text;
            crosshairLineColor = crosshairEventArgs.lineColor;
          }
          labelSize =
              _measureText(value.toString(), axis.interactiveTooltip.textStyle);
          labelRect = Rect.fromLTWH(
              position.dx - (labelSize.width / 2 + paddingForRect / 2),
              axis._bounds.top + axis.interactiveTooltip.arrowLength,
              labelSize.width + paddingForRect,
              labelSize.height + paddingForRect);
          labelRect =
              _validateRectBounds(labelRect, chart._chartState.containerRect);
          validatedRect = _validateRectXPosition(labelRect, chart);
          backgroundPath.reset();
          tooltipRect = _getRoundedCornerRect(
              validatedRect, axis.interactiveTooltip.borderRadius);
          backgroundPath.addRRect(tooltipRect);

          /// Arrow head for tooltip
          _drawTooltipArrowhead(
              canvas,
              backgroundPath,
              fillPaint,
              strokePaint,
              position.dx,
              tooltipRect.top - axis.interactiveTooltip.arrowLength,
              (tooltipRect.right - tooltipRect.width / 2) +
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.top,
              (tooltipRect.left + tooltipRect.width / 2) -
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.top,
              position.dx,
              tooltipRect.top - axis.interactiveTooltip.arrowLength);
          _drawText(
              canvas,
              value.toString(),
              Offset(
                  (tooltipRect.left + tooltipRect.width / 2) -
                      labelSize.width / 2,
                  (tooltipRect.top + tooltipRect.height / 2) -
                      labelSize.height / 2),
              ChartTextStyle(
                  color: axis.interactiveTooltip.textStyle.color ??
                      chart._chartTheme.tooltipLabelColor,
                  fontSize: axis.interactiveTooltip.textStyle.fontSize,
                  fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                  fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                  fontStyle: axis.interactiveTooltip.textStyle.fontStyle),
              0);
        }
      }
      for (int index = 0;
          index < chart._chartAxis._topAxesCount.length;
          index++) {
        axis = chart._chartAxis._topAxesCount[index].axis;
        if (axis.interactiveTooltip.enable && axis._visibleLabels.isNotEmpty) {
          fillPaint.color = axis.interactiveTooltip.color != null
              ? axis.interactiveTooltip?.color
              : chart._chartTheme.crosshairFillColor;
          strokePaint.color = axis.interactiveTooltip.borderColor != null
              ? axis.interactiveTooltip?.borderColor
              : chart._chartTheme.crosshairFillColor;
          strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
          value = _pointToXVal(
              chart,
              axis,
              axis._bounds,
              position.dx -
                  (chart._chartAxis._axisClipRect.left + axis.plotOffset),
              position.dy -
                  (chart._chartAxis._axisClipRect.top + axis.plotOffset));
          value = _getInteractiveTooltipLabel(value, axis);
          if (chart.onCrosshairPositionChanging != null) {
            crosshairEventArgs = CrosshairRenderArgs();
            crosshairEventArgs.axis = axis;
            crosshairEventArgs.orientation = axis._orientation;
            crosshairEventArgs.axisName = axis._name;
            crosshairEventArgs.text = value.toString();
            crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
                chart._chartTheme.crosshairLineColor;
            crosshairEventArgs.value = value;
            chart.onCrosshairPositionChanging(crosshairEventArgs);
            value = crosshairEventArgs.text;
            crosshairLineColor = crosshairEventArgs.lineColor;
          }
          labelSize =
              _measureText(value.toString(), axis.interactiveTooltip.textStyle);
          labelRect = Rect.fromLTWH(
              position.dx - (labelSize.width / 2 + paddingForRect / 2),
              axis._bounds.top -
                  (labelSize.height + paddingForRect) -
                  axis.interactiveTooltip.arrowLength,
              labelSize.width + paddingForRect,
              labelSize.height + paddingForRect);
          labelRect =
              _validateRectBounds(labelRect, chart._chartState.containerRect);
          validatedRect = _validateRectXPosition(labelRect, chart);
          backgroundPath.reset();
          tooltipRect = _getRoundedCornerRect(
              validatedRect, axis.interactiveTooltip.borderRadius);
          backgroundPath.addRRect(tooltipRect);

          /// Arrow head for tooltip
          _drawTooltipArrowhead(
              canvas,
              backgroundPath,
              fillPaint,
              strokePaint,
              position.dx,
              tooltipRect.bottom + axis.interactiveTooltip.arrowLength,
              (tooltipRect.right - tooltipRect.width / 2) +
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.bottom,
              (tooltipRect.left + tooltipRect.width / 2) -
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.bottom,
              position.dx,
              tooltipRect.bottom + axis.interactiveTooltip.arrowLength);
          _drawText(
              canvas,
              value.toString(),
              Offset(
                  (tooltipRect.left + tooltipRect.width / 2) -
                      labelSize.width / 2,
                  (tooltipRect.top + tooltipRect.height / 2) -
                      labelSize.height / 2),
              ChartTextStyle(
                  color: axis.interactiveTooltip.textStyle.color ??
                      chart._chartTheme.tooltipLabelColor,
                  fontSize: axis.interactiveTooltip.textStyle.fontSize,
                  fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                  fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                  fontStyle: axis.interactiveTooltip.textStyle.fontStyle),
              0);
        }
      }

      for (int index = 0;
          index < chart._chartAxis._leftAxesCount.length;
          index++) {
        axis = chart._chartAxis._leftAxesCount[index].axis;
        if (axis.interactiveTooltip.enable && axis._visibleLabels.isNotEmpty) {
          fillPaint.color = axis.interactiveTooltip.color != null
              ? axis.interactiveTooltip.color
              : chart._chartTheme.crosshairFillColor;
          strokePaint.color = axis.interactiveTooltip.borderColor != null
              ? axis.interactiveTooltip?.borderColor
              : chart._chartTheme.crosshairFillColor;
          strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
          value = _pointToYVal(
              chart,
              axis,
              axis._bounds,
              position.dx -
                  (chart._chartAxis._axisClipRect.left + axis.plotOffset),
              position.dy -
                  (chart._chartAxis._axisClipRect.top + axis.plotOffset));
          value = _getInteractiveTooltipLabel(value, axis);
          if (chart.onCrosshairPositionChanging != null) {
            crosshairEventArgs = CrosshairRenderArgs();
            crosshairEventArgs.axis = axis;
            crosshairEventArgs.orientation = axis._orientation;
            crosshairEventArgs.axisName = axis._name;
            crosshairEventArgs.text = value.toString();
            crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
                chart._chartTheme.crosshairLineColor;
            crosshairEventArgs.value = value;
            chart.onCrosshairPositionChanging(crosshairEventArgs);
            value = crosshairEventArgs.text;
            crosshairLineColor = crosshairEventArgs.lineColor;
          }
          labelSize =
              _measureText(value.toString(), axis.interactiveTooltip.textStyle);
          labelRect = Rect.fromLTWH(
              axis._bounds.left -
                  (labelSize.width + paddingForRect) -
                  axis.interactiveTooltip.arrowLength,
              position.dy - (labelSize.height + paddingForRect) / 2,
              labelSize.width + paddingForRect,
              labelSize.height + paddingForRect);
          labelRect =
              _validateRectBounds(labelRect, chart._chartState.containerRect);
          validatedRect = _validateRectYPosition(labelRect, chart);
          backgroundPath.reset();
          tooltipRect = _getRoundedCornerRect(
              validatedRect, axis.interactiveTooltip.borderRadius);

          /// Arrow head for tooltip
          backgroundPath.addRRect(tooltipRect);
          _drawTooltipArrowhead(
              canvas,
              backgroundPath,
              fillPaint,
              strokePaint,
              tooltipRect.right,
              tooltipRect.top +
                  tooltipRect.height / 2 -
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.right,
              tooltipRect.bottom -
                  tooltipRect.height / 2 +
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.right + axis.interactiveTooltip.arrowLength,
              position.dy,
              tooltipRect.right + axis.interactiveTooltip.arrowLength,
              position.dy);
          _drawText(
              canvas,
              value.toString(),
              Offset(
                  (tooltipRect.left + tooltipRect.width / 2) -
                      labelSize.width / 2,
                  (tooltipRect.top + tooltipRect.height / 2) -
                      labelSize.height / 2),
              ChartTextStyle(
                  color: axis.interactiveTooltip.textStyle.color ??
                      chart._chartTheme.tooltipLabelColor,
                  fontSize: axis.interactiveTooltip.textStyle.fontSize,
                  fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                  fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                  fontStyle: axis.interactiveTooltip.textStyle.fontStyle),
              0);
        }
      }

      for (int index = 0;
          index < chart._chartAxis._rightAxesCount.length;
          index++) {
        axis = chart._chartAxis._rightAxesCount[index].axis;
        if (axis.interactiveTooltip.enable && axis._visibleLabels.isNotEmpty) {
          fillPaint.color = axis.interactiveTooltip.color != null
              ? axis.interactiveTooltip.color
              : chart._chartTheme.crosshairFillColor;
          strokePaint.color = axis.interactiveTooltip.borderColor != null
              ? axis.interactiveTooltip?.borderColor
              : chart._chartTheme.crosshairFillColor;
          strokePaint.strokeWidth = axis.interactiveTooltip.borderWidth;
          value = _pointToYVal(
              chart,
              axis,
              axis._bounds,
              position.dx -
                  (chart._chartAxis._axisClipRect.left + axis.plotOffset),
              position.dy -
                  (chart._chartAxis._axisClipRect.top + axis.plotOffset));
          value = _getInteractiveTooltipLabel(value, axis);
          if (chart.onCrosshairPositionChanging != null) {
            crosshairEventArgs = CrosshairRenderArgs();
            crosshairEventArgs.axis = axis;
            crosshairEventArgs.orientation = axis._orientation;
            crosshairEventArgs.axisName = axis._name;
            crosshairEventArgs.text = value.toString();
            crosshairEventArgs.lineColor = chart.crosshairBehavior.lineColor ??
                chart._chartTheme.crosshairLineColor;
            crosshairEventArgs.value = value;
            chart.onCrosshairPositionChanging(crosshairEventArgs);
            value = crosshairEventArgs.text;
            crosshairLineColor = crosshairEventArgs.lineColor;
          }
          labelSize =
              _measureText(value.toString(), axis.interactiveTooltip.textStyle);
          labelRect = Rect.fromLTWH(
              axis._bounds.left + axis.interactiveTooltip.arrowLength,
              position.dy - (labelSize.height / 2 + paddingForRect / 2),
              labelSize.width + paddingForRect,
              labelSize.height + paddingForRect);
          labelRect =
              _validateRectBounds(labelRect, chart._chartState.containerRect);
          validatedRect = _validateRectYPosition(labelRect, chart);
          backgroundPath.reset();
          tooltipRect = _getRoundedCornerRect(
              validatedRect, axis.interactiveTooltip.borderRadius);
          backgroundPath.addRRect(tooltipRect);

          /// Arrow head for tooltip
          _drawTooltipArrowhead(
              canvas,
              backgroundPath,
              fillPaint,
              strokePaint,
              tooltipRect.left,
              tooltipRect.top +
                  tooltipRect.height / 2 -
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.left,
              tooltipRect.bottom -
                  tooltipRect.height / 2 +
                  axis.interactiveTooltip.arrowWidth,
              tooltipRect.left - axis.interactiveTooltip.arrowLength,
              position.dy,
              tooltipRect.left - axis.interactiveTooltip.arrowLength,
              position.dy);
          _drawText(
              canvas,
              value.toString(),
              Offset(
                  (tooltipRect.left + tooltipRect.width / 2) -
                      labelSize.width / 2,
                  (tooltipRect.top + tooltipRect.height / 2) -
                      labelSize.height / 2),
              ChartTextStyle(
                  color: axis.interactiveTooltip.textStyle.color ??
                      chart._chartTheme.tooltipLabelColor,
                  fontSize: axis.interactiveTooltip.textStyle.fontSize,
                  fontWeight: axis.interactiveTooltip.textStyle.fontWeight,
                  fontFamily: axis.interactiveTooltip.textStyle.fontFamily,
                  fontStyle: axis.interactiveTooltip.textStyle.fontStyle),
              0);
        }
      }
    }
  }
}
