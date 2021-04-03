part of flutter_charts;

/// Renders the data time axis.
class DateTimeAxis extends ChartAxis {
  DateTimeAxis(
      {String name,
      bool isVisible,
      AxisTitle title,
      AxisLine axisLine,
      ChartRangePadding rangePadding,
      AxisLabelIntersectAction labelIntersectAction,
      ChartDataLabelPosition labelPosition,
      TickPosition tickPosition,
      EdgeLabelPlacement edgeLabelPlacement,
      double zoomFactor,
      double zoomPosition,
      bool enableAutoIntervalOnZooming,
      int labelRotation,
      bool isInversed,
      bool opposedPosition,
      int minorTicksPerInterval,
      int maximumLabels,
      double plotOffset,
      MajorTickLines majorTickLines,
      MinorTickLines minorTickLines,
      MajorGridLines majorGridLines,
      MinorGridLines minorGridLines,
      ChartTextStyle labelStyle,
      this.dateFormat,
      DateTimeIntervalType intervalType,
      InteractiveTooltip interactiveTooltip,
      this.labelFormat,
      this.minimum,
      this.maximum,
      double interval,
      this.visibleMinimum,
      this.visibleMaximum,
      dynamic crossesAt,
      String associatedAxisName,
      bool placeLabelsNearAxisLine,
      List<PlotBand> plotBands})
      : intervalType = intervalType ?? DateTimeIntervalType.auto,
        super(
            name: name,
            isVisible: isVisible,
            isInversed: isInversed,
            opposedPosition: opposedPosition,
            rangePadding: rangePadding,
            plotOffset: plotOffset,
            labelRotation: labelRotation,
            labelIntersectAction: labelIntersectAction,
            minorTicksPerInterval: minorTicksPerInterval,
            maximumLabels: maximumLabels,
            labelStyle: labelStyle,
            title: title,
            axisLine: axisLine,
            majorTickLines: majorTickLines,
            minorTickLines: minorTickLines,
            majorGridLines: majorGridLines,
            minorGridLines: minorGridLines,
            edgeLabelPlacement: edgeLabelPlacement,
            labelPosition: labelPosition,
            tickPosition: tickPosition,
            zoomFactor: zoomFactor,
            zoomPosition: zoomPosition,
            enableAutoIntervalOnZooming: enableAutoIntervalOnZooming,
            interactiveTooltip: interactiveTooltip,
            interval: interval,
            crossesAt: crossesAt,
            associatedAxisName: associatedAxisName,
            placeLabelsNearAxisLine: placeLabelsNearAxisLine,
            plotBands: plotBands);

  ///Formats the date-time axis labels. The default data-time axis label can be formatted
  ///with various built-in date formats.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(dateFormat: DateFormat.y()),
  ///        ));
  ///}
  ///```
  final DateFormat dateFormat;

  ///Formats the date time-axis labels. The labels can be customized by adding desired
  ///text to prefix or suffix.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(labelFormat: '{value}M'),
  ///        ));
  ///}
  ///```
  final String labelFormat;

  ///Customizes the date-time axis intervals. Intervals can be set to days, hours,
  ///milliseconds, minutes, months, seconds, years, and auto. If it is set to auto,
  ///interval type will be decided based on the data.
  ///
  ///Defaults to DateTimeIntervalType.auto
  ///
  ///Also refer DateTimeIntervalType
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(intervalType: DateTimeIntervalType.years),
  ///        ));
  ///}
  ///```
  final DateTimeIntervalType intervalType;

  ///Minimum value of the axis. The axis will start from this date.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(minimum: DateTime(2000)),
  ///        ));
  ///}
  ///```
  final DateTime minimum;

  ///Maximum value of the axis. The axis will end at this date.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(maximum: DateTime(2019)),
  ///        ));
  ///}
  ///```
  final DateTime maximum;

  ///The minimum visible value of the axis. The axis will be rendered from this date initially.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           primaryXAxis: DateTimeAxis(visibleMinimum: DateTime(2000)),
  ///        ));
  ///}
  ///```
  final DateTime visibleMinimum;

  ///The maximum visible value of the axis. The axis will be rendered from this date initially.
  ///
  /// Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///          primaryXAxis: DateTimeAxis(visibleMaximum: DateTime(2019)),
  ///        ));
  ///}
  ///```
  final DateTime visibleMaximum;
  DateTimeIntervalType _actualIntervalType;
  int _dateTimeInterval;
  _VisibleRange _visibleRange;
  SfCartesianChart _chart;
  Size _axisSize;

  /// Find the series min and max values of an series
  void _findAxisMinMax(CartesianSeries<dynamic, dynamic> series) {
    List<_CartesianChartPoint<dynamic>> points;
    points = series._dataPoints;
    num _lowMin, _lowMax, _highMin, _highMax;
    for (_CartesianChartPoint<dynamic> point in points) {
      if (point.x != null) {
        point.xValue = (point.x).millisecondsSinceEpoch;
      }
      point.yValue = point.y;
      series._minimumX ??= point.xValue;
      series._maximumX ??= point.xValue;
      if (series._seriesType != 'rangecolumn') {
        series._minimumY ??= point.yValue;
        series._maximumY ??= point.yValue;
      }
      _lowMin ??= point.low;
      _lowMax ??= point.low;
      _highMin ??= point.high;
      _highMax ??= point.high;
      if (point.xValue != null) {
        series._minimumX = math.min(series._minimumX, point.xValue);
        series._maximumX = math.max(series._maximumX, point.xValue);
      }
      if (point.yValue != null) {
        series._minimumY = math.min(series._minimumY, point.yValue);
        series._maximumY = math.max(series._maximumY, point.yValue);
      }
      if (point.high != null) {
        _highMin = math.min(_highMin, point.high);
        _highMax = math.max(_highMax, point.high);
      }
      if (point.low != null) {
        _lowMin = math.min(_lowMin, point.low);
        _lowMax = math.max(_lowMax, point.low);
      }
    }
    if (series._seriesType == 'rangecolumn') {
      _lowMin ??= 0;
      _lowMax ??= 5;
      _highMin ??= 0;
      _highMax ??= 5;
      series._minimumY = math.min(_lowMin, _highMin);
      series._maximumY = math.max(_lowMax, _highMax);
    }
    series._minimumX ??= 2717008000;
    series._maximumX ??= 13085008000;
  }

  /// Calculate axis range and interval
  void _calculateRangeAndInterval(SfCartesianChart chartWidget, [String type]) {
    _chart = chartWidget;
    final Rect containerRect = _chart._chartState.containerRect;
    final Rect rect = Rect.fromLTWH(containerRect.left, containerRect.top,
        containerRect.width, containerRect.height);
    _axisSize = Size(rect.width, rect.height);
    calculateRange(this);
    _getActualRange();
    if (_actualRange != null) {
      applyRangePadding(_actualRange, _actualRange.interval);
      if (type == null && type != 'AxisCross') {
        generateVisibleLabels();
      }
    }
  }

  void _getActualRange() {
    ///When chart series is empty, Rendering default chart with below min, max
    _min ??= 2717008000;
    _max ??= 13085008000;

    _actualRange = _VisibleRange(
        minimum != null ? minimum.millisecondsSinceEpoch : _min,
        maximum != null ? maximum.millisecondsSinceEpoch : _max);
    if (_actualRange.minimum == _actualRange.maximum) {
      _actualRange.minimum = _actualRange.minimum - 2592000000;
      _actualRange.maximum = _actualRange.maximum + 2592000000;
    }
    _dateTimeInterval = _calculateDateTimeNiceInterval(this, _axisSize).floor();
    _actualRange.interval = (interval ?? _dateTimeInterval).floor();
    _actualRange.delta = _actualRange.maximum - _actualRange.minimum;
  }

  /// Applies range padding to auto, normal, additional, round, and none types.
  @override
  void applyRangePadding(_VisibleRange range, num interval) {
    _min = range.minimum.toInt();
    _max = range.maximum.toInt();
    ActualRangeChangedArgs rangeChangedArgs;
    if (minimum == null && maximum == null) {
      final ChartRangePadding rangePadding =
          _calculateRangePadding(this, _chart);
      final DateTime minimum = DateTime.fromMillisecondsSinceEpoch(_min);
      final DateTime maximum = DateTime.fromMillisecondsSinceEpoch(_max);
      if (rangePadding == ChartRangePadding.none) {
        _min = minimum.millisecondsSinceEpoch;
        _max = maximum.millisecondsSinceEpoch;
      } else if (rangePadding == ChartRangePadding.additional ||
          rangePadding == ChartRangePadding.round) {
        switch (_actualIntervalType) {
          case DateTimeIntervalType.years:
            _calculateYear(minimum, maximum, rangePadding, interval.toInt());
            break;
          case DateTimeIntervalType.months:
            _calculateMonth(minimum, maximum, rangePadding, interval.toInt());
            break;
          case DateTimeIntervalType.days:
            _calculateDay(minimum, maximum, rangePadding, interval.toInt());
            break;
          case DateTimeIntervalType.hours:
            _calculateHour(minimum, maximum, rangePadding, interval.toInt());
            break;
          case DateTimeIntervalType.minutes:
            _calculateMinute(minimum, maximum, rangePadding, interval.toInt());
            break;
          case DateTimeIntervalType.seconds:
            _calculateSecond(minimum, maximum, rangePadding, interval.toInt());
            break;
          default:
            break;
        }
      }
    }
    range.minimum = _min;
    range.maximum = _max;
    range.delta = range.maximum - range.minimum;

    calculateVisibleRange(_axisSize);

    /// Setting range as visible zoomRange
    if (visibleMinimum != null || visibleMaximum != null) {
      _visibleRange.minimum = visibleMinimum != null
          ? visibleMinimum.millisecondsSinceEpoch
          : _visibleRange.minimum;
      _visibleRange.maximum = visibleMaximum != null
          ? visibleMaximum.millisecondsSinceEpoch
          : _visibleRange.maximum;
      _visibleRange.delta = _visibleRange.maximum - _visibleRange.minimum;
      _zoomFactor = _visibleRange.delta / range.delta;
    }
    if (_chart.onActualRangeChanged != null) {
      rangeChangedArgs = ActualRangeChangedArgs();
      rangeChangedArgs.axis = this;
      rangeChangedArgs.axisName = _name;
      rangeChangedArgs.orientation = _orientation;
      rangeChangedArgs.actualMin = range.minimum;
      rangeChangedArgs.actualMax = range.maximum;
      rangeChangedArgs.actualInterval = range.interval;
      rangeChangedArgs.visibleMin = _visibleRange.minimum;
      rangeChangedArgs.visibleMax = _visibleRange.maximum;
      rangeChangedArgs.visibleInterval = _visibleRange.interval;
      _chart.onActualRangeChanged(rangeChangedArgs);
      _visibleRange.minimum = rangeChangedArgs.visibleMin is DateTime
          ? rangeChangedArgs.visibleMin.millisecondsSinceEpoch
          : rangeChangedArgs.visibleMin;
      _visibleRange.maximum = rangeChangedArgs.visibleMax is DateTime
          ? rangeChangedArgs.visibleMax.millisecondsSinceEpoch
          : rangeChangedArgs.visibleMax;
      _visibleRange.interval = rangeChangedArgs.visibleInterval;
    }
  }

  /// Calculates the visible range for an axis in chart.
  @override
  void calculateVisibleRange(Size availableSize) {
    _visibleRange = _actualRange;
    _checkWithZoomState(this, _chart._chartState.zoomedAxisStates);
    if (_zoomFactor < 1 || _zoomPosition > 0) {
      _calculateZoomRange(this, availableSize);
      _visibleRange.interval = enableAutoIntervalOnZooming
          ? calculateInterval(_visibleRange, availableSize)
          : _visibleRange.interval;
      _visibleRange.minimum = (_visibleRange.minimum).floor();
      _visibleRange.maximum = (_visibleRange.maximum).floor();
    }
  }

  /// Generates the visible axis labels.
  @override
  void generateVisibleLabels() {
    _visibleLabels = <AxisLabel>[];
    int interval = _visibleRange.minimum;
    interval = _alignRangeStart(this, interval, _visibleRange.interval);
    while (interval <= _visibleRange.maximum) {
      if (_withIn(interval, _visibleRange)) {
        final DateFormat format = dateFormat ?? _getLabelFormat(this);
        String labelText =
            format.format(DateTime.fromMillisecondsSinceEpoch(interval));
        if (labelFormat != null && labelFormat != '') {
          labelText = labelFormat.replaceAll(RegExp('{value}'), labelText);
        }
        _triggerLabelRenderEvent(labelText, interval);
      }
      interval =
          _increaseDateTimeInterval(this, interval, _visibleRange.interval)
              .millisecondsSinceEpoch;
    }
    _calculateMaximumLabelSize(this, _chart);
  }

  DateFormat _getLabelFormat(DateTimeAxis axis) {
    DateFormat format;
    switch (axis._actualIntervalType) {
      case DateTimeIntervalType.years:
        format = DateFormat.yMMM();
        break;
      case DateTimeIntervalType.months:
        format = DateFormat.MMMd();
        break;
      case DateTimeIntervalType.days:
        format = DateFormat.MMMd();
        break;
      case DateTimeIntervalType.hours:
        format = DateFormat.Hm();
        break;
      case DateTimeIntervalType.minutes:
        format = DateFormat.ms();
        break;
      case DateTimeIntervalType.seconds:
        format = DateFormat.ms();
        break;
      default:
        break;
    }
    return format;
  }

  /// Returns the range start values based on actual interval type
  int _alignRangeStart(DateTimeAxis axis, int startDate, num interval) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(startDate);
    switch (axis._actualIntervalType) {
      case DateTimeIntervalType.years:
        final int year =
            ((dateTime.year / interval).floor() * interval).floor();
        dateTime = DateTime(year, dateTime.month, dateTime.day, 0, 0, 0);
        break;
      case DateTimeIntervalType.months:
        final int month = ((dateTime.month / interval) * interval).floor();
        dateTime = DateTime(dateTime.year, month, dateTime.day, 0, 0, 0);
        break;
      case DateTimeIntervalType.days:
        final int day = ((dateTime.day / interval) * interval).floor();
        dateTime = DateTime(dateTime.year, dateTime.month, day, 0, 0, 0);
        break;
      case DateTimeIntervalType.hours:
        final int hour =
            ((dateTime.hour / interval).floor() * interval).floor();
        dateTime =
            DateTime(dateTime.year, dateTime.month, dateTime.day, hour, 0, 0);
        break;
      case DateTimeIntervalType.minutes:
        final int minute =
            ((dateTime.minute / interval).floor() * interval).floor();
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, minute, 0);
        break;
      case DateTimeIntervalType.seconds:
        final int second =
            ((dateTime.second / interval).floor() * interval).floor();
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, second);
        break;
      default:
        break;
    }
    return dateTime.millisecondsSinceEpoch;
  }

  /// Increase the range interval based on actual interval type
  DateTime _increaseDateTimeInterval(
      DateTimeAxis axis, int value, int interval) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value);
    axis._visibleRange.interval = interval;
    switch (axis._actualIntervalType) {
      case DateTimeIntervalType.years:
        dateTime = DateTime(dateTime.year + interval, dateTime.month,
            dateTime.day, dateTime.hour, dateTime.minute, dateTime.second, 0);
        break;
      case DateTimeIntervalType.months:
        dateTime = DateTime(dateTime.year, dateTime.month + interval,
            dateTime.day, dateTime.hour, dateTime.minute, dateTime.second, 0);
        break;
      case DateTimeIntervalType.days:
        dateTime = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day + interval,
            dateTime.hour,
            dateTime.minute,
            dateTime.second,
            0);
        break;
      case DateTimeIntervalType.hours:
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour + interval, dateTime.minute, dateTime.second, 0);
        break;
      case DateTimeIntervalType.minutes:
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute + interval, dateTime.second, 0);
        break;
      case DateTimeIntervalType.seconds:
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
            dateTime.hour, dateTime.minute, dateTime.second + interval, 0);
        break;
      default:
        break;
    }
    return dateTime;
  }

  /// Calculate year
  void _calculateYear(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startYear = minimum.year;
    final int endYear = maximum.year;
    if (rangePadding == ChartRangePadding.additional) {
      _min =
          DateTime(startYear - interval, 1, 1, 0, 0, 0).millisecondsSinceEpoch;
      _max = DateTime(endYear + interval, 1, 1, 0, 0, 0).millisecondsSinceEpoch;
    } else {
      _min = DateTime(startYear, 0, 0, 0, 0, 0).millisecondsSinceEpoch;
      _max = DateTime(endYear, 11, 30, 23, 59, 59).millisecondsSinceEpoch;
    }
  }

  /// Calculate month
  void _calculateMonth(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startMonth = minimum.month;
    final int endMonth = maximum.month;
    if (rangePadding == ChartRangePadding.round) {
      _min =
          DateTime(minimum.year, startMonth, 0, 0, 0, 0).millisecondsSinceEpoch;
      _max = DateTime(maximum.year, endMonth,
              DateTime(maximum.year, maximum.month, 0).day, 23, 59, 59)
          .millisecondsSinceEpoch;
    } else {
      _min = DateTime(minimum.year, startMonth + (-interval), 1, 0, 0, 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, endMonth + interval,
              endMonth == 2 ? 28 : 30, 0, 0, 0)
          .millisecondsSinceEpoch;
    }
  }

  /// Calculate day
  void _calculateDay(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startDay = minimum.day;
    final int endDay = maximum.day;
    if (rangePadding == ChartRangePadding.round) {
      _min = DateTime(minimum.year, minimum.month, startDay, 0, 0, 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, endDay, 23, 59, 59)
          .millisecondsSinceEpoch;
    } else {
      _min =
          DateTime(minimum.year, minimum.month, startDay + (-interval), 0, 0, 0)
              .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, endDay + interval, 0, 0, 0)
          .millisecondsSinceEpoch;
    }
  }

  /// Calculate hour
  void _calculateHour(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startHour = ((minimum.hour / interval) * interval).toInt();
    final int endHour = maximum.hour + (minimum.hour - startHour).toInt();
    if (rangePadding == ChartRangePadding.round) {
      _min = DateTime(minimum.year, minimum.month, minimum.day, startHour, 0, 0)
          .millisecondsSinceEpoch;
      _max =
          DateTime(maximum.year, maximum.month, maximum.day, startHour, 59, 59)
              .millisecondsSinceEpoch;
    } else {
      _min = DateTime(minimum.year, minimum.month, minimum.day,
              startHour + (-interval), 0, 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, maximum.day,
              endHour + interval, 0, 0)
          .millisecondsSinceEpoch;
    }
  }

  /// Calculate minute
  void _calculateMinute(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startMinute = ((minimum.minute / interval) * interval).toInt();
    final int endMinute =
        maximum.minute + (minimum.minute - startMinute).toInt();
    if (rangePadding == ChartRangePadding.round) {
      _min = DateTime(minimum.year, minimum.month, minimum.day, minimum.hour,
              startMinute, 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, maximum.day, maximum.hour,
              endMinute, 59)
          .millisecondsSinceEpoch;
    } else {
      _min = DateTime(minimum.year, minimum.month, minimum.day, minimum.hour,
              startMinute + (-interval), 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, maximum.day, maximum.hour,
              endMinute + interval, 0)
          .millisecondsSinceEpoch;
    }
  }

  /// Calculate second
  void _calculateSecond(DateTime minimum, DateTime maximum,
      ChartRangePadding rangePadding, int interval) {
    final int startSecond = ((minimum.second / interval) * interval).toInt();
    final int endSecond =
        maximum.second + (minimum.second - startSecond).toInt();
    if (rangePadding == ChartRangePadding.round) {
      _min = DateTime(minimum.year, minimum.month, minimum.day, minimum.hour,
              minimum.minute, startSecond, 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, maximum.day, maximum.hour,
              maximum.minute, endSecond, 0)
          .millisecondsSinceEpoch;
    } else {
      _min = DateTime(minimum.year, minimum.month, minimum.day, minimum.hour,
              minimum.minute, startSecond + (-interval), 0)
          .millisecondsSinceEpoch;
      _max = DateTime(maximum.year, maximum.month, maximum.day, maximum.hour,
              maximum.minute, endSecond + interval, 0)
          .millisecondsSinceEpoch;
    }
  }

  /// Calculate date time nice interval
  int _calculateDateTimeNiceInterval(DateTimeAxis axis, Size size) {
    final _VisibleRange range = axis._actualRange;
    const int perDay = 24 * 60 * 60 * 1000;
    final DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(range.minimum.toInt());
    final DateTime endDate =
        DateTime.fromMillisecondsSinceEpoch(range.maximum.toInt());
    num interval;
    final num totalDays =
        ((startDate.millisecondsSinceEpoch - endDate.millisecondsSinceEpoch) /
                perDay)
            .abs();
    axis._actualIntervalType = axis.intervalType;
    switch (axis.intervalType) {
      case DateTimeIntervalType.years:
        interval = _calculateNumericNiceInterval(axis, totalDays / 365, size);
        break;
      case DateTimeIntervalType.months:
        interval = _calculateNumericNiceInterval(axis, totalDays / 30, size);
        break;
      case DateTimeIntervalType.days:
        interval = _calculateNumericNiceInterval(axis, totalDays, size);
        break;
      case DateTimeIntervalType.hours:
        interval = _calculateNumericNiceInterval(axis, totalDays * 24, size);
        break;
      case DateTimeIntervalType.minutes:
        interval =
            _calculateNumericNiceInterval(axis, totalDays * 24 * 60, size);
        break;
      case DateTimeIntervalType.seconds:
        interval =
            _calculateNumericNiceInterval(axis, totalDays * 24 * 60 * 60, size);
        break;
      case DateTimeIntervalType.auto:

        /// for years
        interval = _calculateNumericNiceInterval(axis, totalDays / 365, size);
        if (interval >= 1) {
          axis._actualIntervalType = DateTimeIntervalType.years;
          return interval.floor();
        }

        /// for months
        interval = _calculateNumericNiceInterval(axis, totalDays / 30, size);
        if (interval >= 1) {
          axis._actualIntervalType = DateTimeIntervalType.months;
          return interval.floor();
        }

        /// for days
        interval = _calculateNumericNiceInterval(axis, totalDays, size);
        if (interval >= 1) {
          axis._actualIntervalType = DateTimeIntervalType.days;
          return interval.floor();
        }

        /// for hours
        interval = _calculateNumericNiceInterval(axis, totalDays * 24, size);
        if (interval >= 1) {
          axis._actualIntervalType = DateTimeIntervalType.hours;
          return interval.floor();
        }

        /// for minutes
        interval =
            _calculateNumericNiceInterval(axis, totalDays * 24 * 60, size);
        if (interval >= 1) {
          axis._actualIntervalType = DateTimeIntervalType.minutes;
          return interval.floor();
        }

        /// for seconds
        interval =
            _calculateNumericNiceInterval(axis, totalDays * 24 * 60 * 60, size);
        axis._actualIntervalType = DateTimeIntervalType.seconds;
        return interval.floor();
        break;
    }
    return interval < 1 ? interval.ceil() : interval.floor();
  }

  /// Find min and max values
  void _findMinMax(num minimumValue, num maximumValue) {
    if (_min == null || _min > minimumValue) {
      _min = minimumValue;
    }
    if (_max == null || _max < maximumValue) {
      _max = maximumValue;
    }
  }

  /// Finds the interval of an axis.
  @override
  num calculateInterval(_VisibleRange range, Size availableSize) =>
      _calculateDateTimeNiceInterval(this, _axisSize).floor();
}
