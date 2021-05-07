part of flutter_charts;

class PlotBand {
  PlotBand(
      {bool isVisible,
      this.start,
      this.end,
      Color color,
      double opacity,
      Color borderColor,
      double borderWidth,
      this.text,
      ChartTextStyle textStyle,
      bool isRepeatable,
      dynamic repeatEvery,
      this.repeatUntil,
      this.textAngle,
      bool shouldRenderAboveSeries,
      DateTimeIntervalType sizeType,
      List<double> dashArray,
      this.size,
      this.associatedAxisStart,
      this.associatedAxisEnd,
      TextAnchor verticalTextAlignment,
      TextAnchor horizontalTextAlignment,
      this.gradient})
      : isVisible = isVisible ?? true,
        opacity = opacity ?? 1.0,
        color = color ?? Colors.grey,
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0,
        textStyle = textStyle ?? ChartTextStyle(),
        isRepeatable = isRepeatable ?? false,
        repeatEvery = repeatEvery ?? 1,
        shouldRenderAboveSeries = shouldRenderAboveSeries ?? false,
        dashArray = dashArray ?? <double>[0, 0],
        sizeType = sizeType ?? DateTimeIntervalType.auto,
        verticalTextAlignment = verticalTextAlignment ?? TextAnchor.middle,
        horizontalTextAlignment = horizontalTextAlignment ?? TextAnchor.middle;

  ///Toggles the visibility of the plotband.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Specifies the start value of plotband.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                     start: 1,
  ///                     end: 5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic start;

  ///Specifies the end value of plotband.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                     start: 1,
  ///                     end: 5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic end;

  ///Text to be displayed in the plotband segment.
  ///
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    text:'Winter'
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final String text;

  ///Customizes the text style of plotband.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    textStyle: ChartTextStyle(color:Colors.red)
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Color of the plotband.
  ///
  ///Defaults to Colors.grey
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    color: Colors.red
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final Color color;

  ///Color of the plotband border.
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    borderColor: Colors.red
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Width of the plotband border.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    borderWidth: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Opacity of the plotband. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    opacity: 0.5
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double opacity;

  ///Specifies the plotband need to be repeated in specified interval.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    isRepeatable: true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool isRepeatable;

  ///Interval of the plotband need to be repeated.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    repeatEvery: 200
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic repeatEvery;

  ///End of the plotband need to be repeated.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    repeatUntil: 600
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic repeatUntil;

  ///Angle of the plotband text.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    textAngle: 90
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final double textAngle;

  ///Specifies the whether plotband need to be rendered above the series.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    shouldRenderAboveSeries: true
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final bool shouldRenderAboveSeries;

  ///Date time interval type of the plotband.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    sizeType: DateTimeIntervalType.years
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final DateTimeIntervalType sizeType;

  ///Dashes of the series. Any number of values can be provided in the list. Odd value
  ///is considered as rendering size and even value is considered as gap.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    dashArray: <double>[10, 10]
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final List<double> dashArray;

  ///Size of the plotband
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    size: 20
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic size;

  ///Perpendicular axis start value.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    associatedAxisStart: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic associatedAxisStart;

  ///Perpendicular axis end value.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    associatedAxisStart: 2
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final dynamic associatedAxisEnd;

  ///Vertical text alignment of the plotband text
  ///
  ///Defaults to TextAnchor.middle
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    verticalTextAlignment: TextAnchor.start
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final TextAnchor verticalTextAlignment;

  ///Horizontal text alignment of the plotband text
  ///
  ///Defaults to TextAnchor.middle
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    horizontalTextAlignment: TextAnchor.end
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final TextAnchor horizontalTextAlignment;

  ///Fills the plotband with gradient color.
  ///
  ///```dart
  ///final List <Color> color = <Color>[];
  ///    color.add(Colors.pink[50]);
  ///    color.add(Colors.pink[200]);
  ///    color.add(Colors.pink);
  ///
  ///final List<double> stops = <double>[];
  ///    stops.add(0.0);
  ///    stops.add(0.5);
  ///    stops.add(1.0);
  ///
  ///final LinearGradient gradients = LinearGradient(colors: color, stops: stops);
  ///
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands: <PlotBand>[
  ///                PlotBand(
  ///                    isVisible:true,
  ///                    gradient: gradients
  ///                )
  ///              ]
  ///           )
  ///        ));
  ///}
  ///```
  final LinearGradient gradient;
}

class _PlotBandPainter extends CustomPainter {
  _PlotBandPainter({this.chart, this.shouldRenderAboveSeries});

  final SfCartesianChart chart;

  final bool shouldRenderAboveSeries;

  @override
  void paint(Canvas canvas, Size size) {
    for (int axisIndex = 0;
        axisIndex < chart._chartAxis._axisCollections.length;
        axisIndex++) {
      final ChartAxis axis = chart._chartAxis._axisCollections[axisIndex];
      for (int j = 0; j < axis.plotBands.length; j++) {
        final PlotBand plotBand = axis.plotBands[j];
        if (plotBand.isVisible &&
            shouldRenderAboveSeries != plotBand.shouldRenderAboveSeries) {
          _renderPlotBand(canvas, axis, plotBand);
        }
      }
    }
  }

  _ChartLocation _getStartAndEndValues(ChartAxis axis, dynamic start,
      dynamic end, PlotBand plotBand, bool isNeedRepeat) {
    dynamic startValue = start is String && num.tryParse(start) != null
        ? num.tryParse(start)
        : start;

    dynamic endValue =
        end is String && num.tryParse(end) != null ? num.tryParse(end) : end;
    if (axis is DateTimeAxis) {
      startValue = startValue is DateTime
          ? startValue.millisecondsSinceEpoch
          : startValue;
      endValue = isNeedRepeat
          ? plotBand.repeatUntil is DateTime
              ? plotBand.repeatUntil.millisecondsSinceEpoch
              : plotBand.repeatUntil
          : endValue is DateTime ? endValue.millisecondsSinceEpoch : endValue;
    } else if (axis is CategoryAxis) {
      startValue =
          startValue is num ? startValue : axis._labels.indexOf(startValue);
      endValue = isNeedRepeat
          ? plotBand.repeatUntil is num
              ? plotBand.repeatUntil.floor()
              : axis._labels.indexOf(plotBand.repeatUntil)
          : endValue is num ? endValue : axis._labels.indexOf(endValue);
    } else if (axis is LogarithmicAxis || axis is NumericAxis) {
      endValue = isNeedRepeat ? plotBand.repeatUntil : endValue;
    }
    return _ChartLocation(startValue, endValue);
  }

  void _renderPlotBand(Canvas canvas, ChartAxis axis, PlotBand plotBand) {
    num startValue, endValue;

    final bool isNeedRepeat = plotBand.isRepeatable &&
        plotBand.repeatUntil != null &&
        plotBand.repeatEvery != null;

    final _ChartLocation startAndEndValues = _getStartAndEndValues(
        axis,
        plotBand.start ?? axis._visibleRange.minimum,
        plotBand.end,
        plotBand,
        isNeedRepeat);
    startValue = startAndEndValues.x;
    endValue = startAndEndValues.y;
    if (isNeedRepeat) {
      num repeatStart = startValue, repeatEnd;
      while (repeatStart < endValue) {
        repeatEnd = _getValue(
            axis, plotBand, repeatStart, plotBand.size ?? plotBand.repeatEvery);
        repeatEnd = repeatEnd > endValue ? endValue : repeatEnd;
        _renderPlotBandElement(axis, repeatStart, repeatEnd, plotBand, canvas);
        repeatStart = plotBand.size != null
            ? _getValue(axis, plotBand, repeatStart, plotBand.repeatEvery)
            : repeatEnd;
      }
    } else {
      _renderPlotBandElement(axis, startValue, endValue, plotBand, canvas);
    }
  }

  num _getValue(ChartAxis axis, PlotBand plotBand, num value, num addValue) {
    DateTimeIntervalType intervalType;
    if (axis is DateTimeAxis) {
      intervalType = (plotBand.sizeType == DateTimeIntervalType.auto)
          ? axis._actualIntervalType
          : plotBand.sizeType;
      DateTime date = DateTime.fromMillisecondsSinceEpoch(value);
      switch (intervalType) {
        case DateTimeIntervalType.years:
          date = DateTime(date.year + addValue, date.month, date.day, date.hour,
              date.minute, date.second);
          break;
        case DateTimeIntervalType.months:
          date = DateTime(date.year, date.month + addValue, date.day, date.hour,
              date.minute, date.second);
          break;
        case DateTimeIntervalType.days:
          date = DateTime(date.year, date.month, date.day + addValue, date.hour,
              date.minute, date.second);
          break;
        case DateTimeIntervalType.hours:
          date = DateTime(date.year, date.month, date.day, date.hour + addValue,
              date.minute, date.second);
          break;
        case DateTimeIntervalType.minutes:
          date = DateTime(date.year, date.month, date.day, date.hour,
              date.minute + addValue, date.second);
          break;
        case DateTimeIntervalType.seconds:
          date = DateTime(date.year, date.month, date.day, date.hour,
              date.minute, date.second + addValue);
          break;
        default:
          break;
      }
      value = date.millisecondsSinceEpoch;
    } else {
      value += addValue;
    }
    return value;
  }

  void _renderPlotBandElement(ChartAxis axis, num startValue, num endValue,
      PlotBand plotBand, Canvas canvas) {
    _ChartLocation startPoint, endPoint, segmentStartPoint, segmentEndPoint;
    final Rect axisRect = chart._chartAxis._axisClipRect;
    Rect plotBandRect;
    num left, top, bottom, right;
    final num start = axis is LogarithmicAxis
        ? _logBase(startValue, axis.logBase)
        : startValue;
    final num end =
        axis is LogarithmicAxis ? _logBase(endValue, axis.logBase) : endValue;
    if (start >= axis._visibleRange.minimum &&
        end <= axis._visibleRange.maximum) {
      startPoint = _calculatePoint(startValue, startValue, axis, axis,
          chart._requireInvertedAxis, null, axisRect);
      endPoint = _calculatePoint(endValue, endValue, axis, axis,
          chart._requireInvertedAxis, null, axisRect);
      int textAngle;
      ChartAxis segmentAxis;
      if (plotBand.associatedAxisStart != null ||
          plotBand.associatedAxisEnd != null) {
        if (axis.associatedAxisName == null) {
          segmentAxis = (axis._orientation == AxisOrientation.horizontal)
              ? chart.primaryYAxis
              : chart.primaryXAxis;
        } else {
          for (int axisIndex = 0;
              axisIndex < chart._chartAxis._axisCollections.length;
              axisIndex++) {
            final ChartAxis targetAxis =
                chart._chartAxis._axisCollections[axisIndex];
            if (axis.associatedAxisName == targetAxis._name) {
              segmentAxis = axis;
            }
          }
        }
        final _ChartLocation startAndEndValues = _getStartAndEndValues(
            segmentAxis,
            plotBand.associatedAxisStart ?? startValue,
            plotBand.associatedAxisEnd ?? endValue,
            plotBand,
            false);

        if (segmentAxis._orientation == AxisOrientation.horizontal) {
          segmentStartPoint = _calculatePoint(startAndEndValues.x, startValue,
              segmentAxis, axis, chart._requireInvertedAxis, null, axisRect);
          segmentEndPoint = _calculatePoint(startAndEndValues.y, endValue,
              segmentAxis, axis, chart._requireInvertedAxis, null, axisRect);
          left = plotBand.associatedAxisStart != null
              ? segmentStartPoint.x
              : axisRect.left;
          right = plotBand.associatedAxisEnd != null
              ? segmentEndPoint.x
              : axisRect.right;
        } else {
          segmentStartPoint = _calculatePoint(startValue, startAndEndValues.x,
              axis, segmentAxis, chart._requireInvertedAxis, null, axisRect);
          segmentEndPoint = _calculatePoint(endValue, startAndEndValues.y, axis,
              segmentAxis, chart._requireInvertedAxis, null, axisRect);
          top = plotBand.associatedAxisStart != null
              ? segmentStartPoint.y
              : axisRect.bottom;
          bottom = plotBand.associatedAxisEnd != null
              ? segmentEndPoint.y
              : axisRect.top;
        }
      }

      if (axis._orientation == AxisOrientation.horizontal) {
        textAngle =
            plotBand.textAngle != null ? plotBand.textAngle.toInt() : 270;
        plotBandRect = Rect.fromLTRB(left ?? startPoint.x, top ?? axisRect.top,
            right ?? endPoint.x, bottom ?? axisRect.bottom);
      } else {
        textAngle = plotBand.textAngle != null ? plotBand.textAngle.toInt() : 0;
        plotBandRect = Rect.fromLTRB(left ?? axisRect.left, top ?? endPoint.y,
            right ?? axisRect.right, bottom ?? startPoint.y);
      }

      final List<double> dashArray = plotBand.dashArray;
      bool needDashLine = true;
      if (plotBandRect != null && plotBand.color != null) {
        Path path;
        for (int i = 1; i < dashArray.length; i = i + 2) {
          if (dashArray[i] == 0) {
            needDashLine = false;
          }
        }

        path = Path()
          ..moveTo(plotBandRect.left, plotBandRect.top)
          ..lineTo(plotBandRect.left + plotBandRect.width, plotBandRect.top)
          ..lineTo(plotBandRect.left + plotBandRect.width,
              plotBandRect.top + plotBandRect.height)
          ..lineTo(plotBandRect.left, plotBandRect.top + plotBandRect.height)
          ..close();

        final Paint paint = Paint();
        Path dashPath;
        if (needDashLine) {
          paint.isAntiAlias = false;
          dashPath = _dashPath(
            path,
            dashArray: _CircularIntervalList<double>(dashArray),
          );
        } else {
          dashPath = path;
        }
        if (path != null) {
          Paint fillPaint;
          if (plotBand.gradient != null) {
            fillPaint = Paint()
              ..shader = plotBand.gradient.createShader(plotBandRect)
              ..style = PaintingStyle.fill;
          } else {
            fillPaint = Paint()
              ..color = plotBand.color.withOpacity(plotBand.opacity)
              ..style = PaintingStyle.fill;
          }
          canvas.drawPath(path, fillPaint);
          if (plotBand.borderWidth > 0 &&
              plotBand.borderColor != null &&
              dashPath != null) {
            canvas.drawPath(
                dashPath,
                paint
                  ..color = plotBand.borderColor.withOpacity(plotBand.opacity)
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = plotBand.borderWidth);
          }
        }
      }
      if (plotBand.text != null && plotBand.text.isNotEmpty) {
        final Size textSize =
            _measureText(plotBand.text, plotBand.textStyle, textAngle);
        _drawText(
            canvas,
            plotBand.text,
            Offset(
                plotBand.horizontalTextAlignment == TextAnchor.middle
                    ? (plotBandRect.left +
                            plotBandRect.width / 2 -
                            textSize.width / 2) +
                        (textAngle != 0 ? textSize.width / 2 : 0)
                    : plotBand.horizontalTextAlignment == TextAnchor.start
                        ? plotBandRect.left
                        : plotBandRect.right - textSize.width,
                plotBand.verticalTextAlignment == TextAnchor.middle
                    ? (plotBandRect.top +
                            plotBandRect.height / 2 -
                            textSize.height / 2) +
                        (textAngle != 0 ? textSize.height / 2 : 0)
                    : plotBand.verticalTextAlignment == TextAnchor.start
                        ? plotBandRect.top
                        : plotBandRect.bottom - textSize.height),
            plotBand.textStyle,
            textAngle);
      }
    }
  }

  @override
  bool shouldRepaint(_PlotBandPainter oldDelegate) => true;
}
