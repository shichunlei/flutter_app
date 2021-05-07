part of flutter_charts;

abstract class _CustomizeAxisElements {
  Color getAxisLineColor(ChartAxis axis);

  Color getAxisMajorTickColor(ChartAxis axis, int majorTickIndex);

  Color getAxisMinorTickColor(
      ChartAxis axis, int majorTickIndex, int minorTickIndex);

  Color getAxisMajorGridColor(ChartAxis axis, int majorGridIndex);

  Color getAxisMinorGridColor(
      ChartAxis axis, int majorGridIndex, int minorGridIndex);

  double getAxisLineWidth(ChartAxis axis);

  double getAxisMajorTickWidth(ChartAxis axis, int majorTickIndex);

  double getAxisMinorTickWidth(
      ChartAxis axis, int majorTickIndex, int minorTickIndex);

  double getAxisMajorGridWidth(ChartAxis axis, int majorGridIndex);

  double getAxisMinorGridWidth(
      ChartAxis axis, int majorGridIndex, int minorGridIndex);

  String getAxisLabel(ChartAxis axis, String text, int labelIndex);

  ChartTextStyle getAxisLabelStyle(ChartAxis axis, String text, int labelIndex);

  int getAxisLabelAngle(ChartAxis axis, String text, int labelIndex);

  void drawHorizontalAxesLine(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawVerticalAxesLine(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawHorizontalAxesTickLines(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawVerticalAxesTickLines(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawHorizontalAxesMajorGridLines(Canvas canvas, Offset point,
      ChartAxis axis, MajorGridLines grids, int index, SfCartesianChart chart);

  void drawVerticalAxesMajorGridLines(Canvas canvas, Offset point,
      ChartAxis axis, MajorGridLines grids, int index, SfCartesianChart chart);

  void drawHorizontalAxesMinorLines(
      Canvas canvas,
      ChartAxis axis,
      num tempInterval,
      Rect rect,
      num nextValue,
      int index,
      SfCartesianChart chart);

  void drawVerticalAxesMinorTickLines(Canvas canvas, ChartAxis axis,
      num tempInterval, Rect rect, int index, SfCartesianChart chart);

  void drawHorizontalAxesLabels(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawVerticalAxesLabels(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawHorizontalAxesTitle(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);

  void drawVerticalAxesTitle(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart);
}

class _ChartAxisRenderer with _CustomizeAxisElements {
  _ChartAxisRenderer();

  @override
  Color getAxisLineColor(ChartAxis axis) => axis.axisLine.color;
  @override
  double getAxisLineWidth(ChartAxis axis) => axis.axisLine.width;

  @override
  Color getAxisMajorTickColor(ChartAxis axis, int majorTickIndex) =>
      axis.majorTickLines.color;

  @override
  double getAxisMajorTickWidth(ChartAxis axis, int majorTickIndex) =>
      axis.majorTickLines.width;

  @override
  Color getAxisMinorTickColor(
          ChartAxis axis, int majorTickIndex, int minorTickIndex) =>
      axis.minorTickLines.color;

  @override
  double getAxisMinorTickWidth(
          ChartAxis axis, int majorTickIndex, int minorTickIndex) =>
      axis.minorTickLines.width;

  @override
  Color getAxisMajorGridColor(ChartAxis axis, int majorGridIndex) =>
      axis.majorGridLines.color;

  @override
  double getAxisMajorGridWidth(ChartAxis axis, int majorGridIndex) =>
      axis.majorGridLines.width;

  @override
  Color getAxisMinorGridColor(
          ChartAxis axis, int majorGridIndex, int minorGridIndex) =>
      axis.minorGridLines.color;
  @override
  double getAxisMinorGridWidth(
          ChartAxis axis, int majorGridIndex, int minorGridIndex) =>
      axis.minorGridLines.width;

  @override
  String getAxisLabel(ChartAxis axis, String text, int labelIndex) => text;

  @override
  ChartTextStyle getAxisLabelStyle(
          ChartAxis axis, String text, int labelIndex) =>
      axis.labelStyle;

  @override
  int getAxisLabelAngle(ChartAxis axis, String text, int labelIndex) =>
      (axis.labelIntersectAction == AxisLabelIntersectAction.rotate45 &&
              axis._isCollide)
          ? 45
          : (axis.labelIntersectAction == AxisLabelIntersectAction.rotate90 &&
                  axis._isCollide)
              ? 90
              : axis._labelRotation;

  @override
  void drawHorizontalAxesLine(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart) {
    final Rect rect = Rect.fromLTWH(
        axis._bounds.left - axis.plotOffset,
        axis._bounds.top,
        axis._bounds.width + 2 * axis.plotOffset,
        axis._bounds.height);

    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axis._axisRenderer.getAxisLineWidth(axis),
        axis._axisRenderer.getAxisLineColor(axis) ??
            chart._chartTheme.axisLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(canvas, paintStyle, Offset(rect.left, rect.top),
        Offset(rect.left + rect.width, rect.top), axis.axisLine.dashArray);
  }

  @override
  void drawVerticalAxesLine(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart) {
    final Rect rect = Rect.fromLTWH(
        axis._bounds.left,
        axis._bounds.top - axis.plotOffset,
        axis._bounds.width,
        axis._bounds.height + 2 * axis.plotOffset);
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axis._axisRenderer.getAxisLineWidth(axis),
        axis._axisRenderer.getAxisLineColor(axis) ??
            chart._chartTheme.axisLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(canvas, paintStyle, Offset(rect.left, rect.top),
        Offset(rect.left, rect.top + rect.height), axis.axisLine.dashArray);
  }

  @override
  void drawHorizontalAxesTickLines(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart,
      [String renderType]) {
    final Rect axisBounds = axis._bounds;
    final List<AxisLabel> visibleLabels = axis._visibleLabels;
    num tempInterval, pointX, pointY, length = visibleLabels.length;
    if (length > 0) {
      final MajorTickLines ticks = axis.majorTickLines;
      const num padding = 1;
      final bool isBetweenTicks = axis is CategoryAxis &&
          axis.labelPlacement == LabelPlacement.betweenTicks;
      final num tickBetweenLabel = isBetweenTicks ? 0.5 : 0;
      length += isBetweenTicks ? 1 : 0;
      for (int i = 0; i < length; i++) {
        tempInterval = isBetweenTicks
            ? i < length - 1
                ? visibleLabels[i].value - tickBetweenLabel
                : (visibleLabels[i - 1].value + axis._visibleRange.interval) -
                    tickBetweenLabel
            : visibleLabels[i].value;
        pointX = ((_valueToCoefficient(tempInterval, axis) * axisBounds.width) +
                axisBounds.left)
            .roundToDouble();
        pointY = axisBounds.top - padding + axis.axisLine.width / 2;
        if (axis.majorGridLines.width > 0 &&
            renderType == 'outside' &&
            (axis.plotOffset > 0 ||
                (i != 0 && i != length - 1) ||
                (axisBounds.left <= pointX && axisBounds.right >= pointX))) {
          axis._axisRenderer.drawHorizontalAxesMajorGridLines(canvas,
              Offset(pointX, pointY), axis, axis.majorGridLines, i, chart);
        }
        if (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0) {
          num nextValue = isBetweenTicks
              ? (tempInterval + axis._visibleRange.interval)
              : i == length - 1
                  ? axis._visibleRange.maximum
                  : visibleLabels[i + 1]?.value;
          if (nextValue != null) {
            nextValue =
                ((_valueToCoefficient(nextValue, axis) * axisBounds.width) +
                        axisBounds.left)
                    .roundToDouble();
            axis._axisRenderer.drawHorizontalAxesMinorLines(canvas, axis,
                pointX, axisBounds, nextValue, i, chart, renderType);
          }
        }

        if (axis.majorTickLines.width > 0 &&
            (axisBounds.left <= pointX && axisBounds.right >= pointX) &&
            renderType == axis.tickPosition.toString().split('.')[1]) {
          _drawDashedPath(
              canvas,
              _CustomPaintStyle(
                  axis._axisRenderer.getAxisMajorTickWidth(axis, i),
                  axis._axisRenderer.getAxisMajorTickColor(axis, i) ??
                      chart._chartTheme.majorTickLineColor,
                  PaintingStyle.stroke),
              Offset(pointX, pointY),
              Offset(
                  pointX,
                  !axis.opposedPosition
                      ? (axis._isInsideTickPosition
                          ? pointY - ticks.size
                          : pointY + ticks.size)
                      : (axis._isInsideTickPosition
                          ? pointY + ticks.size
                          : pointY - ticks.size)));
        }
      }
    }
  }

  @override
  void drawHorizontalAxesMajorGridLines(Canvas canvas, Offset point,
      ChartAxis axis, MajorGridLines grids, int index, SfCartesianChart chart) {
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axis._axisRenderer.getAxisMajorGridWidth(axis, index),
        axis._axisRenderer.getAxisMajorGridColor(axis, index) ??
            chart._chartTheme.majorGridLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(
        canvas,
        paintStyle,
        Offset(point.dx, chart._chartAxis._axisClipRect.top),
        Offset(
            point.dx,
            chart._chartAxis._axisClipRect.top +
                chart._chartAxis._axisClipRect.height),
        grids.dashArray);
  }

  @override
  void drawHorizontalAxesMinorLines(
      Canvas canvas,
      ChartAxis axis,
      num tempInterval,
      Rect rect,
      num nextValue,
      int index,
      SfCartesianChart chart,
      [String renderType]) {
    num position = tempInterval;
    final MinorTickLines ticks = axis.minorTickLines;
    final num interval =
        (tempInterval - nextValue).abs() / (axis.minorTicksPerInterval + 1);
    for (dynamic i = 0; i < axis.minorTicksPerInterval; i++) {
      position += interval;
      final num pointY = rect.top;
      if (axis.minorGridLines.width > 0 && renderType == 'outside') {
        _drawDashedPath(
            canvas,
            _CustomPaintStyle(
                axis._axisRenderer.getAxisMinorGridWidth(axis, index, i),
                axis._axisRenderer.getAxisMinorGridColor(axis, index, i) ??
                    chart._chartTheme.minorGridLineColor,
                PaintingStyle.stroke),
            Offset(position, chart._chartAxis._axisClipRect.top),
            Offset(
                position,
                chart._chartAxis._axisClipRect.top +
                    chart._chartAxis._axisClipRect.height));
      }

      if (axis.minorTickLines.width > 0 &&
          renderType == axis.tickPosition.toString().split('.')[1]) {
        _drawDashedPath(
            canvas,
            _CustomPaintStyle(
                axis._axisRenderer.getAxisMinorTickWidth(axis, index, i),
                axis._axisRenderer.getAxisMinorTickColor(axis, index, i) ??
                    chart._chartTheme.minorTickLineColor,
                PaintingStyle.stroke),
            Offset(position, pointY),
            Offset(
                position,
                !axis.opposedPosition
                    ? (axis._isInsideTickPosition
                        ? pointY - ticks.size
                        : pointY + ticks.size)
                    : (axis._isInsideTickPosition
                        ? pointY + ticks.size
                        : pointY - ticks.size)));
      }
    }
  }

  @override
  void drawVerticalAxesTickLines(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart,
      [String renderType]) {
    final Rect axisBounds = axis._bounds;
    final List<AxisLabel> visibleLabels = axis._visibleLabels;
    num tempInterval, pointX, pointY, length = visibleLabels.length;
    const num padding = 1;
    final bool isBetweenTicks = axis is CategoryAxis &&
        axis.labelPlacement == LabelPlacement.betweenTicks;
    final num tickBetweenLabel = isBetweenTicks ? 0.5 : 0;
    length += isBetweenTicks ? 1 : 0;
    for (int i = 0; i < length; i++) {
      tempInterval = isBetweenTicks
          ? i < length - 1
              ? visibleLabels[i].value - tickBetweenLabel
              : (visibleLabels[i - 1].value + axis._visibleRange.interval) -
                  tickBetweenLabel
          : visibleLabels[i].value;
      pointY = (_valueToCoefficient(tempInterval, axis) * axisBounds.height) +
          axisBounds.top;
      pointY = (axisBounds.top + axisBounds.height) -
          (pointY - axisBounds.top).abs();
      pointX = axisBounds.left + padding - axis.axisLine.width / 2;
      if (axis.majorGridLines.width > 0 &&
          renderType == 'outside' &&
          (axis.plotOffset > 0 ||
              ((i == 0 || i == length - 1) && chart.plotAreaBorderWidth == 0) ||
              (((i == 0 && !axis.opposedPosition) ||
                      (i == length - 1 && axis.opposedPosition)) &&
                  axis.axisLine.width == 0) ||
              (axisBounds.top < pointY - axis.majorGridLines.width &&
                  axisBounds.bottom > pointY + axis.majorGridLines.width))) {
        axis._axisRenderer.drawVerticalAxesMajorGridLines(canvas,
            Offset(pointX, pointY), axis, axis.majorGridLines, i, chart);
      }
      if (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0) {
        axis._axisRenderer.drawVerticalAxesMinorTickLines(
            canvas, axis, tempInterval, axisBounds, i, chart, renderType);
      }
      if (axis.majorTickLines.width > 0 &&
          renderType == axis.tickPosition.toString().split('.')[1]) {
        _drawDashedPath(
            canvas,
            _CustomPaintStyle(
                axis._axisRenderer.getAxisMajorTickWidth(axis, i),
                axis._axisRenderer.getAxisMajorTickColor(axis, i) ??
                    chart._chartTheme.majorTickLineColor,
                PaintingStyle.stroke),
            Offset(pointX, pointY),
            Offset(
                !axis.opposedPosition
                    ? (axis._isInsideTickPosition
                        ? pointX + axis.majorTickLines.size
                        : pointX - axis.majorTickLines.size)
                    : (axis._isInsideTickPosition
                        ? pointX - axis.majorTickLines.size
                        : pointX + axis.majorTickLines.size),
                pointY));
      }
    }
  }

  @override
  void drawVerticalAxesMajorGridLines(Canvas canvas, Offset point,
      ChartAxis axis, MajorGridLines grids, int index, SfCartesianChart chart) {
    final _CustomPaintStyle paintStyle = _CustomPaintStyle(
        axis._axisRenderer.getAxisMajorGridWidth(axis, index),
        axis._axisRenderer.getAxisMajorGridColor(axis, index) ??
            chart._chartTheme.majorGridLineColor,
        PaintingStyle.stroke);
    _drawDashedPath(
        canvas,
        paintStyle,
        Offset(chart._chartAxis._axisClipRect.left, point.dy),
        Offset(
            chart._chartAxis._axisClipRect.left +
                chart._chartAxis._axisClipRect.width,
            point.dy),
        grids.dashArray);
  }

  @override
  void drawVerticalAxesMinorTickLines(Canvas canvas, ChartAxis axis,
      num tempInterval, Rect rect, int index, SfCartesianChart chart,
      [String renderType]) {
    num value = tempInterval, position = 0;
    final _VisibleRange range = axis._visibleRange;
    final bool rendering = axis.minorTicksPerInterval > 0 &&
        (axis.minorGridLines.width > 0 || axis.minorTickLines.width > 0);
    if (rendering) {
      for (int i = 0; i < axis.minorTicksPerInterval; i++) {
        value += range.interval / (axis.minorTicksPerInterval + 1);
        if ((value < range.maximum) && (value > range.minimum)) {
          position = _valueToCoefficient(value, axis) * rect.height;
          position = (position + rect.top).floor().toDouble();
          if (axis.minorGridLines.width > 0 &&
              renderType == 'outside' &&
              rect.top <= position &&
              rect.bottom >= position) {
            _drawDashedPath(
                canvas,
                _CustomPaintStyle(
                    axis._axisRenderer.getAxisMinorGridWidth(axis, index, i),
                    axis._axisRenderer.getAxisMinorGridColor(axis, index, i) ??
                        chart._chartTheme.minorGridLineColor,
                    PaintingStyle.stroke),
                Offset(chart._chartAxis._axisClipRect.left, position),
                Offset(
                    chart._chartAxis._axisClipRect.left +
                        chart._chartAxis._axisClipRect.width,
                    position));
          }
          if (axis.minorTickLines.width > 0 &&
              renderType == axis.tickPosition.toString().split('.')[1]) {
            _drawDashedPath(
                canvas,
                _CustomPaintStyle(
                    axis._axisRenderer.getAxisMinorTickWidth(axis, index, i),
                    axis._axisRenderer.getAxisMinorTickColor(axis, index, i) ??
                        chart._chartTheme.minorTickLineColor,
                    PaintingStyle.stroke),
                Offset(rect.left, position),
                Offset(
                    !axis.opposedPosition
                        ? (axis._isInsideTickPosition
                            ? rect.left + axis.minorTickLines.size
                            : rect.left - axis.minorTickLines.size)
                        : (axis._isInsideTickPosition
                            ? rect.left - axis.minorTickLines.size
                            : rect.left + axis.minorTickLines.size),
                    position));
          }
        }
      }
    }
  }

  @override
  void drawHorizontalAxesLabels(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart,
      [String renderType]) {
    if (renderType == axis.labelPosition.toString().split('.')[1]) {
      final Rect axisBounds = axis._bounds;
      int angle;
      ChartTextStyle textStyle;
      final List<AxisLabel> visibleLabels = axis._visibleLabels;
      num tempInterval, pointX, pointY, previousEnd;
      const num innerPadding = 3;
      for (int i = 0; i < visibleLabels.length; i++) {
        final AxisLabel label = visibleLabels[i];
        final String labelText =
            axis._axisRenderer.getAxisLabel(axis, label.text, i);
        textStyle = label.labelStyle;
        textStyle = _getTextStyle(
            textStyle: textStyle,
            fontColor: textStyle.color ?? chart._chartTheme.axisLabelColor);
        tempInterval = label.value;
        angle = axis._axisRenderer.getAxisLabelAngle(axis, labelText, i);
        final Size textSize = _measureText(labelText, textStyle);
        final Size rotatedTextSize = _measureText(labelText, textStyle, angle);
        pointX = ((_valueToCoefficient(tempInterval, axis) * axisBounds.width) +
                axisBounds.left)
            .roundToDouble();
        if (axis.labelPosition == ChartDataLabelPosition.inside) {
          pointY = !axis.opposedPosition
              ? axisBounds.top -
                  innerPadding -
                  (label._index > 1
                      ? axis._maximumLabelSize.height / 2
                      : axis._maximumLabelSize.height) -
                  (axis._isInsideTickPosition ? axis.majorTickLines.size : 0)
              : axisBounds.top +
                  (axis._isInsideTickPosition ? axis.majorTickLines.size : 0) +
                  (label._index > 1 ? axis._maximumLabelSize.height / 2 : 0);
        } else {
          pointY = !axis.opposedPosition
              ? axis._labelOffset != null
                  ? axis._labelOffset
                  : (axisBounds.top +
                      ((axis._isInsideTickPosition
                              ? 0
                              : axis.majorTickLines.size) +
                          innerPadding) +
                      (label._index > 1
                          ? axis._maximumLabelSize.height / 2
                          : 0))
              : axis._labelOffset != null
                  ? axis._labelOffset - axis._maximumLabelSize.height
                  : (axisBounds.top -
                      (((axis._isInsideTickPosition
                                  ? 0
                                  : axis.majorTickLines.size) +
                              innerPadding) -
                          (label._index > 1
                              ? axis._maximumLabelSize.height / 2
                              : 0)) -
                      axis._maximumLabelSize.height);
        }
        if (axis.labelIntersectAction == AxisLabelIntersectAction.hide &&
            i != 0 &&
            (!axis.isInversed
                ? (pointX - (textSize.width / 2)) < previousEnd
                : (pointX + textSize.width / 2) > previousEnd)) {
          continue;
        }
        previousEnd = axis.isInversed
            ? pointX - (textSize.width / 2)
            : pointX + (textSize.width / 2);

        pointY -= angle == 0 ? textSize.height / 2 : 0;

        pointY += rotatedTextSize.height / 2;

        pointX -= angle == 0 ? textSize.width / 2 : 0;

        /// Edge-label placement for x-axis
        if (axis.edgeLabelPlacement == EdgeLabelPlacement.shift) {
          if (i == 0 &&
              ((pointX < axisBounds.left && !axis.isInversed) ||
                  (pointX + textSize.width > axisBounds.right &&
                      axis.isInversed))) {
            pointX = axis.isInversed
                ? axisBounds.left + axisBounds.width - textSize.width
                : axisBounds.left;
          }
          if (i == axis._visibleLabels.length - 1 &&
              ((((pointX + textSize.width) > axisBounds.right) &&
                      !axis.isInversed) ||
                  (pointX < axisBounds.left && axis.isInversed))) {
            pointX = axis.isInversed
                ? axisBounds.left
                : axisBounds.left + axisBounds.width - textSize.width;
          }
        } else if (axis.edgeLabelPlacement == EdgeLabelPlacement.hide) {
          if ((i == 0 &&
                  ((pointX < axisBounds.left && !axis.isInversed) ||
                      (pointX + textSize.width > axisBounds.right &&
                          axis.isInversed))) ||
              (i == axis._visibleLabels.length - 1) &&
                  (pointX + textSize.width) >
                      (axisBounds.left + axisBounds.width)) {
            continue;
          }
        }
        axis._visibleLabels[i]._labelRegion =
            Rect.fromLTWH(pointX, pointY, textSize.width, textSize.height);
        final Offset point = Offset(pointX, pointY);
        if (axisBounds.left - textSize.width <= pointX)
          _drawText(canvas, labelText, point, textStyle, angle);
        if (label._labelCollection != null &&
            label._labelCollection.isNotEmpty &&
            axis.labelIntersectAction == AxisLabelIntersectAction.wrap) {
          for (int j = 1; j < label._labelCollection.length; j++) {
            final String wrapTxt = label._labelCollection[j];
            _drawText(
                canvas,
                wrapTxt,
                Offset(
                    pointX,
                    pointY +
                        (j *
                            _measureText(wrapTxt, axis.labelStyle, angle)
                                .height)),
                textStyle,
                angle);
          }
        }
      }
    }
  }

  @override
  void drawVerticalAxesLabels(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart,
      [String renderType]) {
    if (axis.labelPosition.toString().split('.')[1] == renderType) {
      final Rect axisBounds = axis._bounds;
      final List<AxisLabel> visibleLabels = axis._visibleLabels;
      ChartTextStyle textStyle;
      num tempInterval, pointX, pointY, previousEnd;
      const num innerPadding = 5;
      for (dynamic i = 0; i < visibleLabels.length; i++) {
        final String labelText =
            axis._axisRenderer.getAxisLabel(axis, visibleLabels[i].text, i);
        final int angle =
            axis._axisRenderer.getAxisLabelAngle(axis, labelText, i);
        textStyle = visibleLabels[i].labelStyle;
        textStyle = _getTextStyle(
            textStyle: textStyle,
            fontColor: textStyle.color ?? chart._chartTheme.axisLabelColor);
        tempInterval = visibleLabels[i].value;
        final Size textSize = _measureText(labelText, textStyle, 0);
        pointY = (_valueToCoefficient(tempInterval, axis) * axisBounds.height) +
            axisBounds.top;
        pointY = ((axisBounds.top + axisBounds.height) -
                ((axisBounds.top - pointY).abs())) -
            textSize.height / 2;
        if (axis.labelPosition == ChartDataLabelPosition.inside) {
          pointX = (!axis.opposedPosition)
              ? (axisBounds.left +
                  innerPadding +
                  (axis._isInsideTickPosition ? axis.majorTickLines.size : 0))
              : (axisBounds.left -
                  axis._maximumLabelSize.width -
                  innerPadding -
                  (axis._isInsideTickPosition ? axis.majorTickLines.size : 0));
        } else {
          pointX = (!axis.opposedPosition)
              ? axis._labelOffset != null
                  ? axis._labelOffset - textSize.width
                  : (axisBounds.left -
                      (axis._isInsideTickPosition
                          ? 0
                          : axis.majorTickLines.size) -
                      textSize.width -
                      innerPadding)
              : (axis._labelOffset != null
                  ? axis._labelOffset
                  : (axisBounds.left +
                      (axis._isInsideTickPosition
                          ? 0
                          : axis.majorTickLines.size) +
                      innerPadding));
        }
        final _ChartLocation location = _getRotatedTextLocation(
            pointX, pointY, labelText, textStyle, angle, axis);

        pointX = location.x;
        pointY = location.y;
        if (axis.labelIntersectAction == AxisLabelIntersectAction.hide &&
            i != 0 &&
            (!axis.isInversed
                ? pointY + (textSize.height / 2) > previousEnd
                : pointY - (textSize.height / 2) < previousEnd)) {
          continue;
        }
        previousEnd = !axis.isInversed
            ? pointY - textSize.height / 2
            : pointY + textSize.height / 2;

        ///  Edge label placement for y-Axis
        if (axis.edgeLabelPlacement == EdgeLabelPlacement.shift) {
          if (i == 0) {
            pointY = axisBounds.top + axisBounds.height - textSize.height;
          }
          if (i == axis._visibleLabels.length - 1) {
            pointY = axisBounds.top;
          }
        } else if (axis.edgeLabelPlacement == EdgeLabelPlacement.hide) {
          if (i == 0 || i == axis._visibleLabels.length - 1) {
            continue;
          }
        }
        axis._visibleLabels[i]._labelRegion =
            Rect.fromLTWH(pointX, pointY, textSize.width, textSize.height);
        final Offset point = Offset(pointX, pointY);
        if (axisBounds.top - textSize.height <= pointY &&
            axisBounds.bottom + textSize.height >= pointY)
          _drawText(canvas, labelText, point, textStyle, axis._labelRotation);
      }
    }
  }

  @override
  void drawHorizontalAxesTitle(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart) {
    final Rect axisBounds = axis._bounds;
    Offset point;
    final String title = axis.title.text;
    const int labelRotation = 0, innerPadding = 8;
    ChartTextStyle style = axis.title.textStyle;
    style = _getTextStyle(
        textStyle: style,
        fontColor: style.color ?? chart._chartTheme.axisTitleColor);
    final Size textSize = _measureText(title, style);
    num top;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      top = !axis.opposedPosition
          ? axisBounds.top +
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) +
              innerPadding
          : axisBounds.top -
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) -
              innerPadding -
              textSize.height;
    } else {
      top = !axis.opposedPosition
          ? axisBounds.top +
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) +
              innerPadding +
              axis._maximumLabelSize.height
          : axisBounds.top -
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) -
              innerPadding -
              axis._maximumLabelSize.height -
              textSize.height;
    }
    axis.title.alignment == ChartAlignment.near
        ? point = Offset(chart._chartAxis._axisClipRect.left, top)
        : axis.title.alignment == ChartAlignment.far
            ? point = Offset(
                chart._chartAxis._axisClipRect.right - textSize.width, top)
            : point = Offset(
                axisBounds.left +
                    ((axisBounds.width / 2) - (textSize.width / 2)),
                top);
    if (axis._series.isNotEmpty || axis._name == 'primaryXAxis')
      _drawText(canvas, title, point, style, labelRotation);
  }

  @override
  void drawVerticalAxesTitle(
      Canvas canvas, ChartAxis axis, SfCartesianChart chart) {
    final Rect axisBounds = axis._bounds;
    Offset point;
    final String title = axis.title.text;
    final int labelRotation = axis.opposedPosition ? 90 : 270;
    const int innerPadding = 10;
    ChartTextStyle style = axis.title.textStyle;
    style = _getTextStyle(
        textStyle: style,
        fontColor: style.color ?? chart._chartTheme.axisTitleColor);
    final Size textSize = _measureText(title, style);
    num left;
    if (axis.labelPosition == ChartDataLabelPosition.inside) {
      left = (!axis.opposedPosition)
          ? axisBounds.left -
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) -
              innerPadding -
              textSize.height
          : axisBounds.left +
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) +
              innerPadding * 2;
    } else {
      left = (!axis.opposedPosition)
          ? (axisBounds.left -
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) -
              innerPadding -
              axis._maximumLabelSize.width -
              textSize.height / 2)
          : axisBounds.left +
              (axis._isInsideTickPosition ? 0 : axis.majorTickLines.size) +
              innerPadding +
              axis._maximumLabelSize.width +
              textSize.height / 2;
    }
    axis.title.alignment == ChartAlignment.near
        ? point = Offset(
            left, chart._chartAxis._axisClipRect.bottom - textSize.width / 2)
        : axis.title.alignment == ChartAlignment.far
            ? point = Offset(
                left, chart._chartAxis._axisClipRect.top + textSize.width / 2)
            : point = Offset(left, axisBounds.top + (axisBounds.height / 2));
    if (axis._series.isNotEmpty || axis._name == 'primaryYAxis')
      _drawText(canvas, title, point, style, labelRotation);
  }
}

class _CartesianAxesPainter extends CustomPainter {
  _CartesianAxesPainter(
      {this.chart,
      this.isRepaint,
      ValueNotifier<num> notifier,
      this.renderType})
      : super(repaint: notifier);
  SfCartesianChart chart;
  final bool isRepaint;
  final String renderType;
  bool _drawImage = false;

  @override
  void paint(Canvas canvas, Size size) {
    _onDraw(canvas);
  }

  void _onDraw(Canvas canvas) {
    if (renderType == 'outside') {
      _drawPlotAreaBorder(canvas);
      if (chart.plotAreaBackgroundImage != null) {
        chart._imageUrl =
            chart.plotAreaBackgroundImage.toString().split('\"')[1];
        _drawBackgroundImage(canvas);
      }
    }
    _drawAxes(canvas);
  }

  void _drawPlotAreaBorder(Canvas canvas) {
    final Rect axisClipRect = chart._chartAxis._axisClipRect;
    final Paint paint = Paint();
    paint.color = chart.plotAreaBorderColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = chart.plotAreaBorderWidth;
    chart.plotAreaBorderWidth == 0
        ? paint.color = Colors.transparent
        : paint.color = paint.color;
    canvas.drawRect(axisClipRect, paint);

    canvas.drawRect(
        axisClipRect,
        Paint()
          ..color = chart.plotAreaBackgroundColor ??
              chart._chartTheme.plotAreaBackgroundColor
          ..style = PaintingStyle.fill);
  }

  void _drawBackgroundImage(Canvas canvas) {
    final Rect axisClipRect = chart._chartAxis._axisClipRect;
    Future<dart_ui.Image> _load(List<int> img) async {
      final Completer<dart_ui.Image> completer = Completer<dart_ui.Image>();
      dart_ui.decodeImageFromList(img, (dart_ui.Image img) {
        return completer.complete(img);
      });
      return completer.future;
    }

    // ignore: prefer_void_to_null
    Future<Null> _init(String image) async {
      final ByteData data = await rootBundle.load(image);
      chart._backgroundImage = await _load(Uint8List.view(data.buffer));
    }

    // ignore: avoid_void_async
    void _loadImage() async {
      await _init(chart._imageUrl);
      if (!_drawImage) {
        chart._chartState.axisRepaintNotifier.value++;
      }
      _drawImage = true;
    }

    _loadImage();
    if (chart._backgroundImage != null) {
      canvas.drawImageNine(chart._backgroundImage, axisClipRect, axisClipRect,
          Paint()..style = PaintingStyle.fill);
    }
  }

  void _drawHorizontalAxes(Canvas canvas, ChartAxis axis) {
    if (axis.isVisible) {
      if (axis.axisLine.width > 0 && renderType == 'outside') {
        axis._axisRenderer.drawHorizontalAxesLine(canvas, axis, chart);
      }
      if (axis.majorTickLines.width > 0 || axis.majorGridLines.width > 0) {
        axis._axisRenderer
            .drawHorizontalAxesTickLines(canvas, axis, chart, renderType);
      }
      axis._axisRenderer
          .drawHorizontalAxesLabels(canvas, axis, chart, renderType);
      if (renderType == 'outside') {
        axis._axisRenderer.drawHorizontalAxesTitle(canvas, axis, chart);
      }
    }
  }

  void _drawVerticalAxes(Canvas canvas, ChartAxis axis) {
    if (axis.isVisible) {
      if (axis.axisLine.width > 0 && renderType == 'outside') {
        axis._axisRenderer.drawVerticalAxesLine(canvas, axis, chart);
      }
      if (axis._visibleLabels.isNotEmpty &&
          (axis.majorTickLines.width > 0 || axis.majorGridLines.width > 0)) {
        axis._axisRenderer
            .drawVerticalAxesTickLines(canvas, axis, chart, renderType);
      }
      axis._axisRenderer
          .drawVerticalAxesLabels(canvas, axis, chart, renderType);
      if (renderType == 'outside') {
        axis._axisRenderer.drawVerticalAxesTitle(canvas, axis, chart);
      }
    }
  }

  void _drawAxes(Canvas canvas) {
    for (int axisIndex = 0;
        axisIndex < chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final ChartAxis axis = chart._chartAxis._axisCollections[axisIndex];
      axis._isInsideTickPosition =
          (axis.tickPosition == TickPosition.inside) ? true : false;
      axis._orientation == AxisOrientation.horizontal
          ? _drawHorizontalAxes(canvas, axis)
          : _drawVerticalAxes(canvas, axis);
    }
  }

  @override
  bool shouldRepaint(_CartesianAxesPainter oldDelegate) => isRepaint;
}
