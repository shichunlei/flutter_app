part of flutter_charts;

class _TrackballPainter extends CustomPainter {
  _TrackballPainter({this.chart, this.valueNotifier})
      : super(repaint: valueNotifier);
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
  double borderRadius;
  Path backgroundPath = Path();
  bool canResetPath = false;
  bool isLeft = false;
  bool isRight = false;
  bool enable;
  double padding = 0;
  double groupAllPadding = 10;
  List<String> stringValue = <String>[];
  Rect boundaryRect = const Rect.fromLTWH(0, 0, 0, 0);
  double leftPadding = 0;
  double topPadding = 0;
  bool isHorizontalOrientation = false;
  bool isRectSeries = false;
  ChartTextStyle labelStyle;
  List<_ChartPointInfo> chartPointInfo = <_ChartPointInfo>[];

  @override
  void paint(Canvas canvas, Size size) =>
      chart.trackballBehavior.onPaint(canvas);

  Paint _getLinePainter(Paint trackballLinePaint) => trackballLinePaint;

  void _drawTrackball(Canvas canvas) {
    borderRadius = chart.trackballBehavior.tooltipSettings.borderRadius;
    pointerLength = chart.trackballBehavior.tooltipSettings.arrowLength;
    pointerWidth = chart.trackballBehavior.tooltipSettings.arrowWidth;
    isLeft = false;
    isRight = false;
    double height = 0;
    double width = 0;
    boundaryRect = chart._chartAxis._axisClipRect;
    totalWidth = boundaryRect.left + boundaryRect.width;
    labelStyle = ChartTextStyle(
        color: chart.trackballBehavior.tooltipSettings.textStyle.color ??
            chart._chartTheme.crosshairLabelColor,
        fontSize: chart.trackballBehavior.tooltipSettings.textStyle.fontSize,
        fontFamily:
            chart.trackballBehavior.tooltipSettings.textStyle.fontFamily,
        fontStyle: chart.trackballBehavior.tooltipSettings.textStyle.fontStyle,
        fontWeight:
            chart.trackballBehavior.tooltipSettings.textStyle.fontWeight);

    for (int index = 0; index < chartPointInfo.length; index++) {
      if (((chartPointInfo[index].series._seriesType == 'column' ||
                  chartPointInfo[index].series._seriesType == 'stackedcolumn' ||
                  chartPointInfo[index].series._seriesType == 'rangecolumn') &&
              !chart.isTransposed) ||
          (chartPointInfo[index].series._seriesType == 'bar' ||
              chartPointInfo[index].series._seriesType == 'stackedbar' &&
                  chart.isTransposed)) {
        isHorizontalOrientation = true;
      }
      isRectSeries = false;
      if (((chartPointInfo[index].series._seriesType == 'column' ||
                  chartPointInfo[index].series._seriesType == 'stackedcolumn' ||
                  chartPointInfo[index].series._seriesType == 'rangecolumn') &&
              chart.isTransposed) ||
          ((chartPointInfo[index].series._seriesType == 'bar' ||
                  chartPointInfo[index].series._seriesType == 'stackedbar') &&
              !chart.isTransposed)) {
        isRectSeries = true;
      }
      if (!canResetPath &&
          chart.trackballBehavior.lineType != TrackballLineType.none) {
        final Paint trackballLinePaint = Paint();
        trackballLinePaint.color = chart.trackballBehavior.lineColor ??
            chart._chartTheme.crosshairLineColor;
        trackballLinePaint.strokeWidth = chart.trackballBehavior.lineWidth;
        trackballLinePaint.style = PaintingStyle.stroke;
        chart.trackballBehavior.lineWidth == 0
            ? trackballLinePaint.color = Colors.transparent
            : trackballLinePaint.color = trackballLinePaint.color;
        chart.trackballBehavior._drawLine(canvas,
            chart.trackballBehavior._linePainter(trackballLinePaint), index);
      }
      final Offset position = Offset(
          chartPointInfo[index].xPosition, chartPointInfo[index].yPosition);

      if (chart.trackballBehavior.tooltipDisplayMode ==
          TrackballDisplayMode.groupAllPoints) {
        stringValue = <String>[];
        for (int i = 0; i < chartPointInfo.length; i++) {
          stringValue.add(chartPointInfo[i].label);
          if (_measureText(stringValue[i], labelStyle).width > width) {
            width = _measureText(stringValue[i], labelStyle).width;
          }
          height += _measureText(stringValue[i], labelStyle).height;
        }
        x = position.dx;
        if (chart.trackballBehavior.tooltipAlignment == ChartAlignment.center)
          y = chart._chartAxis._axisClipRect.center.dy;
        else if (chart.trackballBehavior.tooltipAlignment ==
            ChartAlignment.near)
          y = chart._chartAxis._axisClipRect.top;
        else
          y = chart._chartAxis._axisClipRect.bottom;
      } else {
        stringValue = <String>[];
        stringValue.add(chartPointInfo[index].label);
        width = _measureText(stringValue[0], labelStyle).width;
        height = _measureText(stringValue[0], labelStyle).height;

        if (chartPointInfo[index].series._seriesType == 'column' ||
            chartPointInfo[index].series._seriesType == 'bar' ||
            chartPointInfo[index].series._seriesType == 'stackedcolumn' ||
            chartPointInfo[index].series._seriesType == 'stackedbar' ||
            chartPointInfo[index].series._seriesType == 'stackedline' ||
            chartPointInfo[index].series._seriesType == 'stackedarea' ||
            chartPointInfo[index].series._seriesType == 'rangecolumn') {
          x = chartPointInfo[index].chartDataPoint.markerPoint.x;
          y = chartPointInfo[index].chartDataPoint.markerPoint.y;
        } else {
          x = position.dx;
          y = position.dy;
        }
      }

      if (width < 10) {
        width = 10;

        /// minimum width for tooltip to render
        borderRadius = borderRadius > 5 ? 5 : borderRadius;
      }
      if (borderRadius > 15) {
        borderRadius = 15;
      }

      padding = 5;
      if (x != null &&
          y != null &&
          padding != null &&
          chart.trackballBehavior.tooltipSettings.enable) {
        Rect labelRect = Rect.fromLTWH(x, y, width + 15, height + 10);
        final Rect backgroundRect = Rect.fromLTWH(boundaryRect.left + 25,
            boundaryRect.top, boundaryRect.width - 50, boundaryRect.height);
        final Rect leftRect = Rect.fromLTWH(
            boundaryRect.left - 5,
            boundaryRect.top,
            backgroundRect.left - (boundaryRect.left - 5),
            boundaryRect.height);
        final Rect rightRect = Rect.fromLTWH(
            backgroundRect.right,
            boundaryRect.top,
            (boundaryRect.right + 5) - backgroundRect.right,
            boundaryRect.height);
        if (leftRect.contains(Offset(x, y))) {
          isLeft = true;
          isRight = false;
        } else if (rightRect.contains(Offset(x, y))) {
          isLeft = false;
          isRight = true;
        }

        if (y > pointerLength + labelRect.height) {
          isTop = true;
          if (isHorizontalOrientation) {
            xPos = x - (labelRect.width / 2);
            yPos = (y - labelRect.height) - padding;
            nosePointY = labelRect.top - padding;
            nosePointX = labelRect.left;
            final double tooltipRightEnd = x + (labelRect.width / 2);
            xPos = xPos < boundaryRect.left
                ? boundaryRect.left
                : tooltipRightEnd > totalWidth
                    ? totalWidth - labelRect.width
                    : xPos;
            yPos = yPos - pointerLength;
            if (yPos + labelRect.height >= boundaryRect.bottom) {
              yPos = boundaryRect.bottom - labelRect.height;
            }
          } else {
            xPos = x + padding + pointerLength;

            yPos = y - labelRect.height / 2;
            nosePointY = labelRect.top;
            nosePointX = labelRect.left;
            final double tooltipRightEnd = xPos + (labelRect.width);
            if (xPos < boundaryRect.left) {
              xPos = (chart.trackballBehavior.tooltipDisplayMode ==
                          TrackballDisplayMode.groupAllPoints &&
                      chart.trackballBehavior.tooltipAlignment ==
                          ChartAlignment.far)
                  ? boundaryRect.left + groupAllPadding
                  : boundaryRect.left;
            } else if (tooltipRightEnd > totalWidth) {
              xPos = (chart.trackballBehavior.tooltipDisplayMode ==
                          TrackballDisplayMode.groupAllPoints &&
                      chart.trackballBehavior.tooltipAlignment ==
                          ChartAlignment.far)
                  ? xPos - labelRect.width / 2 - groupAllPadding
                  : ((xPos - labelRect.width - (2 * padding)) -
                      2 * pointerLength);

              isRight = true;
            } else {
              xPos = xPos;
            }
            if (yPos + labelRect.height >= boundaryRect.bottom) {
              yPos = boundaryRect.bottom - labelRect.height;
            }
          }
        } else {
          isTop = false;
          if (isHorizontalOrientation) {
            xPos = x - (labelRect.width / 2);
            yPos = (y + pointerLength) + padding;
            nosePointX = labelRect.left;
            nosePointY = labelRect.top + padding;
            final double tooltipRightEnd = x + (labelRect.width / 2);
            xPos = xPos < boundaryRect.left
                ? boundaryRect.left
                : tooltipRightEnd > totalWidth
                    ? totalWidth - labelRect.width
                    : xPos;
          } else {
            if (chart.trackballBehavior.tooltipDisplayMode ==
                TrackballDisplayMode.groupAllPoints) {
              xPos = x - labelRect.width / 2;
              yPos = y;
            } else {
              xPos = x + padding + pointerLength;
              yPos = (y + pointerLength / 2) + padding;
            }
            nosePointX = labelRect.left;
            nosePointY = labelRect.top;
            final double tooltipRightEnd = x + labelRect.width;
            if (xPos < boundaryRect.left) {
              xPos = (chart.trackballBehavior.tooltipDisplayMode ==
                      TrackballDisplayMode.groupAllPoints)
                  ? boundaryRect.left + groupAllPadding
                  : boundaryRect.left;
            } else if (tooltipRightEnd > totalWidth) {
              xPos = (chart.trackballBehavior.tooltipDisplayMode ==
                      TrackballDisplayMode.groupAllPoints)
                  ? (xPos - (labelRect.width / 2) - groupAllPadding)
                  : ((xPos - labelRect.width - (2 * padding)) -
                      2 * pointerLength);

              isRight = true;
            } else {
              xPos = (chart.trackballBehavior.tooltipDisplayMode ==
                          TrackballDisplayMode.groupAllPoints &&
                      chart.trackballBehavior.tooltipAlignment ==
                          ChartAlignment.near)
                  ? x + padding + pointerLength
                  : xPos;
            }
          }
        }
        if (chart.trackballBehavior.tooltipDisplayMode !=
            TrackballDisplayMode.groupAllPoints) {
          if (xPos <= boundaryRect.left + 5) {
            xPos = xPos + 10;
          } else if (xPos + labelRect.width >= totalWidth - 5) {
            xPos = xPos - 10;
          }
        }
        labelRect =
            Rect.fromLTWH(xPos, yPos, labelRect.width, labelRect.height);
        _drawBackground(canvas, labelRect, nosePointX, nosePointY, borderRadius,
            isTop, backgroundPath, isLeft, isRight, index);
      }
      if (chart.trackballBehavior.tooltipDisplayMode ==
          TrackballDisplayMode.groupAllPoints) {
        break;
      }
    }
  }

  void _drawTrackBallLine(Canvas canvas, Paint paint, int index) {
    final Path dashArrayPath = Path();
    if (chart.trackballBehavior.lineType == TrackballLineType.vertical) {
      if (isRectSeries) {
        dashArrayPath.moveTo(chart.trackballBehavior.position.dx,
            chart._chartAxis._axisClipRect.top);
        dashArrayPath.lineTo(chart.trackballBehavior.position.dx,
            chart._chartAxis._axisClipRect.bottom);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      } else if (chart.isTransposed) {
        dashArrayPath.moveTo(chart.trackballBehavior.position.dx,
            chart._chartAxis._axisClipRect.top);
        dashArrayPath.lineTo(chart.trackballBehavior.position.dx,
            chart._chartAxis._axisClipRect.bottom);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      } else {
        dashArrayPath.moveTo(chartPointInfo[index].xPosition,
            chart._chartAxis._axisClipRect.top);
        dashArrayPath.lineTo(chartPointInfo[index].xPosition,
            chart._chartAxis._axisClipRect.bottom);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      }
    } else {
      if (isRectSeries) {
        dashArrayPath.moveTo(chart._chartAxis._axisClipRect.left,
            chartPointInfo[index].yPosition);
        dashArrayPath.lineTo(chart._chartAxis._axisClipRect.right,
            chartPointInfo[index].yPosition);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      } else if (chart.isTransposed) {
        dashArrayPath.moveTo(chart._chartAxis._axisClipRect.left,
            chartPointInfo[index].yPosition);
        dashArrayPath.lineTo(chart._chartAxis._axisClipRect.right,
            chartPointInfo[index].yPosition);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      } else {
        dashArrayPath.moveTo(chart._chartAxis._axisClipRect.left,
            chart.trackballBehavior.position.dy);
        dashArrayPath.lineTo(chart._chartAxis._axisClipRect.right,
            chart.trackballBehavior.position.dy);
        chart.trackballBehavior.lineDashArray != null
            ? _drawDashedLine(paint, canvas, dashArrayPath)
            : canvas.drawPath(dashArrayPath, paint);
      }
    }
  }

  void _drawDashedLine(Paint paint, Canvas canvas, Path dashArrayPath) {
    bool even = false;
    for (int i = 1;
        i < chart.trackballBehavior.lineDashArray.length;
        i = i + 2) {
      if (chart.trackballBehavior.lineDashArray[i] == 0) {
        even = true;
      }
    }
    if (even == false) {
      paint.isAntiAlias = false;
      canvas.drawPath(
          _dashPath(
            dashArrayPath,
            dashArray: _CircularIntervalList<double>(
                chart.trackballBehavior.lineDashArray),
          ),
          paint);
    } else {
      canvas.drawPath(dashArrayPath, paint);
    }
  }

  void _drawBackground(
      Canvas canvas,
      Rect labelRect,
      double xPos,
      double yPos,
      double borderRadius,
      bool isTop,
      Path backgroundPath,
      bool isLeft,
      bool isRight,
      int index) {
    final double startArrow = pointerLength;
    final double endArrow = pointerLength;
    if (isTop) {
      _drawTooltip(
          canvas,
          labelRect,
          xPos,
          yPos,
          xPos - startArrow,
          yPos - startArrow,
          xPos + endArrow,
          yPos - endArrow,
          borderRadius,
          backgroundPath,
          isLeft,
          isRight,
          index);
    } else {
      _drawTooltip(
          canvas,
          labelRect,
          xPos,
          yPos,
          xPos - startArrow,
          yPos + startArrow,
          xPos + endArrow,
          yPos + endArrow,
          borderRadius,
          backgroundPath,
          isLeft,
          isRight,
          index);
    }
  }

  void _drawTooltip(
      Canvas canvas,
      Rect rectF,
      double xPos,
      double yPos,
      double startX,
      double startY,
      double endX,
      double endY,
      double borderRadius,
      Path backgroundPath,
      bool isLeft,
      bool isRight,
      int index) {
    backgroundPath.reset();
    if (!canResetPath &&
        chart.trackballBehavior.tooltipDisplayMode !=
            TrackballDisplayMode.none) {
      if (chart.trackballBehavior.tooltipDisplayMode !=
          TrackballDisplayMode.groupAllPoints) {
        if (isHorizontalOrientation) {
          if (isLeft) {
            startX = rectF.left + borderRadius;
            endX = startX + pointerWidth;
          } else if (isRight) {
            endX = rectF.right - borderRadius;
            startX = endX - pointerWidth;
          }
          backgroundPath.moveTo(
              (rectF.left + rectF.width / 2) - pointerWidth, startY);
          backgroundPath.lineTo(xPos, yPos);
          backgroundPath.lineTo(
              (rectF.right - rectF.width / 2) + pointerWidth, endY);
        } else {
          if (isRight) {
            backgroundPath.moveTo(
                rectF.right, rectF.top + rectF.height / 2 - pointerWidth);
            backgroundPath.lineTo(
                rectF.right, rectF.bottom - rectF.height / 2 + pointerWidth);
            backgroundPath.lineTo(rectF.right + pointerLength, yPos);
            backgroundPath.lineTo(rectF.right + pointerLength, yPos);
            backgroundPath.lineTo(
                rectF.right, rectF.top + rectF.height / 2 - pointerWidth);
          } else {
            backgroundPath.moveTo(
                rectF.left, rectF.top + rectF.height / 2 - pointerWidth);
            backgroundPath.lineTo(
                rectF.left, rectF.bottom - rectF.height / 2 + pointerWidth);
            backgroundPath.lineTo(rectF.left - pointerLength, yPos);
            backgroundPath.lineTo(rectF.left - pointerLength, yPos);
            backgroundPath.lineTo(
                rectF.left, rectF.top + rectF.height / 2 - pointerWidth);
          }
        }
      }
      final RRect tooltipRect = RRect.fromRectAndCorners(
        rectF,
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      );

      backgroundPath.addRRect(tooltipRect);

      final Paint fillPaint = Paint()
        ..color = chart.trackballBehavior.tooltipSettings.color != null
            ? chart.trackballBehavior.tooltipSettings.color
            : (chartPointInfo[index].series.color != null
                ? chartPointInfo[index].series.color
                : chart._chartTheme.crosshairFillColor)
        ..isAntiAlias = false
        ..style = PaintingStyle.fill;

      final Paint stokePaint = Paint()
        ..color = chart.trackballBehavior.tooltipSettings.borderColor != null
            ? chart.trackballBehavior.tooltipSettings.borderColor
            : (chartPointInfo[index].series.color != null
                ? chartPointInfo[index].series.color
                : chart._chartTheme.crosshairFillColor)
        ..strokeWidth = chart.trackballBehavior.tooltipSettings.borderWidth
        ..strokeCap = StrokeCap.butt
        ..isAntiAlias = false
        ..style = PaintingStyle.stroke;

      canvas.drawPath(backgroundPath, stokePaint);
      canvas.drawPath(backgroundPath, fillPaint);

      double eachTextHeight = 0;
      Size labelSize;
      double totalHeight = 0;

      for (int i = 0; i < stringValue.length; i++) {
        labelSize = _measureText(stringValue[i], labelStyle);
        totalHeight += labelSize.height;
      }

      eachTextHeight =
          (tooltipRect.top + tooltipRect.height / 2) - totalHeight / 2;

      for (int i = 0; i < stringValue.length; i++) {
        labelSize = _measureText(stringValue[i], labelStyle);
        eachTextHeight += labelSize.height;
        _drawText(
            canvas,
            stringValue[i],
            Offset(
                (tooltipRect.left + tooltipRect.width / 2) -
                    labelSize.width / 2,
                eachTextHeight - labelSize.height),
            labelStyle,
            0);
      }
      xPos = null;
      yPos = null;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  /// calculate trackball points
  void _generateAllPoints(Offset position) {
    chartPointInfo = <_ChartPointInfo>[];
    final Rect seriesBounds = chart._chartAxis._axisClipRect;
    if (seriesBounds.contains(position)) {
      chart.trackballBehavior.position = position;
      double xPos = 0;
      double yPos = 0;
      int seriesIndex = 0;
      double leastX = 0;
      final List<ChartAxis> seriesAxes = <ChartAxis>[];
      for (XyDataSeries<dynamic, dynamic> series
          in chart._chartSeries.visibleSeries) {
        if (series._visible) {
          final XyDataSeries<dynamic, dynamic> visibleSeries = series;
          final ChartAxis chartAxis = visibleSeries._xAxis;
          if (chartAxis == null) {
            continue;
          }
          if (!seriesAxes.contains(chartAxis)) {
            seriesAxes.add(chartAxis);
            for (XyDataSeries<dynamic, dynamic> axisSeries
                in chartAxis._series) {
              final XyDataSeries<dynamic, dynamic> cartesianSeries = axisSeries;
              if (axisSeries._visible == false) {
                continue;
              }
              if (axisSeries._dataPoints.isEmpty && !axisSeries._isRectSeries) {
                continue;
              }
              if (cartesianSeries._dataPoints.isNotEmpty) {
                final List<dynamic> nearestDataPoints = _getNearestChartPoints(
                    position.dx,
                    position.dy,
                    chartAxis,
                    visibleSeries._yAxis,
                    cartesianSeries);
                if (nearestDataPoints == null) {
                  continue;
                }
                for (dynamic dataPoint in nearestDataPoints) {
                  final int index = axisSeries._dataPoints.indexOf(dataPoint);
                  final List<num> xValues = <num>[];
                  final List<num> yValues = <num>[];
                  final List<num> highValues = <num>[];
                  final List<num> lowValues = <num>[];
                  final List<num> bubbleSizes = <num>[];
                  final List<dynamic> cumulativeValues = <dynamic>[];
                  for (int i = 0; i < cartesianSeries._dataPoints.length; i++) {
                    xValues.add(cartesianSeries._dataPoints[i].xValue);
                    yValues.add(cartesianSeries._dataPoints[i].yValue);
                    highValues.add(cartesianSeries._dataPoints[i].high);
                    lowValues.add(cartesianSeries._dataPoints[i].low);
                    bubbleSizes.add(cartesianSeries._dataPoints[i].bubbleSize);
                    cumulativeValues
                        .add(cartesianSeries._dataPoints[i].cumulativeValue);
                  }
                  final num xValue = xValues[index];
                  final num yValue = yValues[index];
                  final num highValue = highValues[index];
                  final num lowValue = lowValues[index];
                  final String seriesName =
                      cartesianSeries.name ?? 'Series $seriesIndex';
                  final num bubbleSize = bubbleSizes[index];
                  final dynamic cumulativeValue = cumulativeValues[index];
                  final Rect axisClipRect = _calculatePlotOffset(
                      cartesianSeries._chart._chartAxis._axisClipRect,
                      Offset(cartesianSeries._xAxis.plotOffset,
                          cartesianSeries._yAxis.plotOffset));
                  xPos = _calculatePoint(
                          xValue,
                          yValue,
                          cartesianSeries._xAxis,
                          cartesianSeries._yAxis,
                          chart._requireInvertedAxis,
                          cartesianSeries,
                          axisClipRect)
                      .x;
                  if (!xPos.toDouble().isNaN) {
                    if (seriesIndex == 0) {
                      leastX = xPos;
                    }
                    if ((leastX - position.dx) > (leastX - xPos)) {
                      leastX = xPos;
                    }
                    String labelValue;
                    if (chart.trackballBehavior.tooltipSettings.format !=
                        null) {
                      dynamic x;
                      final dynamic axis = cartesianSeries._xAxis;
                      if (axis is DateTimeAxis) {
                        final DateFormat dateFormat =
                            axis.dateFormat ?? axis._getLabelFormat(axis);
                        x = dateFormat.format(
                            DateTime.fromMillisecondsSinceEpoch(xValue));
                      } else if (axis is CategoryAxis) {
                        x = axis._visibleLabels[xValue.round()].text;
                      }
                      labelValue = chart
                          .trackballBehavior.tooltipSettings.format
                          .replaceAll('point.x', (x ?? xValue).toString())
                          .replaceAll('point.y',
                              _getLabelValue(yValue, cartesianSeries._yAxis))
                          .replaceAll('point.high', highValue.toString())
                          .replaceAll('point.low', lowValue.toString())
                          .replaceAll('{', '')
                          .replaceAll('}', '')
                          .replaceAll('series.name', seriesName)
                          .replaceAll('point.size', bubbleSize.toString())
                          .replaceAll('point.cumulativeValue',
                              cumulativeValue.toString());
                    } else {
                      labelValue = series._seriesType != 'rangecolumn'
                          ? _getLabelValue(yValue, cartesianSeries._yAxis)
                          : 'high: ' +
                              highValue.toString() +
                              '\n low: ' +
                              lowValue.toString();
                    }

                    yPos = _calculatePoint(
                            xValue,
                            yValue,
                            cartesianSeries._xAxis,
                            cartesianSeries._yAxis,
                            chart._requireInvertedAxis,
                            cartesianSeries,
                            axisClipRect)
                        .y;

                    final Rect rect = seriesBounds
                        .intersect(Rect.fromLTWH(xPos - 1, yPos - 1, 2, 2));
                    if (seriesBounds.contains(Offset(xPos, yPos)) ||
                        seriesBounds.overlaps(rect)) {
                      _addChartPointInfo(
                          cartesianSeries, xPos, yPos, index, labelValue);
                      if (chart.trackballBehavior.tooltipDisplayMode ==
                              TrackballDisplayMode.groupAllPoints &&
                          leastX >= seriesBounds.left) {
                        if (chart._requireInvertedAxis) {
                          yPos = leastX;
                        } else {
                          xPos = leastX;
                        }
                      }
                    }
                  }
                }
                seriesIndex++;
              }
              _validateNearestXValue(leastX, series, position.dx, position.dy);
            }
            if (chartPointInfo.isNotEmpty) {
              if (chart.trackballBehavior.tooltipDisplayMode !=
                  TrackballDisplayMode.groupAllPoints) {
                chart._requireInvertedAxis
                    ? chartPointInfo.sort(
                        (_ChartPointInfo a, _ChartPointInfo b) =>
                            a.xPosition.compareTo(b.xPosition))
                    : chartPointInfo.sort(
                        (_ChartPointInfo a, _ChartPointInfo b) =>
                            a.yPosition.compareTo(b.yPosition));
              }

              if (chart.trackballBehavior.tooltipDisplayMode ==
                      TrackballDisplayMode.nearestPoint ||
                  (series._isRectSeries &&
                      chart.trackballBehavior.tooltipDisplayMode !=
                          TrackballDisplayMode.groupAllPoints)) {
                _validateNearestPointForAllSeries(
                    leastX, chartPointInfo, position.dx, position.dy);
              }
            }
          }
        }
      }
    }
  }

  void _validateNearestPointForAllSeries(double leastX,
      List<_ChartPointInfo> trackballInfo, double touchXPos, double touchYPos) {
    double xPos = 0;
    final List<_ChartPointInfo> tempTrackballInfo =
        List<_ChartPointInfo>.from(trackballInfo);
    for (int i = 0; i < tempTrackballInfo.length; i++) {
      final _ChartPointInfo pointInfo = tempTrackballInfo[i];
      final List<num> xValues = <num>[];
      final List<num> yValues = <num>[];
      for (int i = 0; i < pointInfo.series._dataPoints.length; i++) {
        xValues.add(pointInfo.series._dataPoints[i].xValue);
        yValues.add(pointInfo.series._dataPoints[i].yValue);
      }
      final num xValue = xValues[pointInfo.dataPointIndex];
      final num yValue = yValues[pointInfo.dataPointIndex];

      final Rect axisClipRect = _calculatePlotOffset(
          pointInfo.series._chart._chartAxis._axisClipRect,
          Offset(pointInfo.series._xAxis.plotOffset,
              pointInfo.series._yAxis.plotOffset));

      xPos = _calculatePoint(
              xValue,
              yValue,
              pointInfo.series._xAxis,
              pointInfo.series._yAxis,
              chart._requireInvertedAxis,
              pointInfo.series,
              axisClipRect)
          .x;

      if (pointInfo.series._isRectSeries &&
          chart.enableSideBySideSeriesPlacement &&
          chart.trackballBehavior.tooltipDisplayMode !=
              TrackballDisplayMode.groupAllPoints) {
        final bool isXAxisInverse = chart._requireInvertedAxis;

        final _VisibleRange sideBySideInfo =
            _calculateSideBySideInfo(pointInfo.series, chart);
        final double xStartValue = xValue + sideBySideInfo.minimum;
        final double xEndValue = xValue + sideBySideInfo.maximum;

        double xStart = _calculatePoint(
                xStartValue,
                yValue,
                pointInfo.series._xAxis,
                pointInfo.series._yAxis,
                chart._requireInvertedAxis,
                pointInfo.series,
                axisClipRect)
            .x;
        double xEnd = _calculatePoint(
                xEndValue,
                yValue,
                pointInfo.series._xAxis,
                pointInfo.series._yAxis,
                chart._requireInvertedAxis,
                pointInfo.series,
                axisClipRect)
            .x;

        bool isStartIndex = pointInfo.series._sideBySideIndex == 0;
        bool isEndIndex = pointInfo.series._sideBySideIndex ==
            pointInfo.series._chart._chartSeries.visibleSeries.length - 1;
        final double xPos = touchXPos;
        if (isXAxisInverse) {
          final double temp = xStart;
          xStart = xEnd;
          xEnd = temp;
          final bool isTemp = isEndIndex;
          isEndIndex = isStartIndex;
          isStartIndex = isTemp;
        } else if (pointInfo.series._chart._chartState.zoomedState == true ||
            chart.trackballBehavior.tooltipDisplayMode !=
                TrackballDisplayMode.floatAllPoints) {
          if (xPos < leastX && isStartIndex) {
            if (!(xPos < xStart) && !(xPos < xEnd && xPos >= xStart)) {
              trackballInfo.remove(pointInfo);
            }
          } else if (xPos > leastX && isEndIndex) {
            if (!(xPos > xEnd && xPos > xStart) &&
                !(xPos < xEnd && xPos >= xStart)) {
              trackballInfo.remove(pointInfo);
            }
          } else if (!(xPos < xEnd && xPos >= xStart)) {
            trackballInfo.remove(pointInfo);
          }
        }
      }

      if (chart.trackballBehavior.tooltipDisplayMode !=
              TrackballDisplayMode.floatAllPoints &&
          (!pointInfo.series._chart._requireInvertedAxis)) {
        if (leastX != xPos) {
          trackballInfo.remove(pointInfo);
        }
        final int pointInfoIndex = tempTrackballInfo.indexOf(pointInfo);
        final double yPos = touchYPos;

        if (pointInfoIndex < tempTrackballInfo.length - 1) {
          final _ChartPointInfo nextPointInfo =
              tempTrackballInfo[pointInfoIndex + 1];

          if (nextPointInfo.yPosition == pointInfo.yPosition ||
              (pointInfo.yPosition > yPos && pointInfoIndex == 0)) {
            continue;
          }
          if (!(yPos <
              (nextPointInfo.yPosition -
                  ((nextPointInfo.yPosition - pointInfo.yPosition) / 2)))) {
            trackballInfo.remove(pointInfo);
          } else if (pointInfoIndex != 0) {
            final _ChartPointInfo previousPointInfo =
                tempTrackballInfo[pointInfoIndex - 1];
            if (yPos <
                (pointInfo.yPosition -
                    ((pointInfo.yPosition - previousPointInfo.yPosition) /
                        2))) {
              trackballInfo.remove(pointInfo);
            }
          }
        } else {
          if (pointInfoIndex != 0 &&
              pointInfoIndex == tempTrackballInfo.length - 1) {
            final _ChartPointInfo previousPointInfo =
                tempTrackballInfo[pointInfoIndex - 1];
            if (yPos < previousPointInfo.yPosition) {
              trackballInfo.remove(pointInfo);
            }
            if (yPos <
                (pointInfo.yPosition -
                    ((pointInfo.yPosition - previousPointInfo.yPosition) /
                        2))) {
              trackballInfo.remove(pointInfo);
            }
          }
        }
      }
    }
  }

  void _validateNearestXValue(
      double leastX,
      XyDataSeries<dynamic, dynamic> series,
      double touchXPos,
      double touchYPos) {
    final List<_ChartPointInfo> leastPointInfo = <_ChartPointInfo>[];
    final XyDataSeries<dynamic, dynamic> cartesianSeries = series;

    final Rect axisClipRect = _calculatePlotOffset(
        cartesianSeries._chart._chartAxis._axisClipRect,
        Offset(cartesianSeries._xAxis.plotOffset,
            cartesianSeries._yAxis.plotOffset));

    double nearPointX = cartesianSeries._chart._requireInvertedAxis
        ? axisClipRect.top
        : axisClipRect.left;
    final double touchXValue =
        cartesianSeries._chart._requireInvertedAxis ? touchYPos : touchXPos;
    double delta = 0;
    for (_ChartPointInfo pointInfo in chartPointInfo) {
      final List<num> xValues = <num>[];
      final List<num> yValues = <num>[];
      for (int i = 0; i < cartesianSeries._dataPoints.length; i++) {
        xValues.add(cartesianSeries._dataPoints[i].xValue);
        yValues.add(cartesianSeries._dataPoints[i].yValue);
      }
      final num xValue = xValues[pointInfo.dataPointIndex];
      final num yValue = yValues[pointInfo.dataPointIndex];
      final double currX = cartesianSeries._chart._requireInvertedAxis
          ? _calculatePoint(
                  xValue,
                  yValue,
                  pointInfo.series._xAxis,
                  pointInfo.series._yAxis,
                  chart._requireInvertedAxis,
                  pointInfo.series,
                  axisClipRect)
              .y
          : _calculatePoint(
                  xValue,
                  yValue,
                  pointInfo.series._xAxis,
                  pointInfo.series._yAxis,
                  chart._requireInvertedAxis,
                  pointInfo.series,
                  axisClipRect)
              .x;

      if (delta == touchXValue - currX) {
        leastPointInfo.add(pointInfo);
      } else if ((touchXValue - currX).toDouble().abs() <=
          (touchXValue - nearPointX).toDouble().abs()) {
        nearPointX = currX;
        delta = touchXValue - currX;
        leastPointInfo.clear();
        leastPointInfo.add(pointInfo);
      }
    }

    final List<_ChartPointInfo> trackballInfoClone =
        List<_ChartPointInfo>.from(chartPointInfo);

    for (_ChartPointInfo pointInfo in trackballInfoClone) {
      if (!leastPointInfo.contains(pointInfo)) {
        chartPointInfo.remove(pointInfo);
      }
    }

    if (chartPointInfo.isNotEmpty) {
      final _ChartPointInfo pointInfo = chartPointInfo[0];
      final List<num> xValues = <num>[];
      final List<num> yValues = <num>[];
      for (int i = 0; i < cartesianSeries._dataPoints.length; i++) {
        xValues.add(cartesianSeries._dataPoints[i].xValue);
        yValues.add(cartesianSeries._dataPoints[i].yValue);
      }

      final num xValue = xValues[pointInfo.dataPointIndex];
      final num yValue = yValues[pointInfo.dataPointIndex];
      leastX = _calculatePoint(
              xValue,
              yValue,
              cartesianSeries._xAxis,
              cartesianSeries._yAxis,
              chart._requireInvertedAxis,
              cartesianSeries,
              axisClipRect)
          .x;
    }

    if (chart.isTransposed) {
      yPos = leastX;
    } else {
      xPos = leastX;
    }
  }

  void _addChartPointInfo(CartesianSeries<dynamic, dynamic> series, double xPos,
      double yPos, int dataPointIndex, String label) {
    final _ChartPointInfo pointInfo = _ChartPointInfo();
    pointInfo.series = series;
    pointInfo.markerXPos = xPos;
    pointInfo.markerYPos = yPos;
    pointInfo.xPosition = xPos;
    pointInfo.yPosition = yPos;

    if (series.segments.length > dataPointIndex) {
      pointInfo.color = series.segments[dataPointIndex].color;
    } else {
      if (series.segments.length > 1) {
        pointInfo.color = series.segments[series.segments.length - 1].color;
      }
    }
    pointInfo.chartDataPoint = series._dataPoints[dataPointIndex];
    pointInfo.dataPointIndex = dataPointIndex;
    pointInfo.label = label;
    chartPointInfo.add(pointInfo);
  }

  String getFormattedValue(num value) => value.toString();
}
