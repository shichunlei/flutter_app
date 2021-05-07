part of flutter_charts;

void _calculateDataLabelPosition(
    XyDataSeries<dynamic, dynamic> series,
    _CartesianChartPoint<dynamic> currentPoint,
    int index,
    SfCartesianChart chart) {
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  EdgeInsets margin;
  Size textSize, textSize2;
  const double padding = 10;
  final bool inverted = chart._requireInvertedAxis;
  final Rect clipRect = _calculatePlotOffset(chart._chartAxis._axisClipRect,
      Offset(series._xAxis.plotOffset, series._yAxis.plotOffset));
  margin = (dataLabel.margin == null)
      ? const EdgeInsets.fromLTRB(0, 0, 0, 0)
      : dataLabel.margin;
  final num markerPointX = currentPoint.markerPoint.x;
  final num markerPointY = currentPoint.markerPoint.y;
  if (currentPoint != null &&
      currentPoint.isVisible &&
      currentPoint.isGap != true) {
    final String label = currentPoint.dataLabelMapper ??
        _getLabelText(
            (series._seriesType == 'rangecolumn' && !series._yAxis.isInversed)
                ? math.max<num>(currentPoint.high, currentPoint.low)
                : (series._seriesType == 'rangecolumn' &&
                        series._yAxis.isInversed)
                    ? math.min<num>(currentPoint.high, currentPoint.low)
                    : dataLabel.showCumulativeValues &&
                            currentPoint.cumulativeValue != null
                        ? currentPoint.cumulativeValue
                        : currentPoint.yValue,
            series,
            chart);
    String label2;
    if (series._seriesType == 'rangecolumn') {
      label2 = currentPoint.dataLabelMapper ??
          _getLabelText(
              !series._yAxis.isInversed
                  ? math.min<num>(currentPoint.high, currentPoint.low)
                  : math.max<num>(currentPoint.high, currentPoint.low),
              series,
              chart);
    }
    final ChartTextStyle font =
        (dataLabel.textStyle == null) ? ChartTextStyle() : dataLabel.textStyle;
    currentPoint.label = label;
    currentPoint.label2 = label2;
    if (label.isNotEmpty) {
      textSize = _measureText(label, font);
      textSize2 = _measureText(label2, font);
      _ChartLocation chartLocation, chartLocation2;
      if (series._isRectSeries && series._seriesType != 'rangecolumn') {
        chartLocation = (((series._seriesType == 'bar' ||
                        series._seriesType == 'stackedbar') &&
                    chart.isTransposed != true) ||
                ((series._seriesType == 'column' ||
                        series._seriesType == 'stackedcolumn') &&
                    chart.isTransposed == true))
            ? (series._yAxis.isInversed
                ? (currentPoint.yValue.isNegative
                    ? _ChartLocation(
                        currentPoint.region.centerRight.dx + textSize.width,
                        currentPoint.region.centerRight.dy)
                    : _ChartLocation(
                        currentPoint.region.centerLeft.dx + textSize.width,
                        currentPoint.region.centerLeft.dy - textSize.height))
                : (currentPoint.yValue.isNegative
                    ? _ChartLocation(
                        currentPoint.region.centerLeft.dx + textSize.width * 2,
                        currentPoint.region.centerLeft.dy)
                    : _ChartLocation(
                        currentPoint.region.centerRight.dx + textSize.width,
                        currentPoint.region.centerRight.dy)))
            : (series._yAxis.isInversed
                ? (currentPoint.yValue.isNegative
                    ? _ChartLocation(currentPoint.region.topCenter.dx,
                        currentPoint.region.topCenter.dy)
                    : _ChartLocation(currentPoint.region.bottomCenter.dx,
                        currentPoint.region.bottomCenter.dy))
                : (currentPoint.yValue.isNegative
                    ? _ChartLocation(currentPoint.region.bottomCenter.dx,
                        currentPoint.region.bottomCenter.dy)
                    : _ChartLocation(currentPoint.region.topCenter.dx,
                        currentPoint.region.topCenter.dy)));
      } else {
        chartLocation = chart.isTransposed
            ? _ChartLocation(
                markerPointX +
                    (dataLabel.labelAlignment == ChartDataLabelAlignment.auto ||
                            dataLabel.labelAlignment ==
                                ChartDataLabelAlignment.top
                        ? textSize.width
                        : textSize.width / 2) +
                    ((series._seriesType == 'rangecolumn' &&
                            series.markerSettings.isVisible)
                        ? series.markerSettings.width / 4 - padding / 2
                        : 0),
                markerPointY)
            : (series._seriesType == 'rangecolumn'
                ? _ChartLocation(
                    markerPointX,
                    markerPointY -
                        ((dataLabel.labelAlignment !=
                                    ChartDataLabelAlignment.top &&
                                series.markerSettings.isVisible)
                            ? series.markerSettings.height / 2
                            : 0))
                : _ChartLocation(markerPointX, markerPointY));
        if (series._seriesType == 'rangecolumn') {
          chartLocation2 = chart.isTransposed
              ? _ChartLocation(
                  dataLabel.labelAlignment == ChartDataLabelAlignment.top
                      ? (currentPoint.markerPoint2.x + textSize.width)
                      : (currentPoint.markerPoint2.x -
                          (textSize.width / 2) -
                          (series.markerSettings.isVisible
                              ? (dataLabel.labelAlignment ==
                                      ChartDataLabelAlignment.auto
                                  ? series.markerSettings.width / 4
                                  : series.markerSettings.width)
                              : 0)),
                  currentPoint.markerPoint2.y)
              : _ChartLocation(
                  currentPoint.markerPoint2.x,
                  dataLabel.labelAlignment == ChartDataLabelAlignment.top
                      ? (currentPoint.markerPoint2.y - textSize.height / 2)
                      : (currentPoint.markerPoint2.y -
                          textSize.height / 4 +
                          (series.markerSettings.isVisible
                              ? series.markerSettings.height / 2
                              : 0)));
        }
      }

      final double alignmentValue = (series._seriesType == 'bubble')
          ? textSize.height +
              (series.markerSettings.borderWidth * 2) +
              series.markerSettings.height +
              currentPoint.region.height
          : textSize.height +
              (series.markerSettings.borderWidth * 2) +
              series.markerSettings.height;
      if (series._seriesType == 'bar') {
        chartLocation.x =
            (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                ? chartLocation.x
                : _calculateAlignment(
                    alignmentValue,
                    chartLocation.x,
                    dataLabel.alignment,
                    chartLocation.x < 0 ? false : true,
                    inverted);
      } else {
        chartLocation.y =
            (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                ? chartLocation.y
                : _calculateAlignment(
                    alignmentValue,
                    chartLocation.y,
                    dataLabel.alignment,
                    chartLocation.y < 0 ? false : true,
                    inverted);
        if (series._seriesType == 'rangecolumn') {
          chartLocation2.y =
              (dataLabel.labelAlignment == ChartDataLabelAlignment.auto)
                  ? chartLocation2.y
                  : _calculateAlignment(
                      alignmentValue,
                      chartLocation2.y,
                      dataLabel.alignment,
                      chartLocation2.y < 0 ? false : true,
                      inverted);
        }
      }

      if (!series._isRectSeries) {
        chartLocation.y = _calculatePathPosition(
            chartLocation.y,
            dataLabel.labelAlignment,
            textSize,
            series.markerSettings.borderWidth,
            series,
            index,
            inverted,
            chartLocation,
            chart,
            currentPoint);
      } else {
        bool result;
        bool minus;
        final num value = series._seriesType == 'rangecolumn'
            ? math.min<num>(currentPoint.high, currentPoint.low)
            : currentPoint.yValue;
        result = value < 0;
        minus = (result != inverted) ? true : false;
        if (!chart._requireInvertedAxis) {
          chartLocation.y = _calculateRectPosition(
              chartLocation.y,
              currentPoint.region,
              minus,
              (series._seriesType == 'rangecolumn' &&
                      (dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.bottom ||
                          dataLabel.labelAlignment ==
                              ChartDataLabelAlignment.middle))
                  ? ChartDataLabelAlignment.auto
                  : dataLabel.labelAlignment,
              series,
              textSize,
              series.markerSettings.borderWidth,
              index,
              chartLocation,
              chart,
              inverted);
          if (series._seriesType == 'rangecolumn') {
            chartLocation2.y = _calculateRectPosition(
                chartLocation2.y,
                currentPoint.region,
                minus,
                (dataLabel.labelAlignment == ChartDataLabelAlignment.top)
                    ? ChartDataLabelAlignment.auto
                    : ChartDataLabelAlignment.top,
                series,
                textSize2,
                series.markerSettings.borderWidth,
                index,
                chartLocation2,
                chart,
                inverted);
          }
        } else {
          chartLocation.y =
              series._yAxis.isInversed && !currentPoint.yValue.isNegative
                  ? currentPoint.region.centerLeft.dy
                  : chartLocation.y;
          chartLocation.x = ((series._seriesType != 'stackedbar' &&
                      dataLabel.labelAlignment ==
                          ChartDataLabelAlignment.auto) ||
                  (series._seriesType == 'rangecolumn' &&
                      dataLabel.labelAlignment != ChartDataLabelAlignment.top))
              ? (((series._yAxis.isInversed && !value.isNegative) ||
                      (!series._yAxis.isInversed && value.isNegative))
                  ? currentPoint.region.left - textSize.width / 2
                  : chartLocation.x)
              : _calculateRectPosition(
                  chartLocation.x +
                      ((series._seriesType == 'rangecolumn' &&
                              chart.isTransposed &&
                              dataLabel.labelAlignment !=
                                  ChartDataLabelAlignment.top)
                          ? textSize.width
                          : 0),
                  currentPoint.region,
                  minus,
                  (series._seriesType == 'rangecolumn' &&
                          chart.isTransposed &&
                          dataLabel.labelAlignment !=
                              ChartDataLabelAlignment.top)
                      ? ChartDataLabelAlignment.auto
                      : dataLabel.labelAlignment,
                  series,
                  textSize,
                  series.markerSettings.borderWidth,
                  index,
                  chartLocation,
                  chart,
                  inverted);
        }
      }
      final Rect rect = _calculateRect(chartLocation, textSize);
      double xPosition = rect.left;
      double yPosition = rect.top;
      final double rectWidth = rect.width;
      final double rectHeight = rect.height;
      final double clipRectWidth = clipRect.right;
      final double clipRectHeight = clipRect.bottom;
      currentPoint.dataLabelRegion =
          Rect.fromLTWH(xPosition, yPosition, textSize.width, textSize.height);
      if (xPosition + rectWidth > clipRectWidth) {
        final int padding =
            dataLabel.labelAlignment == ChartDataLabelAlignment.auto ? 5 : 0;
        xPosition = (series._seriesType == 'bar' ||
                series._seriesType == 'stackedbar' ||
                ((series._seriesType == 'column' ||
                        series._seriesType == 'rangecolumn' ||
                        series._seriesType == 'stackedcolumn') &&
                    chart.isTransposed))
            ? (currentPoint.region.right - rectWidth - padding)
            : clipRectWidth - rectWidth;
      }
      if (yPosition + rectHeight > clipRectHeight) {
        yPosition = clipRectHeight - rectHeight / 2 - padding;
      }
      if (!((yPosition > clipRectWidth) ||
          (xPosition > clipRectHeight) ||
          (xPosition + rectWidth < 0) ||
          (yPosition + rectHeight < 0))) {
        currentPoint.dataLabelSaturationRegionInside =
            yPosition < clipRect.top ||
                    currentPoint.dataLabelSaturationRegionInside
                ? true
                : currentPoint.dataLabelSaturationRegionInside;
        xPosition = xPosition < clipRect.left ? clipRect.left : xPosition;
        yPosition = yPosition < clipRect.top ? clipRect.top : yPosition;
        xPosition -= (xPosition + rectWidth) > clipRectWidth
            ? (xPosition + rectWidth) - clipRectWidth
            : 0;
        yPosition -= (yPosition + rectHeight) > clipRectHeight
            ? (yPosition + rectHeight) - clipRectHeight
            : 0;
      }
      if ((series._seriesType == 'bar' ||
              series._seriesType == 'stackedbar' ||
              ((series._seriesType == 'column' ||
                      series._seriesType == 'rangecolumn' ||
                      series._seriesType == 'stackedcolumn') &&
                  chart.isTransposed)) &&
          dataLabel.labelAlignment == ChartDataLabelAlignment.auto &&
          rectWidth > 10) {
        xPosition = xPosition - 5;
      }

      Rect rect2;
      double xPosition2, yPosition2, rectWidth2, rectHeight2;

      if (series._seriesType == 'rangecolumn') {
        rect2 = _calculateRect(chartLocation2, textSize2);
        xPosition2 = rect2.left;
        yPosition2 = rect2.top;
        rectWidth2 = rect2.width;
        rectHeight2 = rect2.height;
        currentPoint.dataLabelRegion2 = Rect.fromLTWH(
            xPosition2, yPosition2, textSize2.width, textSize2.height);
        if (xPosition2 + rectWidth2 > clipRectWidth) {
          xPosition2 = currentPoint.region.right - rectWidth2 - padding;
        }
        if (yPosition2 + rectHeight2 > clipRectHeight) {
          yPosition2 = clipRectHeight - rectHeight2 / 2 - padding;
        }
        if (chart.isTransposed &&
            dataLabel.labelAlignment == ChartDataLabelAlignment.auto &&
            rectWidth2 > 10) {
          xPosition2 = xPosition2 - 5;
        }
      }

      if (dataLabel.color != null ||
          dataLabel.useSeriesColor ||
          (dataLabel.borderColor != null && dataLabel.borderWidth > 0)) {
        final RRect rectRegion = _calculateFillRect(xPosition, yPosition,
            rectWidth, rectHeight, dataLabel, textSize, clipRect)[0];
        final RRect fillRect = _calculateFillRect(xPosition, yPosition,
            rectWidth, rectHeight, dataLabel, textSize, clipRect)[1];
        currentPoint.labelLocation = _ChartLocation(
            fillRect.center.dx - textSize.width / 2,
            fillRect.center.dy - textSize.height / 2);
        currentPoint.dataLabelRegion = Rect.fromLTWH(
            currentPoint.labelLocation.x,
            currentPoint.labelLocation.y,
            textSize.width,
            textSize.height);
        if (margin == const EdgeInsets.all(0)) {
          currentPoint.labelFillRect = fillRect;
        } else {
          final Rect rect =
              _calculateRects(fillRect, rectRegion, margin, clipRect)[0];
          final Rect _rect =
              _calculateRects(fillRect, rectRegion, margin, clipRect)[1];
          currentPoint.labelLocation = _ChartLocation(
              _rect.left + rect.width / 2 - textSize.width / 2,
              _rect.top + rect.height / 2 - textSize.height / 2);
          currentPoint.dataLabelRegion = Rect.fromLTWH(
              currentPoint.labelLocation.x,
              currentPoint.labelLocation.y,
              textSize.width,
              textSize.height);
          currentPoint.labelFillRect = RRect.fromRectAndCorners(_rect,
              topLeft: Radius.elliptical(
                  dataLabel.borderRadius, dataLabel.borderRadius),
              topRight: Radius.elliptical(
                  dataLabel.borderRadius, dataLabel.borderRadius),
              bottomLeft: Radius.elliptical(
                  dataLabel.borderRadius, dataLabel.borderRadius),
              bottomRight: Radius.elliptical(
                  dataLabel.borderRadius, dataLabel.borderRadius));
        }
        if (series._seriesType == 'rangecolumn') {
          final RRect rectRegion2 = _calculateFillRect(xPosition2, yPosition2,
              rectWidth2, rectHeight2, dataLabel, textSize2, clipRect)[0];
          final RRect fillRect2 = _calculateFillRect(xPosition2, yPosition2,
              rectWidth2, rectHeight2, dataLabel, textSize2, clipRect)[1];
          currentPoint.labelLocation2 = _ChartLocation(
              fillRect2.center.dx - textSize2.width / 2,
              fillRect2.center.dy - textSize2.height / 2);
          currentPoint.dataLabelRegion2 = Rect.fromLTWH(
              currentPoint.labelLocation2.x,
              currentPoint.labelLocation2.y,
              textSize2.width,
              textSize2.height);
          if (margin == const EdgeInsets.all(0)) {
            currentPoint.labelFillRect2 = fillRect2;
          } else {
            final Rect rect2 =
                _calculateRects(fillRect2, rectRegion2, margin, clipRect)[0];
            final Rect _rect2 =
                _calculateRects(fillRect2, rectRegion2, margin, clipRect)[1];
            currentPoint.labelLocation2 = _ChartLocation(
                _rect2.left + rect2.width / 2 - textSize2.width / 2,
                _rect2.top + rect2.height / 2 - textSize2.height / 2);
            currentPoint.dataLabelRegion2 = Rect.fromLTWH(
                currentPoint.labelLocation2.x,
                currentPoint.labelLocation2.y,
                textSize2.width,
                textSize2.height);
            currentPoint.labelFillRect2 = RRect.fromRectAndCorners(_rect2,
                topLeft: Radius.elliptical(
                    dataLabel.borderRadius, dataLabel.borderRadius),
                topRight: Radius.elliptical(
                    dataLabel.borderRadius, dataLabel.borderRadius),
                bottomLeft: Radius.elliptical(
                    dataLabel.borderRadius, dataLabel.borderRadius),
                bottomRight: Radius.elliptical(
                    dataLabel.borderRadius, dataLabel.borderRadius));
          }
        }
      } else {
        yPosition = yPosition > clipRect.top
            ? yPosition
            : textSize.height / 2 + clipRect.top;
        currentPoint.labelLocation = _ChartLocation(xPosition, yPosition);
        if (series._seriesType == 'rangecolumn') {
          yPosition2 = yPosition2 > clipRect.top
              ? yPosition2
              : textSize2.height / 2 + clipRect.top;
          currentPoint.labelLocation2 = _ChartLocation(xPosition2, yPosition2);
        }
      }
    }
  }
}

/// Below method is for Rendering data label
void _drawDataLabel(
    Canvas canvas,
    CartesianSeries<dynamic, dynamic> series,
    SfCartesianChart chart,
    DataLabelSettings dataLabel,
    _CartesianChartPoint<dynamic> currentPoint,
    int index,
    Animation<double> dataLabelAnimation) {
  final double opacity =
      dataLabelAnimation != null ? dataLabelAnimation.value : 1;
  DataLabelRenderArgs dataLabelArgs;
  ChartTextStyle dataLabelStyle;
  String label = currentPoint.dataLabelMapper ?? currentPoint.label;
  final String label2 = currentPoint.dataLabelMapper ?? currentPoint.label2;
  dataLabelStyle = dataLabel.textStyle;
  if (chart.onDataLabelRender != null) {
    dataLabelArgs = DataLabelRenderArgs();
    dataLabelArgs.text = label;
    dataLabelArgs.textStyle = dataLabelStyle;
    dataLabelArgs.series = series;
    dataLabelArgs.dataPoints = series._dataPoints;
    dataLabelArgs.pointIndex = index;
    chart.onDataLabelRender(dataLabelArgs);
    label = currentPoint.label = dataLabelArgs.text;
    dataLabelStyle = dataLabelArgs.textStyle;
    index = dataLabelArgs.pointIndex;
  }
  if (label != null &&
      currentPoint != null &&
      currentPoint.isVisible &&
      currentPoint.isGap != true &&
      _isLabelWithinRange(series, currentPoint)) {
    final ChartTextStyle font =
        (dataLabel.textStyle == null) ? ChartTextStyle() : dataLabel.textStyle;
    final Color fontColor = font.color != null
        ? font.color
        : _getDataLabelSaturationColor(currentPoint, series, chart);
    final Rect labelRect = (currentPoint.labelFillRect != null)
        ? Rect.fromLTWH(
            currentPoint.labelFillRect.left,
            currentPoint.labelFillRect.top,
            currentPoint.labelFillRect.width,
            currentPoint.labelFillRect.height)
        : Rect.fromLTWH(
            currentPoint.labelLocation.x,
            currentPoint.labelLocation.y,
            currentPoint.dataLabelRegion.width,
            currentPoint.dataLabelRegion.height);

    final bool isDatalabelCollide =
        _isCollide(labelRect, chart._chartState.renderDatalabelRegions);
    if (label.isNotEmpty && isDatalabelCollide
        ? dataLabel.labelIntersectAction == LabelIntersectAction.none
        : true) {
      final ChartTextStyle textStyle = ChartTextStyle(
          color: fontColor.withOpacity(opacity),
          fontSize: font.fontSize,
          fontFamily: font.fontFamily,
          fontStyle: font.fontStyle,
          fontWeight: font.fontWeight);
      if (dataLabel.color != null ||
          dataLabel.useSeriesColor ||
          (dataLabel.borderColor != null && dataLabel.borderWidth > 0)) {
        final RRect fillRect = currentPoint.labelFillRect;
        final RRect fillRect2 = currentPoint.labelFillRect2;
        final Path path = Path();
        final Path path2 = Path();
        path.addRRect(fillRect);
        if (series._seriesType == 'rangecolumn') {
          path2.addRRect(fillRect2);
        }
        if (dataLabel.borderColor != null && dataLabel.borderWidth > 0) {
          final Paint strokePaint = Paint()
            ..color = dataLabel.borderColor.withOpacity(
                (opacity - (1 - dataLabel.opacity)) < 0
                    ? 0
                    : opacity - (1 - dataLabel.opacity))
            ..strokeWidth = dataLabel.borderWidth
            ..style = PaintingStyle.stroke;
          dataLabel.borderWidth == 0
              ? strokePaint.color = Colors.transparent
              : strokePaint.color = strokePaint.color;
          canvas.drawPath(path, strokePaint);
          if (series._seriesType == 'rangecolumn')
            canvas.drawPath(path2, strokePaint);
        }
        if (dataLabel.color != null || dataLabel.useSeriesColor) {
          final Paint paint = Paint()
            ..color = (dataLabel.color ??
                    (currentPoint.pointColorMapper ?? series._seriesColor))
                .withOpacity((opacity - (1 - dataLabel.opacity)) < 0
                    ? 0
                    : opacity - (1 - dataLabel.opacity))
            ..style = PaintingStyle.fill;
          canvas.drawPath(path, paint);
          if (series._seriesType == 'rangecolumn')
            canvas.drawPath(path2, paint);
        }
      }
      series.drawDataLabel(index, canvas, label, currentPoint.labelLocation.x,
          currentPoint.labelLocation.y, dataLabel.angle, textStyle);
      if (series._seriesType == 'rangecolumn') {
        series.drawDataLabel(
            index,
            canvas,
            label2,
            currentPoint.labelLocation2.x,
            currentPoint.labelLocation2.y,
            dataLabel.angle,
            textStyle);
      }
      chart._chartState.renderDatalabelRegions.add(labelRect);
    }
  }
}

bool _isLabelWithinRange(XyDataSeries<dynamic, dynamic> series,
    _CartesianChartPoint<dynamic> currentPoint) {
  bool _isLabelWithinRange = true;
  if (!(series._yAxis is LogarithmicAxis)) {
    _isLabelWithinRange = (series._seriesType == 'rangecolumn'
            ? (math.min<num>(currentPoint.high, currentPoint.low) >=
                    series._yAxis._visibleRange.minimum &&
                math.max<num>(currentPoint.high, currentPoint.low) <=
                    series._yAxis._visibleRange.maximum)
            : (currentPoint.y >= series._yAxis._visibleRange.minimum &&
                currentPoint.y <= series._yAxis._visibleRange.maximum)) &&
        currentPoint.xValue >= series._xAxis._visibleRange.minimum &&
        currentPoint.xValue <= series._xAxis._visibleRange.maximum;
  }
  return _isLabelWithinRange;
}

/// Calculating rect position for dataLabel
double _calculateRectPosition(
    double labelLocation,
    Rect rect,
    bool isMinus,
    ChartDataLabelAlignment position,
    CartesianSeries<dynamic, dynamic> series,
    Size textSize,
    double borderWidth,
    int index,
    _ChartLocation point,
    SfCartesianChart chart,
    bool inverted) {
  const double padding = 5;
  final double textLength = !inverted ? textSize.height : textSize.width;
  final double extraSpace = borderWidth + textLength / 2 + padding;

  /// Locating the data label based on position
  switch (position) {
    case ChartDataLabelAlignment.bottom:
      labelLocation = !inverted
          ? (series._yAxis.isInversed
              ? (isMinus
                  ? (labelLocation + rect.height - extraSpace)
                  : (labelLocation - rect.height + extraSpace))
              : (isMinus
                  ? (labelLocation - rect.height + extraSpace)
                  : (labelLocation + rect.height - extraSpace)))
          : (series._yAxis.isInversed
              ? (isMinus
                  ? rect.right - textLength
                  : (labelLocation - rect.width))
              : (isMinus
                  ? (labelLocation - rect.width)
                  : (labelLocation + rect.width / 2 - textLength / 2)));
      break;
    case ChartDataLabelAlignment.middle:
      labelLocation = labelLocation = !inverted
          ? (series._yAxis.isInversed
              ? (isMinus
                  ? labelLocation + (rect.height / 2)
                  : labelLocation - (rect.height / 2))
              : (isMinus
                  ? labelLocation - (rect.height / 2)
                  : labelLocation + (rect.height / 2)))
          : (series._yAxis.isInversed
              ? (isMinus
                  ? labelLocation + (rect.width / 2) - textLength
                  : labelLocation - (rect.width / 2) - textLength)
              : (isMinus
                  ? labelLocation - (rect.width / 2) - textLength
                  : labelLocation + textLength / 2));
      break;
    case ChartDataLabelAlignment.auto:
      labelLocation = _calculateRectActualPosition(
          labelLocation,
          rect,
          isMinus,
          series,
          textSize,
          index,
          point,
          inverted,
          borderWidth,
          chart,
          position);
      break;
    default:
      labelLocation = _calculateTopAndOuterPosition(
          textSize,
          labelLocation,
          rect,
          position,
          series,
          index,
          extraSpace,
          isMinus,
          point,
          inverted,
          borderWidth,
          chart);
      break;
  }
  return labelLocation;
}

double _calculateTopAndOuterPosition(
    Size textSize,
    double location,
    Rect rect,
    ChartDataLabelAlignment position,
    CartesianSeries<dynamic, dynamic> series,
    int index,
    double extraSpace,
    bool isMinus,
    _ChartLocation point,
    bool inverted,
    double borderWidth,
    SfCartesianChart chart) {
  final double padding = (position == ChartDataLabelAlignment.outer) ? 5 : 0;
  if ((isMinus && position == ChartDataLabelAlignment.top) ||
      (!isMinus && position == ChartDataLabelAlignment.outer)) {
    location = series._yAxis.isInversed
        ? (!inverted ? location + extraSpace - padding : location)
        : (!inverted
            ? location - extraSpace + padding
            : position == ChartDataLabelAlignment.outer
                ? rect.left - textSize.width
                : (location - extraSpace - textSize.width));
  } else {
    location = series._yAxis.isInversed
        ? (!inverted
            ? location - extraSpace + padding
            : location - extraSpace - textSize.width)
        : (!inverted
            ? location + extraSpace - padding
            : (position == ChartDataLabelAlignment.top
                ? rect.left + extraSpace
                : location));
  }
  return location;
}

double _calculateRectActualPosition(
    double labelLocation,
    Rect rect,
    bool minus,
    CartesianSeries<dynamic, dynamic> series,
    Size textSize,
    int index,
    _ChartLocation point,
    bool inverted,
    double borderWidth,
    SfCartesianChart chart,
    ChartDataLabelAlignment position) {
  double location;
  Rect labelRect;
  bool isOverLap = true;
  int positions = 0;
  int finalPosition = 2;

  if (series._seriesType == 'column' ||
      series._seriesType == 'rangecolumn' ||
      series._seriesType == 'scatter' ||
      series._seriesType == 'spline' ||
      series._seriesType == 'stepline' ||
      series._seriesType == 'bubble' ||
      series._seriesType == 'line' ||
      series._seriesType == 'bar') {
    finalPosition = 4;
  }
  while (isOverLap && positions < finalPosition) {
    location = _calculateRectPosition(
        labelLocation,
        rect,
        minus,
        _getPosition(positions),
        series,
        textSize,
        borderWidth,
        index,
        point,
        chart,
        inverted);
    if (!inverted) {
      labelRect = _calculateRect(_ChartLocation(point.x, location), textSize);
      isOverLap = labelRect.top < 0 ||
          labelRect.top > chart._chartAxis._axisClipRect.height;
    } else {
      labelRect = _calculateRect(_ChartLocation(location, point.y), textSize);
      isOverLap = labelRect.left < 0 ||
          labelRect.left + labelRect.width >
              chart._chartAxis._axisClipRect.width;
    }
    series._dataPoints[index].dataLabelSaturationRegionInside =
        isOverLap || series._dataPoints[index].dataLabelSaturationRegionInside
            ? true
            : false;
    positions++;
  }
  return location;
}

ChartDataLabelAlignment _getPosition(int position) {
  ChartDataLabelAlignment dataLabelPosition;
  switch (position) {
    case 0:
      dataLabelPosition = ChartDataLabelAlignment.outer;
      break;
    case 1:
      dataLabelPosition = ChartDataLabelAlignment.top;
      break;
    case 2:
      dataLabelPosition = ChartDataLabelAlignment.bottom;
      break;
    case 3:
      dataLabelPosition = ChartDataLabelAlignment.middle;
      break;
    case 4:
      dataLabelPosition = ChartDataLabelAlignment.auto;
      break;
  }
  return dataLabelPosition;
}

double _calculatePathPosition(
    double labelLocation,
    ChartDataLabelAlignment position,
    Size size,
    double borderWidth,
    CartesianSeries<dynamic, dynamic> series,
    int index,
    bool inverted,
    _ChartLocation point,
    SfCartesianChart chart,
    _CartesianChartPoint<dynamic> currentPoint) {
  const double padding = 5;
  switch (position) {
    case ChartDataLabelAlignment.top:
    case ChartDataLabelAlignment.outer:
      labelLocation = (series._seriesType == 'bubble')
          ? labelLocation -
              (borderWidth * 2) -
              size.height -
              -currentPoint.region.height -
              series.markerSettings.height
          : labelLocation - borderWidth - size.height / 2 - padding;
      break;
    case ChartDataLabelAlignment.bottom:
      labelLocation = (series._seriesType == 'bubble')
          ? labelLocation +
              (borderWidth * 2) +
              size.height +
              currentPoint.region.height +
              series.markerSettings.height
          : labelLocation + borderWidth + size.height / 2 + padding;
      break;
    case ChartDataLabelAlignment.auto:
      labelLocation = _calculatePathActualPosition(
          labelLocation,
          series,
          series._dataPoints,
          size,
          index,
          inverted,
          borderWidth,
          point,
          chart,
          currentPoint);
      break;
    case ChartDataLabelAlignment.middle:
      break;
  }
  return labelLocation;
}

double _calculatePathActualPosition(
    double labelLocation,
    CartesianSeries<dynamic, dynamic> series,
    List<_CartesianChartPoint<dynamic>> dataPoints,
    Size size,
    int index,
    bool inverted,
    double borderWidth,
    _ChartLocation point,
    SfCartesianChart chart,
    _CartesianChartPoint<dynamic> currentPoint) {
  final List<_CartesianChartPoint<dynamic>> points = series._dataPoints;
  final num yValue = points[index].yValue;
  ChartDataLabelAlignment position;
  final _CartesianChartPoint<dynamic> nextPoint =
      points.length - 1 > index ? points[index + 1] : null;
  final _CartesianChartPoint<dynamic> previousPoint =
      index > 0 ? points[index - 1] : null;
  double yLocation;
  bool isOverLap = true;
  Rect labelRect;
  bool isBottom;
  int positionIndex;

  if (series._seriesType == 'bubble' || index == points.length - 1) {
    position = ChartDataLabelAlignment.top;
  } else {
    if (index == 0) {
      position = ((nextPoint != null) ||
              yValue > nextPoint.yValue ||
              (yValue < nextPoint.yValue && inverted))
          ? ChartDataLabelAlignment.top
          : ChartDataLabelAlignment.bottom;
    } else if (index == points.length - 1) {
      position = ((previousPoint == null) ||
              yValue > previousPoint.yValue ||
              (yValue < previousPoint.yValue && inverted))
          ? ChartDataLabelAlignment.top
          : ChartDataLabelAlignment.bottom;
    } else {
      if (!series.dataLabelSettings.isVisible && previousPoint != null) {
        position = ChartDataLabelAlignment.top;
      } else if (previousPoint != null) {
        position =
            (nextPoint.yValue > yValue || (previousPoint.yValue > yValue))
                ? ChartDataLabelAlignment.bottom
                : ChartDataLabelAlignment.top;
      } else {
        final num slope = (nextPoint.yValue - previousPoint.yValue) / 2;
        final num intersectY =
            (slope * index) + (nextPoint.yValue - (slope * (index + 1)));
        position = !inverted
            ? intersectY < yValue
                ? ChartDataLabelAlignment.top
                : ChartDataLabelAlignment.bottom
            : intersectY < yValue
                ? ChartDataLabelAlignment.bottom
                : ChartDataLabelAlignment.top;
      }
    }
  }
  isBottom = position == ChartDataLabelAlignment.bottom;
  final List<String> dataLabelPosition = List<String>(5);
  dataLabelPosition[0] = 'DataLabelPosition.Outer';
  dataLabelPosition[1] = 'DataLabelPosition.Top';
  dataLabelPosition[2] = 'DataLabelPosition.Bottom';
  dataLabelPosition[3] = 'DataLabelPosition.Middle';
  dataLabelPosition[4] = 'DataLabelPosition.Auto';
  positionIndex = dataLabelPosition.indexOf(position.toString()).toInt();
  if (isOverLap && positionIndex < 4) {
    yLocation = _calculatePathPosition(point.y.toDouble(), position, size,
        borderWidth, series, index, inverted, point, chart, currentPoint);
    labelRect = _calculateRect(_ChartLocation(point.x, yLocation), size);
    isOverLap = labelRect.top < 0 ||
        (labelRect.top + labelRect.height) >
            chart._chartAxis._axisClipRect.height;
    positionIndex = isBottom ? positionIndex - 1 : positionIndex + 1;
    isBottom = false;
  }
  return yLocation;
}

double _calculateAlignment(double value, double labelLocation,
    ChartAlignment alignment, bool isMinus, bool inverted,
    [_CartesianChartPoint<dynamic> point]) {
  switch (alignment) {
    case ChartAlignment.far:
      labelLocation = !inverted
          ? (isMinus ? labelLocation - value : labelLocation + value)
          : (isMinus ? labelLocation + value : labelLocation - value);
      break;
    case ChartAlignment.near:
      labelLocation = !inverted
          ? (isMinus ? labelLocation + value : labelLocation - value)
          : (isMinus ? labelLocation - value : labelLocation + value);
      break;
    case ChartAlignment.center:
      labelLocation = labelLocation;
      break;
  }
  return labelLocation;
}

Rect _calculateRect(_ChartLocation location, Size textSize) => Rect.fromLTWH(
    location.x - (textSize.width / 2),
    location.y - (textSize.height / 2),
    textSize.width,
    textSize.height);

/// Following method returns the data label text
String _getLabelText(dynamic labelValue,
    CartesianSeries<dynamic, dynamic> series, SfCartesianChart chart) {
  if (labelValue is double) {
    final String str = labelValue.toString();
    final List<dynamic> list = str.split('.');
    labelValue = double.parse(labelValue.toStringAsFixed(6));
    if (list[1] == '0' ||
        list[1] == '00' ||
        list[1] == '000' ||
        list[1] == '0000' ||
        list[1] == '00000' ||
        list[1] == '000000') {
      labelValue = labelValue.round();
    }
  }
  final dynamic yAxis = series._yAxis;
  final dynamic value = yAxis.numberFormat != null
      ? yAxis.numberFormat.format(labelValue)
      : labelValue;
  return (yAxis.labelFormat != null && yAxis.labelFormat != '')
      ? yAxis.labelFormat.replaceAll(RegExp('{value}'), value.toString())
      : value.toString();
}

List<RRect> _calculateFillRect(
    double xPosition,
    double yPosition,
    double rectWidth,
    double rectHeight,
    DataLabelSettings dataLabel,
    Size textSize,
    Rect clipRect) {
  Rect paddedRect;
  const double padding = 10;
  paddedRect = Rect.fromLTWH(xPosition, yPosition, rectWidth, rectHeight);
  final RRect rectRegion = RRect.fromRectAndCorners(paddedRect,
      topLeft:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      topRight:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      bottomLeft:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      bottomRight:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius));

  double left = xPosition;
  final double width = textSize.width;
  final double height = textSize.height;
  double top = yPosition;
  double bottom;

  if (!((top > clipRect.bottom) ||
      (left > clipRect.right) ||
      (left + rectRegion.width < 0) ||
      (top + rectRegion.height < 0))) {
    left = left <= clipRect.left ? clipRect.left + padding : left;
    top = top <= clipRect.top ? clipRect.top + padding : top;
    left -= (left + width) >= clipRect.right
        ? (left + width) - clipRect.right + padding
        : 0;
    top -= (top + height) >= clipRect.bottom
        ? (top + height) - clipRect.bottom + padding
        : 0;
  }
  if ((top - padding / 2 + height + padding) >= clipRect.bottom) {
    bottom = top - padding / 2 + height;
    top -= padding;
  } else {
    bottom = top - padding / 2 + height + padding;
  }
  final RRect fillRect = RRect.fromRectAndCorners(
      Rect.fromLTRB(left - padding / 2, top - padding / 2,
          left + width - padding / 2 + padding, bottom),
      topLeft:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      topRight:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      bottomLeft:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius),
      bottomRight:
          Radius.elliptical(dataLabel.borderRadius, dataLabel.borderRadius));
  return <RRect>[rectRegion, fillRect];
}

List<Rect> _calculateRects(
    RRect fillRect, RRect rectRegion, EdgeInsets margin, Rect clipRect) {
  double left, top, width, height;
  const double padding = 10;
  final Rect rect = Rect.fromLTRB(
      fillRect.left - margin.left,
      fillRect.top - margin.top,
      fillRect.right + margin.right,
      fillRect.bottom + margin.bottom);
  left = rect.left;
  top = rect.top;
  width = rect.width;
  height = rect.height;
  if (!((top > clipRect.bottom) ||
      (left > clipRect.right) ||
      (left + rectRegion.width < 0) ||
      (top + rectRegion.height < 0))) {
    left = left < clipRect.left ? clipRect.left : left;
    top = top < clipRect.top ? clipRect.top + padding : top;
    left -= (left + width) > clipRect.right
        ? (left + width) - clipRect.right + padding
        : 0;
    top -= (top + height) > clipRect.bottom
        ? (top + height) - clipRect.bottom + padding
        : 0;
  }
  return <Rect>[rect, Rect.fromLTWH(left, top, width, height)];
}
