part of flutter_charts;

class LogarithmicAxis extends ChartAxis {
  LogarithmicAxis(
      {String name,
      bool isVisible,
      AxisTitle title,
      AxisLine axisLine,
      AxisLabelIntersectAction labelIntersectAction,
      int labelRotation,
      ChartDataLabelPosition labelPosition,
      TickPosition tickPosition,
      bool isInversed,
      bool opposedPosition,
      int minorTicksPerInterval,
      int maximumLabels,
      MajorTickLines majorTickLines,
      MinorTickLines minorTickLines,
      MajorGridLines majorGridLines,
      MinorGridLines minorGridLines,
      EdgeLabelPlacement edgeLabelPlacement,
      ChartTextStyle labelStyle,
      double plotOffset,
      double zoomFactor,
      double zoomPosition,
      InteractiveTooltip interactiveTooltip,
      this.minimum,
      this.maximum,
      double interval,
      double logBase,
      this.labelFormat,
      this.numberFormat,
      this.visibleMinimum,
      this.visibleMaximum,
      dynamic crossesAt,
      String associatedAxisName,
      bool placeLabelsNearAxisLine,
      List<PlotBand> plotBands})
      : logBase = logBase ?? 10,
        super(
            name: name,
            isVisible: isVisible,
            isInversed: isInversed,
            opposedPosition: opposedPosition,
            labelRotation: labelRotation,
            labelIntersectAction: labelIntersectAction,
            labelPosition: labelPosition,
            tickPosition: tickPosition,
            minorTicksPerInterval: minorTicksPerInterval,
            maximumLabels: maximumLabels,
            labelStyle: labelStyle,
            title: title,
            axisLine: axisLine,
            edgeLabelPlacement: edgeLabelPlacement,
            majorTickLines: majorTickLines,
            minorTickLines: minorTickLines,
            majorGridLines: majorGridLines,
            minorGridLines: minorGridLines,
            plotOffset: plotOffset,
            zoomFactor: zoomFactor,
            zoomPosition: zoomPosition,
            interactiveTooltip: interactiveTooltip,
            interval: interval,
            crossesAt: crossesAt,
            associatedAxisName: associatedAxisName,
            placeLabelsNearAxisLine: placeLabelsNearAxisLine,
            plotBands: plotBands);

  ///Formats the numeric axis labels. The labels can be customized by adding
  ///desired text as prefix or suffix.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: LogaithmicAxis(labelFormat: '{value}M'),
  ///        ));
  ///}
  ///```
  final String labelFormat;

  ///Formats the logarithmic axis labels with globalized label formats.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: LogarithmicAxis(numberFormat: NumberFormat.currencyCompact()),
  ///        ));
  ///}
  ///```
  final NumberFormat numberFormat;

  ///The minimum value of the axis. The axis will start from this value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryYAxis: LogarithmicAxis(minimum: 0),
  ///        ));
  ///}
  ///```
  final double minimum;

  ///The maximum value of the axis. The axis will end at this value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryYAxis: LogarithmicAxis(maximum: 10),
  ///        ));
  ///}
  ///```
  final double maximum;

  ///The base value for logarithmic axis.
  ///
  ///Defaults to 10
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryYAxis: LogarithmicAxis(logBase: 10),
  ///        ));
  ///}
  ///```
  final double logBase;

  ///The minimum visible value of the axis. The axis will be rendered
  ///from this value initially.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: LogarithmicAxis(visibleMinimum: 0),
  ///        ));
  ///}
  ///```
  final double visibleMinimum;

  ///The minimum visible value of the axis. The axis will be
  ///rendered from this value initially.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: LogarithmicAxis(visibleMaximum: 200),
  ///        ));
  ///}
  ///```
  final double visibleMaximum;

  num _min;
  num _max;
  Size _axisSize;

  /// Find the series min and max values of an series
  void _findAxisMinMax(CartesianSeries<dynamic, dynamic> series) {
    for (_CartesianChartPoint<dynamic> point in series._dataPoints) {
      point.xValue = point.x;
      point.yValue = point.y;
      series._minimumX ??= point.xValue;
      series._maximumX ??= point.xValue;
      series._minimumY ??= point.yValue;
      series._maximumY ??= point.yValue;
      if (point.xValue != null) {
        series._minimumX = math.min(series._minimumX, point.xValue);
        series._maximumX = math.max(series._maximumX, point.xValue);
      }
      if (point.yValue != null) {
        series._minimumY = math.min(series._minimumY, point.yValue);
        series._maximumY = math.max(series._maximumY, point.yValue);
      }
    }
    series._minimumX ??= 0;
    series._minimumY ??= 0;
    series._maximumX ??= 5;
    series._maximumY ??= 5;
  }

  /// Calculate the range and interval
  void _calculateRangeAndInterval(SfCartesianChart chartWidget, [String type]) {
    _chart = chartWidget;
    final Rect containerRect = _chart._chartState.containerRect;
    final Rect rect = Rect.fromLTWH(containerRect.left, containerRect.top,
        containerRect.width, containerRect.height);
    _axisSize = Size(rect.width, rect.height);
    calculateRange(this);
    _getActualRange();
    calculateVisibleRange(_axisSize);

    /// Setting range as visible zoomRange
    if (visibleMinimum != null || visibleMaximum != null) {
      _visibleRange.minimum = visibleMinimum != null
          ? (math.log(visibleMinimum) / (math.log(10))).round()
          : _visibleRange.minimum;
      _visibleRange.maximum = visibleMaximum != null
          ? (math.log(visibleMaximum) / (math.log(10))).round()
          : _visibleRange.maximum;
      _visibleRange.delta = _visibleRange.maximum - _visibleRange.minimum;
      _zoomFactor = _visibleRange.delta / _actualRange.delta;
    }
    if (type == null && type != 'AxisCross') {
      generateVisibleLabels();
    }
  }

  void _getActualRange() {
    num logStart, logEnd;
    _min ??= 0;
    _max ??= 5;
    _min = minimum ?? _min;
    _max = maximum ?? _max;
    _min = _min < 0 ? 0 : _min;
    logStart = _logBase(_min, logBase);
    logStart = logStart.isFinite ? logStart : _min;
    logEnd = _logBase(_max, logBase);
    logEnd = logEnd.isFinite ? logEnd : _max;
    _min = (logStart / 1).floor();
    _max = (logEnd / 1).ceil();
    if (_min == _max) {
      _max += 1;
    }
    _actualRange = _VisibleRange(_min, _max);
    _actualRange.delta = _actualRange.maximum - _actualRange.minimum;
    _actualRange.interval =
        interval ?? calculateLogNiceInterval(_actualRange.delta);
  }

  /// Calculates the visible range for an axis in chart.
  @override
  void calculateVisibleRange(Size availableSize) {
    _visibleRange = _actualRange;
    _checkWithZoomState(this, _chart._chartState.zoomedAxisStates);
    if (_zoomFactor < 1 || _zoomPosition > 0) {
      _calculateZoomRange(this, availableSize);
      _visibleRange.delta = _visibleRange.maximum - _visibleRange.minimum;
      _visibleRange.interval = enableAutoIntervalOnZooming
          ? calculateLogNiceInterval(_visibleRange.delta)
          : _visibleRange.interval;
      _visibleRange.interval = _visibleRange.interval.floor() == 0
          ? 1
          : _visibleRange.interval.floor();
    }
  }

  num calculateLogNiceInterval(num delta) {
    final dynamic intervalDivisions = <dynamic>[10, 5, 2, 1];
    final num actualDesiredIntervalCount =
        _calculateDesiredIntervalCount(_axisSize, this);
    num niceInterval = delta;
    final num minInterval = math.pow(10, _logBase(niceInterval, 10).floor());
    for (int i = 0; i < intervalDivisions.length; i++) {
      final num interval = intervalDivisions[i];
      final num currentInterval = minInterval * interval;
      if (actualDesiredIntervalCount < (delta / currentInterval)) {
        break;
      }
      niceInterval = currentInterval;
    }
    return niceInterval;
  }

  /// Applies range padding to auto, normal, additional, round, and none types.
  @override
  void applyRangePadding(_VisibleRange range, num interval) {}

  /// Generates the visible axis labels.
  @override
  void generateVisibleLabels() {
    num tempInterval = _visibleRange.minimum;
    String labelText;
    _visibleLabels = <AxisLabel>[];
    for (;
        tempInterval <= _visibleRange.maximum;
        tempInterval += _visibleRange.interval) {
      labelText = pow(logBase, tempInterval).floor().toString();
      if (numberFormat != null) {
        labelText = numberFormat.format(pow(logBase, tempInterval).floor());
      }
      if (labelFormat != null && labelFormat != '') {
        labelText = labelFormat.replaceAll(RegExp('{value}'), labelText);
      }
      _triggerLabelRenderEvent(labelText, tempInterval);
    }

    /// Get the maximum label of width and height in axis.
    _calculateMaximumLabelSize(this, _chart);
  }

  /// Finds the interval of an axis.
  @override
  num calculateInterval(_VisibleRange range, Size availableSize) => null;
}
