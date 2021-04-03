part of flutter_charts;

class _CustomPaintStyle {
  _CustomPaintStyle(this.strokeWidth, this.color, this.paintStyle);
  Color color;
  double strokeWidth;
  PaintingStyle paintStyle;
}

class _AxisSize {
  _AxisSize(this.axis, this.size);
  num size;
  ChartAxis axis;
}

/// Customizes the interactive tooltip.
class InteractiveTooltip {
  InteractiveTooltip(
      {this.enable = true,
      this.color,
      this.borderColor,
      this.borderWidth = 0,
      this.borderRadius = 5,
      this.arrowLength = 7,
      this.arrowWidth = 5,
      this.format,
      this.connectorLineColor,
      this.connectorLineWidth = 1.5,
      this.connectorLineDashArray,
      this.decimalPlaces = 3,
      ChartTextStyle textStyle})
      : textStyle = textStyle ?? ChartTextStyle();

  ///Toggles the visibility of the interactive tooltip in an axis. This tooltip will be displayed at the axis for crosshair and will be displayed near to the track line for trackball.
  ///
  ///Defaults to true
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(enable:false)),
  ///        ));
  ///}
  ///```
  final bool enable;

  ///Color of the interactive tooltip.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             color:Colors.grey)),
  ///        ));
  ///}
  ///```
  final Color color;

  ///Border color of the interactive tooltip.
  ///
  ///Defaults to Colors.black
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:2)),
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the interactive tooltip.
  ///
  ///Defaults to 0.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:2)),
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Customizes the text in the interactive tooltip.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             textStyle: ChartTextStyle(color:Colors.red))),
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Customizes the corners of the interactive tooltip. Each corner can be customized
  ///with a desired value or with a single value.
  ///
  ///Defaults to Radius.zero
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             borderColor:Colors.white,
  ///             borderWidth:3,
  ///             borderRadius:2)),
  ///        ));
  ///}
  ///```
  final double borderRadius;

  ///Length of the tooltip arrow.
  ///
  ///Defaults to 7
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             arrowLength:4)),
  ///        ));
  ///}
  ///```
  final double arrowLength;

  ///Width of the tooltip arrow.
  ///
  ///Defaults to 5
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             arrowWidth:4)),
  ///        ));
  ///}
  ///```
  final double arrowWidth;

  ///Text format of the interactive tooltip.
  ///
  /// By default, axis value will be displayed in the tooltip, and it can be customized by
  /// adding desired text as prefix or suffix.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true,
  ///           tooltipSettings: InteractiveTooltip(
  ///             format:'point.x %')),
  ///        ));
  ///}
  ///```
  final String format;

  ///Width of the selection zooming tooltip connector line.
  ///
  ///Defaults to 1.5
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(connectorLineWidth:2)),
  ///        ));
  ///}
  ///```
  final double connectorLineWidth;

  ///Color of the selection zooming tooltip connector line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(connectorLineColor:Colors.red)),
  ///        ));
  ///}
  ///```
  final Color connectorLineColor;

  ///Giving dasharray to the selection zooming tooltip connector line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(connectorLineDashArray:[2,3])),
  ///        ));
  ///}
  ///```
  final List<double> connectorLineDashArray;

  ///Rounding decimal places of the selection zooming tooltip or trackball tooltip label.
  ///
  ///Defaults to 3
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(decimalPlaces:4)),
  ///        ));
  ///}
  ///```
  final int decimalPlaces;
}

class _StackedValues {
  _StackedValues(this.startValues, this.endValues);
  List<double> startValues;
  List<double> endValues;
}

class _ClusterStackedItemInfo {
  _ClusterStackedItemInfo(this.stackName, this.stackedItemInfo);
  String stackName;
  List<_StackedItemInfo> stackedItemInfo;
}

class _StackedItemInfo {
  _StackedItemInfo(this.seriesIndex, this.series);
  int seriesIndex;
  _StackedSeriesBase<dynamic, dynamic> series;
}

/// To get cartesian type data label saturation color
Color _getDataLabelSaturationColor(_CartesianChartPoint<dynamic> currentPoint,
    XyDataSeries<dynamic, dynamic> series, SfCartesianChart chart) {
  Color color;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final ChartDataLabelAlignment labelPosition =
      (series._seriesType == 'rangecolumn' &&
              (dataLabel.labelAlignment == ChartDataLabelAlignment.bottom ||
                  dataLabel.labelAlignment == ChartDataLabelAlignment.middle))
          ? ChartDataLabelAlignment.auto
          : dataLabel.labelAlignment;
  final ChartAlignment alignment = dataLabel.alignment;
  final String _seriesType = series._seriesType == 'line' ||
          series._seriesType == 'stackedline' ||
          series._seriesType == 'spline' ||
          series._seriesType == 'stepline'
      ? 'Line'
      : series._isRectSeries
          ? 'Column'
          : series._seriesType == 'bubble' || series._seriesType == 'scatter'
              ? 'Circle'
              : series._seriesType == 'area' ||
                      series._seriesType == 'stackedarea'
                  ? 'area'
                  : 'Default';
  if (dataLabel.useSeriesColor || dataLabel.color != null) {
    color = dataLabel.color ??
        (currentPoint.pointColorMapper ?? series._seriesColor);
  } else {
    switch (_seriesType) {
      case 'Line':
        color = _getOuterDataLabelColor(
            dataLabel, chart.plotAreaBackgroundColor, chart._chartTheme);
        break;
      case 'Column':
        color = (!currentPoint.dataLabelSaturationRegionInside &&
                ((labelPosition == ChartDataLabelAlignment.outer &&
                        alignment != ChartAlignment.near) ||
                    (labelPosition == ChartDataLabelAlignment.top &&
                        alignment == ChartAlignment.far) ||
                    labelPosition == ChartDataLabelAlignment.auto))
            ? _getOuterDataLabelColor(
                dataLabel, chart.plotAreaBackgroundColor, chart._chartTheme)
            : _getInnerDataLabelColor(currentPoint, series, chart._chartTheme);
        break;
      case 'Circle':
        color = (labelPosition == ChartDataLabelAlignment.middle &&
                    alignment == ChartAlignment.center ||
                labelPosition == ChartDataLabelAlignment.bottom &&
                    alignment == ChartAlignment.far ||
                labelPosition == ChartDataLabelAlignment.top &&
                    alignment == ChartAlignment.near ||
                labelPosition == ChartDataLabelAlignment.outer &&
                    alignment == ChartAlignment.near)
            ? _getInnerDataLabelColor(currentPoint, series, chart._chartTheme)
            : _getOuterDataLabelColor(
                dataLabel, chart.plotAreaBackgroundColor, chart._chartTheme);
        break;

      case 'area':
        color = (!currentPoint.dataLabelSaturationRegionInside &&
                currentPoint.labelLocation.y < currentPoint.markerPoint.y)
            ? _getOuterDataLabelColor(
                dataLabel, chart.plotAreaBackgroundColor, chart._chartTheme)
            : _getInnerDataLabelColor(currentPoint, series, chart._chartTheme);
        break;

      default:
        color = Colors.white;
    }
  }
  return _getSaturationColor(color);
}

/// To get outer data label color
Color _getOuterDataLabelColor(DataLabelSettings dataLabel,
        Color backgroundColor, _ChartTheme theme) =>
    dataLabel.color != null
        ? dataLabel.color
        : backgroundColor != null
            ? backgroundColor
            : theme.brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 1)
                : Colors.black;

///To get inner data label
Color _getInnerDataLabelColor(_CartesianChartPoint<dynamic> currentPoint,
    CartesianSeries<dynamic, dynamic> series, _ChartTheme theme) {
  Color innerColor;
  final dynamic dataLabel = series.dataLabelSettings;
  innerColor = dataLabel.color != null
      ? dataLabel.color
      : currentPoint.pointColorMapper != null
          ? currentPoint.pointColorMapper
          : series.color != null
              ? series.color
              : series._seriesColor != null
                  ? series._seriesColor
                  : theme.brightness == Brightness.light
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : Colors.black;
  return innerColor;
}

/// To animate column and bar series
void _animateRectSeries(
    Canvas canvas,
    XyDataSeries<dynamic, dynamic> series,
    Paint fillPaint,
    RRect segmentRect,
    num yPoint,
    double animationFactor,
    Rect oldSegmentRect,
    num oldYValue,
    bool oldSeriesVisible) {
  final bool comparePrev = series._chart._chartState.widgetNeedUpdate &&
      oldYValue != null &&
      oldSegmentRect != null;
  final bool isLargePrev = oldYValue != null ? oldYValue > yPoint : false;
  final bool isSingleSeries = series._chart._chartState._isLegendToggled
      ? _checkSingleSeries(series)
      : false;
  if ((series._seriesType == 'column' && series._chart.isTransposed) ||
      (series._seriesType == 'bar' && !series._chart.isTransposed)) {
    double width = segmentRect.width;
    double height = segmentRect.height;
    double top = segmentRect.top;
    double left = segmentRect.left, right = segmentRect.right;
    if (!series._chart._chartState._isLegendToggled) {
      width = segmentRect.width * animationFactor;
      if (!series._yAxis.isInversed) {
        if (comparePrev) {
          if (yPoint < 0) {
            left = isLargePrev
                ? oldSegmentRect.left -
                    (animationFactor * (oldSegmentRect.left - segmentRect.left))
                : oldSegmentRect.left +
                    (animationFactor *
                        (segmentRect.left - oldSegmentRect.left));
            right = segmentRect.right;
            width = right - left;
          } else {
            right = isLargePrev
                ? oldSegmentRect.right +
                    (animationFactor *
                        (segmentRect.right - oldSegmentRect.right))
                : oldSegmentRect.right -
                    (animationFactor *
                        (oldSegmentRect.right - segmentRect.right));
            width = right - segmentRect.left;
          }
        } else {
          right = yPoint < 0
              ? segmentRect.right
              : (segmentRect.right - segmentRect.width) + width;
        }
      } else {
        if (comparePrev) {
          if (yPoint < 0) {
            right = isLargePrev
                ? oldSegmentRect.right +
                    (animationFactor *
                        (segmentRect.right - oldSegmentRect.right))
                : oldSegmentRect.right -
                    (animationFactor *
                        (oldSegmentRect.right - segmentRect.right));
            width = right - segmentRect.left;
          } else {
            left = isLargePrev
                ? oldSegmentRect.left -
                    (animationFactor * (oldSegmentRect.left - segmentRect.left))
                : oldSegmentRect.left +
                    (animationFactor *
                        (segmentRect.left - oldSegmentRect.left));
            right = segmentRect.right;
            width = right - left;
          }
        } else {
          right = yPoint < 0
              ? (segmentRect.right - segmentRect.width) + width
              : segmentRect.right;
        }
      }
    } else if (series._chart._chartState._isLegendToggled &&
        oldSegmentRect != null) {
      num bottom;
      if (oldSeriesVisible != null && oldSeriesVisible) {
        bottom = oldSegmentRect.bottom > segmentRect.bottom
            ? oldSegmentRect.bottom +
                (animationFactor * (segmentRect.bottom - oldSegmentRect.bottom))
            : oldSegmentRect.bottom -
                (animationFactor *
                    (oldSegmentRect.bottom - segmentRect.bottom));
        top = oldSegmentRect.top > segmentRect.top
            ? oldSegmentRect.top -
                (animationFactor * (oldSegmentRect.top - segmentRect.top))
            : oldSegmentRect.top +
                (animationFactor * (segmentRect.top - oldSegmentRect.top));
        height = bottom - top;
      } else {
        if (series == series._chart.series[0] && !isSingleSeries) {
          bottom = segmentRect.bottom;
          top = bottom - (segmentRect.height * animationFactor);
          height = bottom - top;
        } else if (series ==
                series._chart.series[series._chart.series.length - 1] &&
            !isSingleSeries) {
          top = segmentRect.top;
          height = segmentRect.height * animationFactor;
        } else {
          height = segmentRect.height * animationFactor;
          top = segmentRect.center.dy - height / 2;
        }
      }
      right = segmentRect.right;
    }
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(right - width, top, width, height),
            segmentRect.blRadius),
        fillPaint);
  } else {
    double height = segmentRect.height;
    double width = segmentRect.width;
    double left = segmentRect.left;
    double top = segmentRect.top, bottom;
    if (!series._chart._chartState._isLegendToggled) {
      height = segmentRect.height * animationFactor;
      if (!series._yAxis.isInversed) {
        if (comparePrev) {
          if (yPoint < 0) {
            bottom = isLargePrev
                ? oldSegmentRect.bottom -
                    (animationFactor *
                        (oldSegmentRect.bottom - segmentRect.bottom))
                : oldSegmentRect.bottom +
                    (animationFactor *
                        (segmentRect.bottom - oldSegmentRect.bottom));
            height = bottom - top;
          } else {
            top = isLargePrev
                ? oldSegmentRect.top +
                    (animationFactor * (segmentRect.top - oldSegmentRect.top))
                : oldSegmentRect.top -
                    (animationFactor * (oldSegmentRect.top - segmentRect.top));
            height = segmentRect.bottom - top;
          }
        } else {
          top = yPoint < 0
              ? segmentRect.top
              : (segmentRect.top + segmentRect.height) - height;
        }
      } else {
        if (comparePrev) {
          if (yPoint < 0) {
            top = isLargePrev
                ? oldSegmentRect.top +
                    (animationFactor * (segmentRect.top - oldSegmentRect.top))
                : oldSegmentRect.top -
                    (animationFactor * (oldSegmentRect.top - segmentRect.top));
            height = segmentRect.bottom - top;
          } else {
            bottom = isLargePrev
                ? oldSegmentRect.bottom -
                    (animationFactor *
                        (oldSegmentRect.bottom - segmentRect.bottom))
                : oldSegmentRect.bottom +
                    (animationFactor *
                        (segmentRect.bottom - oldSegmentRect.bottom));
            height = bottom - top;
          }
        } else {
          top = yPoint < 0
              ? (segmentRect.top + segmentRect.height) - height
              : segmentRect.top;
        }
      }
    } else if (series._chart._chartState._isLegendToggled &&
        oldSegmentRect != null &&
        oldSeriesVisible != null) {
      num right;
      if (oldSeriesVisible) {
        right = oldSegmentRect.right > segmentRect.right
            ? oldSegmentRect.right +
                (animationFactor * (segmentRect.right - oldSegmentRect.right))
            : oldSegmentRect.right -
                (animationFactor * (oldSegmentRect.right - segmentRect.right));
        left = oldSegmentRect.left > segmentRect.left
            ? oldSegmentRect.left -
                (animationFactor * (oldSegmentRect.left - segmentRect.left))
            : oldSegmentRect.left +
                (animationFactor * (segmentRect.left - oldSegmentRect.left));
        width = right - left;
      } else {
        if (series == series._chart.series[0] && !isSingleSeries) {
          left = segmentRect.left;
          width = segmentRect.width * animationFactor;
        } else if (series ==
                series._chart.series[series._chart.series.length - 1] &&
            !isSingleSeries) {
          right = segmentRect.right;
          left = right - (segmentRect.width * animationFactor);
          width = right - left;
        } else {
          width = segmentRect.width * animationFactor;
          left = segmentRect.center.dx - width / 2;
        }
      }
    }
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(left, top, width, height), segmentRect.blRadius),
        fillPaint);
  }
}

void _animateStackedRectSeries(
    Canvas canvas,
    RRect segmentRect,
    Paint fillPaint,
    _StackedSeriesBase<dynamic, dynamic> series,
    double animationFactor,
    _CartesianChartPoint<dynamic> currentPoint,
    SfCartesianChart chart) {
  final double animationValue = animationFactor;
  int index, seriesIndex;
  List<CartesianSeries<dynamic, dynamic>> seriesCollection;
  Rect prevRegion;
  double top = segmentRect.top, height = segmentRect.height;
  double right = segmentRect.right, width = segmentRect.width;
  final double height1 = segmentRect.height, top1 = segmentRect.top;
  index = series._dataPoints.indexOf(currentPoint);
  seriesCollection = _findSeriesCollection(chart);
  seriesIndex = seriesCollection.indexOf(series);
  height = segmentRect.height * animationValue;
  width = segmentRect.width * animationValue;
  bool isStackLine = false;
  if (seriesIndex != 0) {
    if (series._chart._chartSeries.visibleSeries[seriesIndex - 1]
        is StackedLineSeries) {
      isStackLine = true;
    }
    if (!isStackLine) {
      for (int j = 0;
          j < chart._chartSeries.clusterStackedItemInfo.length;
          j++) {
        final _ClusterStackedItemInfo clusterStackedItemInfo =
            chart._chartSeries.clusterStackedItemInfo[j];
        if (clusterStackedItemInfo.stackName == series.groupName) {
          if (clusterStackedItemInfo.stackedItemInfo.length >= 2) {
            for (int k = 0;
                k < clusterStackedItemInfo.stackedItemInfo.length;
                k++) {
              final _StackedItemInfo stackedItemInfo =
                  clusterStackedItemInfo.stackedItemInfo[k];
              if (stackedItemInfo.seriesIndex == seriesIndex &&
                  k != 0 &&
                  index <
                      clusterStackedItemInfo
                          .stackedItemInfo[k - 1].series._dataPoints.length) {
                if ((currentPoint.yValue > 0 &&
                        clusterStackedItemInfo.stackedItemInfo[k - 1].series
                                ._dataPoints[index].yValue >
                            0) ||
                    (currentPoint.yValue < 0 &&
                        clusterStackedItemInfo.stackedItemInfo[k - 1].series
                                ._dataPoints[index].yValue <
                            0)) {
                  prevRegion = clusterStackedItemInfo
                      .stackedItemInfo[k - 1].series._dataPoints[index].region;
                } else {
                  if (k > 1)
                    prevRegion = clusterStackedItemInfo
                        .stackedItemInfo[(k - 1) - 1]
                        .series
                        ._dataPoints[index]
                        .region;
                }
              }
            }
          }
        }
      }
    }
  }

  if (series._seriesType == 'stackedcolumn' &&
          series._chart.isTransposed != true ||
      series._seriesType == 'stackedbar' &&
          series._chart.isTransposed == true) {
    series._yAxis.isInversed != true
        ? series._dataPoints[index].y > 0
            ? prevRegion == null
                ? top = (segmentRect.top + segmentRect.height) - height
                : top = prevRegion.top - height
            : prevRegion == null
                ? top = segmentRect.top
                : top = prevRegion.bottom
        : series._dataPoints[index].y > 0
            ? prevRegion == null
                ? top = segmentRect.top
                : top = prevRegion.bottom
            : prevRegion == null
                ? top = (segmentRect.top + segmentRect.height) - height
                : top = prevRegion.top - height;

    segmentRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(segmentRect.left, top, segmentRect.width, height),
        segmentRect.blRadius);
    currentPoint.region =
        Rect.fromLTWH(segmentRect.left, top, segmentRect.width, height);
    canvas.drawRRect(segmentRect, fillPaint);
  } else if (series._seriesType == 'stackedcolumn' &&
          series._chart.isTransposed == true ||
      series._seriesType == 'stackedbar' &&
          series._chart.isTransposed != true) {
    series._yAxis.isInversed != true
        ? series._dataPoints[index].y > 0
            ? prevRegion == null
                ? right = (segmentRect.right - segmentRect.width) + width
                : right = prevRegion.right + width
            : prevRegion == null
                ? right = segmentRect.right
                : right = prevRegion.left
        : series._dataPoints[index].y > 0
            ? prevRegion == null
                ? right = segmentRect.right
                : right = prevRegion.left
            : prevRegion == null
                ? right = (segmentRect.right - segmentRect.width) + width
                : right = prevRegion.right + width;

    segmentRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(right - width, top1, width, height1),
        segmentRect.blRadius);
    currentPoint.region =
        Rect.fromLTWH(segmentRect.left, right, segmentRect.width, width);
    canvas.drawRRect(segmentRect, fillPaint);
  }
}

bool _checkSingleSeries(XyDataSeries<dynamic, dynamic> series) {
  int count = 0;
  for (int i = 0; i < series._chart.series.length; i++) {
    if (series._chart.series[i]._visible) {
      count++;
    }
  }
  return count == 1 ? true : false;
}

// to animate dynamic upadte in line, spline, stepline series
void _animateLineTypeSeries(
    Canvas canvas,
    XyDataSeries<dynamic, dynamic> series,
    Paint strokePaint,
    double animationFactor,
    num newX1,
    num newY1,
    num newX2,
    num newY2,
    num oldX1,
    num oldY1,
    num oldX2,
    num oldY2,
    [num newX3,
    num newY3,
    num oldX3,
    num oldY3,
    num newX4,
    num newY4,
    num oldX4,
    num oldY4]) {
  num x1 = newX1;
  num y1 = newY1;
  num x2 = newX2;
  num y2 = newY2;
  num x3 = newX3;
  num y3 = newY3;
  num x4 = newX4;
  num y4 = newY4;
  if (!series._chart.isTransposed) {
    y1 = _getValue(animationFactor, y1, oldY1, newY1);
    y2 = _getValue(animationFactor, y2, oldY2, newY2);
    y3 = _getValue(animationFactor, y3, oldY3, newY3);
    y4 = _getValue(animationFactor, y4, oldY4, newY4);
  } else {
    x1 = _getValue(animationFactor, x1, oldX1, newX1);
    x2 = _getValue(animationFactor, x2, oldX2, newX2);
    x3 = _getValue(animationFactor, x3, oldX3, newX3);
    x4 = _getValue(animationFactor, x4, oldX4, newX4);
  }

  final Path path = Path();
  path.moveTo(x1, y1);
  if (series._seriesType == 'stepline') {
    path.lineTo(x3, y3);
  }
  series._seriesType == 'spline'
      ? path.cubicTo(x3, y3, x4, y4, x2, y2)
      : path.lineTo(x2, y2);
  _drawDashedLine(canvas, series, strokePaint, path);
}

num _getValue(
        double animationFactor, double value, num oldvalue, num newValue) =>
    (oldvalue != null && newValue != null)
        ? ((oldvalue > newValue)
            ? oldvalue - ((oldvalue - newValue) * animationFactor)
            : oldvalue + ((newValue - oldvalue) * animationFactor))
        : value;

// To animate scatter series
void _animateScatterSeries(
    CartesianSeries<dynamic, dynamic> series,
    _CartesianChartPoint<dynamic> point,
    _CartesianChartPoint<dynamic> oldPoint,
    double animationFactor,
    Canvas canvas,
    Paint fillPaint,
    Paint strokePaint) {
  final num width = series.markerSettings.width,
      height = series.markerSettings.height;
  final DataMarkerType markerType = series.markerSettings.shape;
  num x = point.markerPoint.x;
  num y = point.markerPoint.y;
  if (series._chart._chartState.widgetNeedUpdate && oldPoint != null) {
    x = _getValue(animationFactor, x, oldPoint.markerPoint.x, x);
    y = _getValue(animationFactor, y, oldPoint.markerPoint.y, y);
    animationFactor = 1;
  }

  final Path path = Path();
  {
    switch (markerType) {
      case DataMarkerType.circle:
        {
          _ChartShapeUtils._drawCircle(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.rectangle:
        {
          _ChartShapeUtils._drawRectangle(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;
      case DataMarkerType.image:
        {
          _loadImage(series, canvas, fillPaint, x, y);
        }
        break;
      case DataMarkerType.pentagon:
        {
          _ChartShapeUtils._drawPentagon(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.verticalLine:
        {
          _ChartShapeUtils._drawVerticalLine(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.invertedTriangle:
        {
          _ChartShapeUtils._drawInvertedTriangle(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.horizontalLine:
        {
          _ChartShapeUtils._drawHorizontalLine(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.diamond:
        {
          _ChartShapeUtils._drawDiamond(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;

      case DataMarkerType.triangle:
        {
          _ChartShapeUtils._drawTriangle(
              path, x, y, animationFactor * width, animationFactor * height);
        }
        break;
    }
  }
  canvas.drawPath(path, strokePaint);
  canvas.drawPath(path, fillPaint);
}

/// To animate bubble series
void _animateBubbleSeries(
    Canvas canvas,
    num newX,
    num newY,
    num oldX,
    num oldY,
    num oldSize,
    double animationFactor,
    num radius,
    Paint strokePaint,
    Paint fillPaint,
    bool isTransposed) {
  num x = newX;
  num y = newY;
  num size = radius;
  if (isTransposed) {
    x = _getValue(animationFactor, x, oldX, newX);
  } else {
    y = _getValue(animationFactor, y, oldY, newY);
  }
  size = _getValue(animationFactor, size, oldSize, radius);
  canvas.drawCircle(Offset(x, y), size, fillPaint);
  canvas.drawCircle(Offset(x, y), size, strokePaint);
}

/// To animates range column series
void _animateRangeColumn(Canvas canvas, XyDataSeries<dynamic, dynamic> series,
    Paint fillPaint, RRect segmentRect, double animationFactor) {
  double height = segmentRect.height;
  double width = segmentRect.width;
  double left = segmentRect.left;
  double top = segmentRect.top;
  if (!series._chart.isTransposed) {
    height = segmentRect.height * animationFactor;
    top = segmentRect.center.dy - height / 2;
  } else {
    width = segmentRect.width * animationFactor;
    left = segmentRect.center.dx - width / 2;
  }
  canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, height), segmentRect.blRadius),
      fillPaint);
}

// To animate linear type animation
void _performLinearAnimation(XyDataSeries<dynamic, dynamic> series,
    Canvas canvas, double animationFactor) {
  series._chart.isTransposed
      ? canvas.clipRect(Rect.fromLTRB(
          0,
          series._xAxis.isInversed
              ? 0
              : (1 - animationFactor) *
                  series._chart._chartAxis._axisClipRect.bottom,
          series._chart._chartAxis._axisClipRect.left +
              series._chart._chartAxis._axisClipRect.width,
          series._xAxis.isInversed
              ? animationFactor *
                  (series._chart._chartAxis._axisClipRect.top +
                      series._chart._chartAxis._axisClipRect.height)
              : series._chart._chartAxis._axisClipRect.top +
                  series._chart._chartAxis._axisClipRect.height))
      : canvas.clipRect(Rect.fromLTRB(
          series._xAxis.isInversed
              ? (1 - animationFactor) *
                  (series._chart._chartAxis._axisClipRect.right)
              : 0,
          0,
          series._xAxis.isInversed
              ? series._chart._chartAxis._axisClipRect.left +
                  series._chart._chartAxis._axisClipRect.width
              : animationFactor *
                  (series._chart._chartAxis._axisClipRect.left +
                      series._chart._chartAxis._axisClipRect.width),
          series._chart._chartAxis._axisClipRect.top +
              series._chart._chartAxis._axisClipRect.height));
}

// To get nearest chart points from the touch point
List<dynamic> _getNearestChartPoints(
    double pointX,
    double pointY,
    ChartAxis actualXAxis,
    ChartAxis actualYAxis,
    XyDataSeries<dynamic, dynamic> cartesianSeries,
    [List<dynamic> firstNearestDataPoints]) {
  final List<dynamic> dataPointList = <dynamic>[];
  List<dynamic> dataList = <dynamic>[];
  final List<num> xValues = <num>[];
  final List<num> yValues = <num>[];

  firstNearestDataPoints != null
      ? dataList = firstNearestDataPoints
      : dataList = cartesianSeries._dataPoints;

  for (int i = 0; i < dataList.length; i++) {
    xValues.add(dataList[i].xValue);
    yValues.add(dataList[i].yValue);
  }
  num nearPointX = actualXAxis._visibleRange.minimum;

  final Rect rect = _calculatePlotOffset(
      cartesianSeries._chart._chartAxis._axisClipRect,
      Offset(cartesianSeries._xAxis.plotOffset,
          cartesianSeries._yAxis.plotOffset));

  final num touchXValue = _pointToXValue(cartesianSeries._chart, actualXAxis,
      actualXAxis._bounds, pointX - rect.left, pointY - rect.top);
  double delta = 0;
  for (int i = 0; i < dataList.length; i++) {
    final double currX = xValues[i].toDouble();
    if (delta == touchXValue - currX) {
      final _CartesianChartPoint<dynamic> dataPoint = dataList[i];
      if (dataPoint.isDrop != true && dataPoint.isGap != true) {
        dataPointList.add(dataPoint);
      }
    } else if ((touchXValue - currX).abs() <=
        (touchXValue - nearPointX).abs()) {
      nearPointX = currX;
      delta = touchXValue - currX;
      final _CartesianChartPoint<dynamic> dataPoint = dataList[i];
      dataPointList.clear();
      if (dataPoint.isDrop != true && dataPoint.isGap != true) {
        dataPointList.add(dataPoint);
      }
    }
  }
  return dataPointList;
}

ZoomPanArgs _zoomEvent(SfCartesianChart chart, dynamic axis,
    ZoomPanArgs zoomPanArgs, ChartZoomingCallback zoomEventType) {
  zoomPanArgs = ZoomPanArgs();
  zoomPanArgs.axis = axis;
  zoomPanArgs.currentZoomFactor = axis._zoomFactor;
  zoomPanArgs.currentZoomPosition = axis._zoomPosition;
  zoomPanArgs.previousZoomFactor = axis._previousZoomFactor;
  zoomPanArgs.previousZoomPosition = axis._previousZoomPosition;
  zoomEventType == chart.onZoomStart
      ? chart.onZoomStart(zoomPanArgs)
      : zoomEventType == chart.onZoomEnd
          ? chart.onZoomEnd(zoomPanArgs)
          : zoomEventType == chart.onZooming
              ? chart.onZooming(zoomPanArgs)
              : chart.onZoomReset(zoomPanArgs);

  return zoomPanArgs;
}
