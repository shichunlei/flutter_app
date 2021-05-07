part of flutter_charts;

/// Customizes the axis in the cartesian chart.
abstract class ChartAxis {
  ChartAxis(
      {this.name,
      double plotOffset,
      bool isVisible,
      AxisTitle title,
      AxisLine axisLine,
      ChartRangePadding rangePadding,
      int labelRotation,
      ChartDataLabelPosition labelPosition,
      TickPosition tickPosition,
      MajorTickLines majorTickLines,
      MinorTickLines minorTickLines,
      ChartTextStyle labelStyle,
      AxisLabelIntersectAction labelIntersectAction,
      this.desiredIntervals,
      MajorGridLines majorGridLines,
      MinorGridLines minorGridLines,
      int maximumLabels,
      int minorTicksPerInterval,
      bool isInversed,
      bool opposedPosition,
      EdgeLabelPlacement edgeLabelPlacement,
      bool enableAutoIntervalOnZooming,
      double zoomFactor,
      double zoomPosition,
      InteractiveTooltip interactiveTooltip,
      this.interval,
      this.crossesAt,
      this.associatedAxisName,
      bool placeLabelsNearAxisLine,
      List<PlotBand> plotBands})
      : isVisible = isVisible ?? true,
        interactiveTooltip = interactiveTooltip ?? InteractiveTooltip(),
        isInversed = isInversed ?? false,
        plotOffset = plotOffset ?? 0,
        placeLabelsNearAxisLine = placeLabelsNearAxisLine ?? true,
        opposedPosition = opposedPosition ?? false,
        rangePadding = rangePadding ?? ChartRangePadding.auto,
        labelRotation = labelRotation ?? 0,
        labelPosition = labelPosition ?? ChartDataLabelPosition.outside,
        tickPosition = tickPosition ?? TickPosition.outside,
        labelIntersectAction =
            labelIntersectAction ?? AxisLabelIntersectAction.hide,
        minorTicksPerInterval = minorTicksPerInterval ?? 0,
        maximumLabels = maximumLabels ?? 3,
        labelStyle = _getTextStyle(
            textStyle: labelStyle,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            fontFamily: 'Normal'),
        title = title ?? AxisTitle(),
        axisLine = axisLine ?? AxisLine(),
        majorTickLines = majorTickLines ?? MajorTickLines(),
        minorTickLines = minorTickLines ?? MinorTickLines(),
        majorGridLines = majorGridLines ?? MajorGridLines(),
        minorGridLines = minorGridLines ?? MinorGridLines(),
        edgeLabelPlacement = edgeLabelPlacement ?? EdgeLabelPlacement.none,
        _bounds = const Rect.fromLTWH(0, 0, 0, 0),
        zoomFactor = zoomFactor ?? 1,
        zoomPosition = zoomPosition ?? 0,
        enableAutoIntervalOnZooming = enableAutoIntervalOnZooming ?? true,
        plotBands = plotBands ?? <PlotBand>[],
        _visibleLabels = <AxisLabel>[] {
    _axisRenderer = _ChartAxisRenderer();
    _maximumLabelSize = const Size(0, 0);
    _series = <CartesianSeries<dynamic, dynamic>>[];
    _name = name;
    _labelRotation = this.labelRotation;
    _zoomFactor = this.zoomFactor;
    _zoomPosition = this.zoomPosition;
  }

  ///Toggles the visibility of the axis. Visibility of all the elements in the axis
  ///such as title, labels, major tick lines, and major grid lines will be toggled together.
  ///
  ///Defaults to true
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(isVisible: false),
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Customizes the appearance of the axis line. The axis line is visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(axisLine: AxisLine(width: 10)),
  ///        ));
  ///}
  ///```
  final AxisLine axisLine;

  ///Customizes the appearance of the major tick lines.Major ticks are small lines
  ///used to indicate the intervals in an axis. Major tick lines are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(majorTickLines: MajorTickLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MajorTickLines majorTickLines;

  ///Customizes the appearance of the minor tick lines. Minor ticks are small lines
  ///used to indicate the minor intervals between a major interval
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorTickLines: MinorTickLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MinorTickLines minorTickLines;

  ///Customizes the appearance of the major grid lines. Major grids are the lines
  ///drawn on the plot area at all the major intervals in an axis. Major grid lines
  ///are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(majorGridLines: MajorGridLines(width: 2)),
  ///        ));
  ///}
  ///```
  final MajorGridLines majorGridLines;

  ///Customizes the appearance of the minor grid lines. Minor grids are the lines drawn
  ///on the plot area at all the minor intervals between the major intervals.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorGridLines: MinorGridLines(width: 0)),
  ///        ));
  ///}
  ///```
  final MinorGridLines minorGridLines;

  ///Customizes the appearance of the axis labels. Labels are the axis values
  ///placed at each interval. Axis labels are visible by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelStyle: ChartTextStyle(color: Colors.black)),
  ///        ));
  ///}
  ///```
  /// This property is used to show or hide the axis labels.
  final ChartTextStyle labelStyle;

  ///Customizes the appearance of the axis title.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(title: AxisTitle( text: 'Year')),
  ///        ));
  ///}
  ///```
  final AxisTitle title;

  ///Padding for minimum and maximum values in an axis. Various types of range padding
  ///such as round, none, normal, and additional can be applied.
  ///
  ///Also refer [ChartRangePadding]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(rangePadding:  ChartRangePadding.round),
  ///        ));
  ///}
  ///```
  final ChartRangePadding rangePadding;

  ///The number of intervals in an axis. By default, the number of intervals is
  ///calculated based on the minimum and maximum values and the axis width and height.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(desiredIntervals: 2),
  ///        ));
  ///}
  ///```
  final int desiredIntervals;

  ///The maximum number of labels to be displayed in an axis in 100 logical pixels.
  ///
  ///Defaults to 3
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(maximumLabels: 4),
  ///        ));
  ///}
  ///```
  final int maximumLabels;

  ///Interval of the minor ticks.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(minorTicksPerInterval: 2),
  ///        ));
  ///}
  ///```
  final int minorTicksPerInterval;

  ///Angle for axis labels. The axis labels can be rotated to any angle.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelRotation: 90),
  ///        ));
  ///}
  ///```
  final int labelRotation;

  ///Axis labels intersecting action. Various actions such as hide, trim, wrap, rotate
  ///90 degree, rotate 45 degree, and placing the labels in multiple rows can be
  ///handled when the axis labels collide with each other.
  ///
  ///Defaults to AxisLabelIntersectAction.hide
  ///
  ///Also refer [AxisLabelIntersectAction]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelIntersectAction: AxisLabelIntersectAction.multipleRows),
  ///        ));
  ///}
  ///```
  final AxisLabelIntersectAction labelIntersectAction;

  ///Opposes the axis position. An axis can be placed at the opposite side of
  ///its default position.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(opposedPosition: true),
  ///        ));
  ///}
  ///```
  final bool opposedPosition;

  ///Inverts the axis. Axis is rendered from the minimum value to maximum value by
  ///default, and it can be inverted to render the axis from the maximum value
  ///to minimum value.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(isInversed: true),
  ///        ));
  ///}
  ///```
  final bool isInversed;

  ///Position of the labels. Axis labels can be placed either inside or
  ///outside the plot area.
  ///
  ///Defaults to ChartDataLabelPosition.outside
  ///
  ///Also refer [ChartDataLabelPosition]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(labelPosition: ChartDataLabelPosition.inside),
  ///        ));
  ///}
  ///```
  final ChartDataLabelPosition labelPosition;

  ///Position of the tick lines. Tick lines can be placed either inside or
  ///outside the plot area.
  ///
  ///Defaults to TickPosition.outside
  ///
  ///Also refer [TickPosition]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(tickPosition: TickPosition.inside),
  ///        ));
  ///}
  ///```
  final TickPosition tickPosition;

  ///Position of the edge labels. The edge labels in an axis can be hidden or shifted
  ///inside the axis bounds.
  ///
  ///Defaults to EdgeLabelPlacement.none
  ///
  ///Also refer [EdgeLabelPlacement]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.hide),
  ///        ));
  ///}
  ///```
  final EdgeLabelPlacement edgeLabelPlacement;

  ///Axis interval value. Using this, the axis labels can be displayed after
  ///certain interval value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interval: 1),
  ///        ));
  ///}
  ///```
  final double interval;

  ///Padding for plot area. The axis is rendered in chart with padding.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(plotOffset: 60),
  ///        ));
  ///}
  ///```
  final double plotOffset;

  _ChartAxisRenderer _axisRenderer;

  // ignore: prefer_final_fields
  List<AxisLabel> _visibleLabels;

  ///Name of an axis. A unique name further used for linking the series to this
  ///appropriate axis.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(name: 'primaryXAxis'),
  ///        ));
  ///}
  ///```
  final String name;

  /// It holds the size of larger label size
  Size _maximumLabelSize;

  /// It specifies axis orientations such as vertical, horizontal
  AxisOrientation _orientation;

  /// It specifies the visible range based on min, max values
  _VisibleRange _visibleRange;

  /// It specifies the actual range based on min, max values
  _VisibleRange _actualRange;

  /// It holds the chart series
  List<CartesianSeries<dynamic, dynamic>> _series;

  // ignore: prefer_final_fields
  Rect _bounds;

  ///Zoom factor of an axis. Scale the axis based on this value, and it ranges
  ///from 0 to 1.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(zoomFactor: 0.5),
  ///        ));
  ///}
  ///```
  final double zoomFactor;

  ///Position of the zoomed axis. The value ranges from 0 to 1.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(zoomPosition: 0.6),
  ///        ));
  ///}
  ///```
  final double zoomPosition;

  ///Enables or disables the automatic interval while zooming.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(enableAutoIntervalOnZooming: true),
  ///        ));
  ///}
  ///```
  final bool enableAutoIntervalOnZooming;

  ///Customizes the crosshair and selection zooming tooltip. Tooltip displays the current
  ///axis value based on the crosshair position/selectionZoomRect position at an axis.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(interactiveTooltip: InteractiveTooltip(enable: true)),
  ///        ));
  ///}
  ///```
  final InteractiveTooltip interactiveTooltip;

  ///Customize to place the axis crossing on another axis based on the value
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(crossesAt:10),
  ///        ));
  ///}
  ///```
  final dynamic crossesAt;

  ///Axis line crossed on mentioned axis name, and applicable for plotband also.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(associatedAxisName: 'primaryXAxis'),
  ///        ));
  ///}
  ///```
  final String associatedAxisName;

  ///Consider to place the axis label respect to near axis line.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(placeLabelsNearAxisLine: false),
  ///        ));
  ///}
  ///```
  final bool placeLabelsNearAxisLine;

  ///Render the plot band in axis
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: NumericAxis(
  ///             plotBands:<PlotBand>[plotBands(start:20, end:30, color:Colors.red, text:'Flutter')]
  ///               ),
  ///        ));
  ///}
  ///```
  final List<PlotBand> plotBands;

  bool _isInsideTickPosition;

  double _totalSize;

  ///Internal variable
  double _previousZoomFactor;

  ///Internal variable
  double _previousZoomPosition;

  ///Internal variables

  String _name;

  int _labelRotation;

  double _zoomFactor;

  double _zoomPosition;

  ///Checking the axis label collision
  bool _isCollide = false;

  SfCartesianChart _chart;

  num _min;
  num _max;
  Size _axisSize;

  ChartAxis _crossAxis;

  num _crossValue;

  _VisibleRange _crossRange;

  num _labelOffset;

  num calculateInterval(_VisibleRange range, Size availableSize);

  void applyRangePadding(_VisibleRange range, num interval);

  void calculateVisibleRange(Size availableSize);

  void generateVisibleLabels();

  void calculateRange(ChartAxis _axis) {
    _min = null;
    _max = null;
    List<CartesianSeries<dynamic, dynamic>> visibleSeries;
    CartesianSeries<dynamic, dynamic> series;
    double paddingInterval = 0;
    ChartAxis _xAxis, _yAxis;
    visibleSeries = _series;
    for (int i = 0; i < visibleSeries.length; i++) {
      series = visibleSeries[i];
      if (series._minimumX != null && series._maximumX != null) {
        paddingInterval = 0;
        _xAxis = series._xAxis;
        _yAxis = series._yAxis;
        if (((_xAxis is DateTimeAxis || _xAxis is NumericAxis) &&
                _xAxis.rangePadding != null &&
                _xAxis.rangePadding == ChartRangePadding.auto) &&
            (series._seriesType == 'column' ||
                series._seriesType == 'bar' ||
                series._seriesType == 'rangecolumn' ||
                series._seriesType == 'stackedcolumn' ||
                series._seriesType == 'stackedbar')) {
          paddingInterval =
              _calculateMinPointsDelta(this, visibleSeries, _chart) / 2;
        }
        if (((_chart._requireInvertedAxis ? _yAxis : _xAxis) == _axis) &&
            _orientation == AxisOrientation.horizontal) {
          _chart._requireInvertedAxis
              ? _findMinMax(series._minimumY, series._maximumY)
              : _findMinMax(series._minimumX - paddingInterval,
                  series._maximumX + paddingInterval);
        }

        if (((_chart._requireInvertedAxis ? _xAxis : _yAxis) == _axis) &&
            _orientation == AxisOrientation.vertical) {
          _chart._requireInvertedAxis
              ? _findMinMax(series._minimumX - paddingInterval,
                  series._maximumX + paddingInterval)
              : _findMinMax(series._minimumY, series._maximumY);
        }
      }
    }
  }

  /// Find min and max values
  void _findMinMax(num minVal, num maxVal) {
    if (_min == null || _min > minVal) {
      _min = minVal;
    }
    if (_max == null || _max < maxVal) {
      _max = maxVal;
    }
  }

  /// Calculate the interval based min and max values in axis
  num _calculateNumericNiceInterval(ChartAxis axis, num delta, Size size) {
    final dynamic intervalDivisions = <dynamic>[10, 5, 2, 1];
    num niceInterval;

    /// Get the desired interval if desired interval not specified
    final num actualDesiredIntervalCount =
        _calculateDesiredIntervalCount(size, axis);
    niceInterval = delta / actualDesiredIntervalCount;
    if (axis.desiredIntervals != null) {
      return niceInterval;
    }

    /// Get the minimum interval
    final num minimumInterval = niceInterval == 0
        ? 0
        : math.pow(10, _logBase(niceInterval, 10).floor());
    for (int i = 0; i < intervalDivisions.length; i++) {
      final num interval = intervalDivisions[i];
      final num currentInterval = minimumInterval * interval;
      if (actualDesiredIntervalCount < (delta / currentInterval)) {
        break;
      }
      niceInterval = currentInterval;
    }
    return niceInterval;
  }

  /// Calculate the axis interval for numeric axis
  num _calculateDesiredIntervalCount(Size availableSize, ChartAxis axis) {
    final dynamic size = axis._orientation == AxisOrientation.horizontal
        ? availableSize.width
        : availableSize.height;
    if (axis.desiredIntervals == null) {
      num desiredIntervalCount =
          (axis._orientation == AxisOrientation.horizontal ? 0.533 : 1) *
              axis.maximumLabels;
      desiredIntervalCount = math.max(size * (desiredIntervalCount / 100), 1);
      return desiredIntervalCount;
    } else {
      return axis.desiredIntervals;
    }
  }

  /// Get the range padding of an axis
  ChartRangePadding _calculateRangePadding(
      ChartAxis axis, SfCartesianChart chart) {
    ChartRangePadding padding;
    if (axis.rangePadding != ChartRangePadding.auto) {
      padding = axis.rangePadding;
    } else if (axis.rangePadding == ChartRangePadding.auto &&
        axis._orientation != null) {
      switch (axis._orientation) {
        case AxisOrientation.horizontal:
          padding = (chart._requireInvertedAxis)
              ? ChartRangePadding.normal
              : ChartRangePadding.none;
          break;
        case AxisOrientation.vertical:
          padding = (!chart._requireInvertedAxis)
              ? ChartRangePadding.normal
              : ChartRangePadding.none;
          break;
      }
    }
    return padding;
  }

  ///Applying range padding
  void _applyRangePadding(ChartAxis axis, SfCartesianChart chart,
      _VisibleRange range, num _interval) {
    final num start = range.minimum;
    final num end = range.maximum;
    final ChartRangePadding padding = _calculateRangePadding(this, chart);
    if (padding == ChartRangePadding.additional ||
        padding == ChartRangePadding.round) {
      /// Get the additional range
      _findAdditionalRange(this, start, end, _interval);
    } else if (padding == ChartRangePadding.normal) {
      /// Get the normal range
      _findNormalRange(this, start, end, _interval);
    } else {
      _updateActualRange(this, start, end, _interval);
    }
    range.delta = range.maximum - range.minimum;
  }

  /// Find the additional range
  void _findAdditionalRange(ChartAxis axis, num start, num end, num interval) {
    num minimum;
    num maximum;
    minimum = ((start / interval).floor()) * interval;
    maximum = ((end / interval).ceil()) * interval;
    if (axis.rangePadding == ChartRangePadding.additional) {
      minimum -= interval;
      maximum += interval;
    }

    /// Update the visible range to the axis.
    _updateActualRange(axis, minimum, maximum, interval);
  }

  /// Update visible range
  void _updateActualRange(
      ChartAxis axis, num minimum, num maximum, num interval) {
    final dynamic _axis = axis;
    axis._actualRange.minimum = _axis.minimum != null ? _axis.minimum : minimum;
    axis._actualRange.maximum = _axis.maximum != null ? _axis.maximum : maximum;
    axis._actualRange.delta =
        axis._actualRange.maximum - axis._actualRange.minimum;
    axis._actualRange.interval =
        axis.interval != null ? axis.interval : interval;
  }

  /// Find the normal range
  void _findNormalRange(ChartAxis axis, num start, num end, num interval) {
    num remaining, minimum, maximum;
    num startValue = start;
    if (axis is CategoryAxis && axis.labelPlacement == LabelPlacement.onTicks) {
      minimum = start - 0.5;
      maximum = end + 0.5;
    } else {
      if (start < 0) {
        startValue = 0;
        minimum = start + (start / 20);
        remaining = interval + _getValueByPercentage(minimum, interval);
        if ((0.365 * interval) >= remaining) {
          minimum -= interval;
        }
        if (_getValueByPercentage(minimum, interval) < 0) {
          minimum =
              (minimum - interval) - _getValueByPercentage(minimum, interval);
        }
      } else {
        minimum = start < ((5.0 / 6.0) * end) ? 0 : (start - (end - start) / 2);
        if (minimum % interval > 0) {
          minimum -= minimum % interval;
        }
      }
      maximum = (end > 0)
          ? (end + (end - startValue) / 20)
          : (end - (end - startValue) / 20);
      remaining = interval - (maximum % interval);
      if ((0.365 * interval) >= remaining) {
        maximum += interval;
      }
      if (maximum % interval > 0) {
        maximum = (maximum + interval) - (maximum % interval);
      }
    }
    if (minimum == 0) {
      interval = (axis is NumericAxis)
          ? _calculateNumericNiceInterval(axis, maximum - minimum, _axisSize)
          : calculateInterval(_VisibleRange(minimum, maximum), _axisSize);
      maximum = (maximum / interval).ceil() * interval;
    }

    /// Update the visible range to the axis.
    _updateActualRange(axis, minimum, maximum, interval);
  }

  void _triggerLabelRenderEvent(String labelText, num labelValue) {
    AxisLabelRenderArgs axisLabelArgs;
    ChartTextStyle textStyle;
    textStyle = labelStyle;
    if (_chart.onAxisLabelRender != null) {
      axisLabelArgs = AxisLabelRenderArgs();
      axisLabelArgs.text = labelText;
      axisLabelArgs.value = labelValue;
      axisLabelArgs.textStyle = textStyle;
      axisLabelArgs.axis = this;
      axisLabelArgs.orientation = _orientation;
      axisLabelArgs.axisName = _name;
      _chart.onAxisLabelRender(axisLabelArgs);
      labelText = axisLabelArgs.text;
      textStyle = axisLabelArgs.textStyle;
    }
    final Size labelSize = _measureText(labelText, textStyle, labelRotation);
    _visibleLabels.add(AxisLabel(textStyle, labelSize, labelText, labelValue));
  }

  /// Calculate the maximum lable's size
  void _calculateMaximumLabelSize(ChartAxis axis, SfCartesianChart chart) {
    AxisLabelIntersectAction action;
    int angle = axis._labelRotation;
    AxisLabel label;
    Size currentLabelSize;
    num maximumLabelHeight = 0.0,
        maximumLabelWidth = 0.0,
        labelMaximumWidth,
        pointX,
        height;
    action = axis.labelIntersectAction;
    labelMaximumWidth =
        chart._chartAxis._axisClipRect.width / axis._visibleLabels.length;

    if (axis._orientation == AxisOrientation.horizontal &&
        axis.labelIntersectAction != AxisLabelIntersectAction.none &&
        axis._visibleLabels.length > 1) {
      final Rect axisBounds = chart._chartAxis._axisClipRect;
      AxisLabel label1;
      num pointX1;
      for (int i = 0; i < axis._visibleLabels.length - 1; i++) {
        label = axis._visibleLabels[i];
        pointX = (_valueToCoefficient(label.value, axis) * axisBounds.width) +
            axisBounds.left;
        pointX -= label.labelSize.width / 2;
        pointX = (i == 0 &&
                axis.edgeLabelPlacement == EdgeLabelPlacement.shift &&
                ((pointX < axisBounds.left && !axis.isInversed) ||
                    (pointX + label.labelSize.width > axisBounds.right &&
                        axis.isInversed)))
            ? (axis.isInversed
                ? axisBounds.left + axisBounds.width - label.labelSize.width
                : axisBounds.left)
            : ((i == axis._visibleLabels.length - 1 &&
                    axis.edgeLabelPlacement == EdgeLabelPlacement.shift &&
                    ((((pointX + label.labelSize.width) > axisBounds.right) &&
                            !axis.isInversed) ||
                        (pointX < axisBounds.left && axis.isInversed)))
                ? (axis.isInversed
                    ? axisBounds.left
                    : axisBounds.left +
                        axisBounds.width -
                        label.labelSize.width)
                : pointX);

        label1 = axis._visibleLabels[i + 1];
        pointX1 = (_valueToCoefficient(label1.value, axis) *
                chart._chartAxis._axisClipRect.width) +
            chart._chartAxis._axisClipRect.left;
        pointX1 -= label1.labelSize.width / 2;

        if ((((pointX + label.labelSize.width) > pointX1) &&
                !axis.isInversed) ||
            (((pointX - label.labelSize.width) < pointX1) && axis.isInversed)) {
          _isCollide = true;
          break;
        }
      }
    }

    for (int i = 0; i < axis._visibleLabels.length; i++) {
      label = axis._visibleLabels[i];
      if (label.labelSize.width > maximumLabelWidth) {
        maximumLabelWidth = label.labelSize.width;
      }
      if (label.labelSize.height > maximumLabelHeight) {
        maximumLabelHeight = label.labelSize.height;
      }

      if (axis._orientation == AxisOrientation.horizontal) {
        pointX = (_valueToCoefficient(label.value, axis) *
                chart._chartAxis._axisClipRect.width) +
            chart._chartAxis._axisClipRect.left;
        pointX -= label.labelSize.width / 2;

        /// Based on below options, perform label intersection
        if (_isCollide) {
          switch (action) {
            case AxisLabelIntersectAction.multipleRows:
              if (i > 0) {
                height = _findMultiRows(i, pointX, label, axis, chart);
                if (height > maximumLabelHeight) {
                  maximumLabelHeight = height;
                }
              }
              break;
            case AxisLabelIntersectAction.rotate45:
            case AxisLabelIntersectAction.rotate90:
              angle = action == AxisLabelIntersectAction.rotate45 ? 45 : 90;
              axis._labelRotation = angle;
              currentLabelSize =
                  _measureText(label.text, axis.labelStyle, angle);
              if (currentLabelSize.height > maximumLabelHeight)
                maximumLabelHeight = currentLabelSize.height;
              if (currentLabelSize.width > maximumLabelWidth)
                maximumLabelWidth = currentLabelSize.width;
              break;
            case AxisLabelIntersectAction.wrap:
              label._labelCollection =
                  _textWrap(label.text, labelMaximumWidth, axis);
              if (label._labelCollection.isNotEmpty)
                label.text = label._labelCollection[0];
              height = label.labelSize.height * label._labelCollection.length;
              if (height > maximumLabelHeight) {
                maximumLabelHeight = height;
              }
              break;
            default:
              break;
          }
        }
      }
    }
    axis._maximumLabelSize = Size(maximumLabelWidth, maximumLabelHeight);
  }

  num _findMultiRows(num length, num currentX, AxisLabel currentLabel,
      ChartAxis axis, SfCartesianChart chart) {
    AxisLabel label;
    num pointX;
    final dynamic labelIndex = <dynamic>[];
    bool isMultiRows;
    for (int i = length - 1; i >= 0; i--) {
      label = axis._visibleLabels[i];
      pointX = (_valueToCoefficient(label.value, axis) *
              chart._chartAxis._axisClipRect.width) +
          chart._chartAxis._axisClipRect.left;
      isMultiRows = !axis.isInversed
          ? currentX < (pointX + label.labelSize.width / 2)
          : currentX + currentLabel.labelSize.width >
              (pointX - label.labelSize.width / 2);
      if (isMultiRows) {
        labelIndex.add(label._index);
        currentLabel._index = (currentLabel._index > label._index)
            ? currentLabel._index
            : label._index + 1;
      } else {
        currentLabel._index = labelIndex.contains(label._index)
            ? currentLabel._index
            : label._index;
      }
    }
    return currentLabel.labelSize.height * currentLabel._index;
  }

  List<String> _textWrap(
      String currentLabel, num maximumWidth, ChartAxis axis) {
    final List<String> textCollection = currentLabel.split(RegExp(' '));
    final List<String> labelCollection = <String>[];
    String text;
    for (int i = 0; i < textCollection.length; i++) {
      text = textCollection[i];
      (_measureText(text, axis.labelStyle, axis._labelRotation).width <
              maximumWidth)
          ? labelCollection.add(text)
          : labelCollection
              .add(_textTrim(text, maximumWidth, axis.labelStyle, axis));
    }
    return labelCollection;
  }

  String _textTrim(String text, num maximumWidth, ChartTextStyle labelStyle,
      ChartAxis axis) {
    String label = text;
    num size = _measureText(text, axis.labelStyle, axis._labelRotation).width;
    if (size > maximumWidth) {
      final int textLength = text.length;
      for (int i = textLength - 1; i >= 0; --i) {
        label = text.substring(0, i) + '...';
        size = _measureText(label, labelStyle, axis._labelRotation).width;
        if (size <= maximumWidth) {
          return label;
        }
      }
    }
    return label;
  }

  ///Below method is for changing range while zooming
  void _calculateZoomRange(ChartAxis axis, Size axisSize) {
    /// Restrict zoomfactor and zoomposition values between 0 to 1
    axis._zoomFactor =
        axis._zoomFactor > 1 ? 1 : axis._zoomFactor < 0 ? 0 : axis._zoomFactor;
    axis._zoomPosition = axis._zoomPosition > 1
        ? 1
        : axis._zoomPosition < 0 ? 0 : axis._zoomPosition;

    final _VisibleRange baseRange = axis._visibleRange;
    num start, end;
    start = axis._visibleRange.minimum +
        axis._zoomPosition * axis._visibleRange.delta;
    end = start + axis._zoomFactor * axis._visibleRange.delta;

    if (start < baseRange.minimum) {
      end = end + (baseRange.minimum - start);
      start = baseRange.minimum;
    }
    if (end > baseRange.maximum) {
      start = start - (end - baseRange.maximum);
      end = baseRange.maximum;
    }
    axis._visibleRange.minimum = start;
    axis._visibleRange.maximum = end;
    axis._visibleRange.delta = end - start;
  }

  void _checkWithZoomState(ChartAxis axis, List<ChartAxis> axisStates) {
    for (int i = 0; i < axisStates.length; i++) {
      final ChartAxis zoomedAxis = axisStates[i];
      if (zoomedAxis._name == axis._name) {
        axis._zoomFactor = zoomedAxis._zoomFactor;
        axis._zoomPosition = zoomedAxis._zoomPosition;
        break;
      }
    }
  }
}

/// Holds the axis label information.
class AxisLabel {
  AxisLabel(this.labelStyle, this.labelSize, this.text, this.value);

  /// It specifies the textstyle of label
  ChartTextStyle labelStyle;

  /// It holds size of label
  Size labelSize;

  /// It holds text of label to be print
  String text;

  num value;

  List<String> _labelCollection;

  int _index = 1;

  ///Stores the location of an label
  Rect _labelRegion;
}

/// Customizes the major tick lines.
class MajorTickLines {
  MajorTickLines({this.size = 5, this.width = 1, this.color});

  ///Size of the major tick lines.
  ///
  ///Defaults to 8
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorTickLines: MajorTickLines(
  ///                   size: 6
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double size;

  ///Width of the major tick lines.
  ///
  ///Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorTickLines: MajorTickLines(
  ///                   width: 2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  /// Colors of the major tick lines.
  ///
  /// Defaults to null.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorTickLines: MajorTickLines(
  ///                   color: Colors.black
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color color;
}

/// Customizes the minor tick lines.
class MinorTickLines {
  MinorTickLines({this.size = 3, this.width = 0.7, this.color});

  ///Height of the minor tick lines.
  ///
  ///Defaults to 5
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            size: 5.0,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final double size;

  ///Width of the minor tick lines.
  ///
  ///Defaults to 0.7
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            width: 0.5,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the minor tick lines.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorTickLines: MinorTickLines(
  ///            color:Colors.red,
  ///           )
  ///         )
  ///        ));
  ///}
  ///```
  final Color color;
}

/// Customizes the major grid lines.
class MajorGridLines {
  MajorGridLines({this.width = 0.7, this.color, this.dashArray});

  ///Dashes of the major grid lines.
  ///
  ///Defaults to [0,0]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   dashArray: [1,2]
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final List<double> dashArray;

  /// Width of the major grid lines.
  ///
  /// Defaults to  0.7
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   width:2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the major grid lines.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 majorGridLines: MajorGridLines(
  ///                   color:Colors.red
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color color;
}

/// Customizes the minor grid lines.
class MinorGridLines {
  MinorGridLines({this.width = 0.5, this.color, this.dashArray});

  ///Dashes of minor grid lines.
  ///
  ///Defaults to [0,0]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            dashArray: <double>[10, 20],
  ///          )
  ///         )
  ///        ));
  ///}
  ///```
  final List<double> dashArray;

  ///Width of the minor grid lines.
  ///
  ///Defaults to 0.5
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            width: 0.7,
  ///         )
  ///         )
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the minor grid lines.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///            minorTicksPerInterval: 5,
  ///            minorGridLines: MinorGridLines(
  ///            color: Colors.red,
  ///         ),
  ///         )
  ///        ));
  ///}
  ///```
  final Color color;
}

/// Customizes the axis title.
class AxisTitle {
  AxisTitle(
      {this.text,
      ChartTextStyle textStyle,
      this.alignment = ChartAlignment.center})
      : textStyle = _getTextStyle(
            textStyle: textStyle,
            fontFamily: 'Segoe UI',
            fontSize: 15.0,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal);

  ///Text to be displayed as axis title.
  ///
  ///Defaults to ‘’
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final String text;

  ////Customizes the appearance of text in axis title.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                   textStyle: ChartTextStyle(
  ///                     color: Colors.blue,
  ///                     fontStyle: FontStyle.italic,
  ///                     fontWeight: FontWeight.w600,
  ///                     fontFamily: 'Roboto'
  ///                   )
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Aligns the axis title. It is applicable for both vertical and horizontal axes.
  ///
  ///ChartAlignment.near moves the axis title to the beginning of the axis, whereas
  ///ChartAlignment.far moves the axis title to the end of the axis, and
  ///ChartAlignment.center moves the axis title to the center position of the axis.
  ///
  ///Defaults to ChartAlignment.center
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 title: AxisTitle(
  ///                   text: 'Axis Title',
  ///                   alignment: ChartAlignment.far,
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;
}

/// Customizes the axis line.
class AxisLine {
  AxisLine({this.color, this.dashArray, this.width = 1});

  ///Width of the axis line.
  ///
  ///Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   width: 2
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the axis line. Color will be applied based on the brightness property of the app.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   color:Colors.blue,
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final Color color;

  ///Dashes of the axis line. Any number of values can be provided in the list. Odd value is
  ///considered as rendering size and even value is considered as gap.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            primaryXAxis: NumericAxis(
  ///                 axisLine:AxisLine(
  ///                   dashArray: <double>[5,5],
  ///                 )
  ///                ),
  ///        ));
  ///}
  ///```
  final List<double> dashArray;
}

///calculate visible range based on min, max values
class _VisibleRange {
  _VisibleRange(dynamic min, dynamic max) {
    if (min < max) {
      minimum = min;
      maximum = max;
    } else {
      minimum = max;
      maximum = min;
    }
  }

  /// specifies minimum range
  dynamic minimum;

  /// Specifies maximum range
  dynamic maximum;

  /// Specifies range interval
  dynamic interval;

  /// Specifies delta value for min-max
  num delta;
}
