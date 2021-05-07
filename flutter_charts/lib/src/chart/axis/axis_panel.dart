part of flutter_charts;

class _ChartAxis {
  _ChartAxis() {
    _innerPadding = 5;
    _axisPadding = 10;
    _axisClipRect = const Rect.fromLTRB(0, 0, 0, 0);
    _verticalAxes = <ChartAxis>[];
    _horizontalAxes = <ChartAxis>[];
    _needsRepaint = true;
  }
  SfCartesianChart _chartWidget;
  List<ChartAxis> _leftAxes = <ChartAxis>[];
  List<ChartAxis> _rightAxes = <ChartAxis>[];
  List<ChartAxis> _topAxes = <ChartAxis>[];
  List<ChartAxis> _bottomAxes = <ChartAxis>[];
  List<_AxisSize> _leftAxesCount;
  List<_AxisSize> _bottomAxesCount;
  List<_AxisSize> _topAxesCount;
  List<_AxisSize> _rightAxesCount;
  double _bottomSize = 0;
  double _topSize = 0;
  double _leftSize = 0;
  double _rightSize = 0;
  num _innerPadding = 0;
  num _axisPadding = 0;
  Rect _axisClipRect;
  List<ChartAxis> _verticalAxes = <ChartAxis>[];
  List<ChartAxis> _horizontalAxes = <ChartAxis>[];
  List<ChartAxis> _axisCollections = <ChartAxis>[];

  /// Whether to repaint axis or not
  bool _needsRepaint;

  void _axisCrossing(ChartAxis axis) {
    if (axis.crossesAt != null) {
      if (axis.associatedAxisName != null) {
        for (int i = 0;
            i < _chartWidget._chartAxis._axisCollections.length;
            i++) {
          if (axis.associatedAxisName ==
              _chartWidget._chartAxis._axisCollections[i]._name) {
            axis._crossAxis = _chartWidget._chartAxis._axisCollections[i];
            _getCrossingValues(axis, axis._crossAxis);
          }
        }
      } else {
        axis._crossAxis = _chartWidget._requireInvertedAxis
            ? (axis._crossAxis = axis._orientation == AxisOrientation.horizontal
                ? _chartWidget.primaryXAxis
                : _chartWidget.primaryYAxis)
            : (axis._orientation == AxisOrientation.horizontal
                ? _chartWidget.primaryYAxis
                : _chartWidget.primaryXAxis);

        _getCrossingValues(axis, axis._crossAxis);
      }
    }
  }

  ///To get the axis crossing value
  void _getCrossingValues(ChartAxis currentAxis, ChartAxis targetAxis) {
    dynamic value = currentAxis.crossesAt;
    value = value is String && num.tryParse(value) != null
        ? num.tryParse(value)
        : value;
    if (targetAxis is DateTimeAxis) {
      value = value is DateTime ? value.millisecondsSinceEpoch : value;
      targetAxis._calculateRangeAndInterval(_chartWidget, 'AxisCross');
    } else if (targetAxis is CategoryAxis) {
      value = value is num ? value.floor() : targetAxis._labels.indexOf(value);
      targetAxis._calculateRangeAndInterval(_chartWidget, 'AxisCross');
    } else if (targetAxis is LogarithmicAxis) {
      value = _logBase(value, targetAxis.logBase);
      targetAxis._calculateRangeAndInterval(_chartWidget, 'AxisCross');
    } else if (targetAxis is NumericAxis) {
      targetAxis._calculateRangeAndInterval(_chartWidget, 'AxisCross');
    }
    if (!value.isNaN) {
      currentAxis._crossValue =
          _updateCrossValue(value, targetAxis._visibleRange);
      currentAxis._crossRange = targetAxis._visibleRange;
    }
  }

  ///To measure the bounds of each axis
  void _measureAxesBounds() {
    _bottomSize = 0;
    _topSize = 0;
    _leftSize = 0;
    _rightSize = 0;
    _leftAxesCount = <_AxisSize>[];
    _bottomAxesCount = <_AxisSize>[];
    _topAxesCount = <_AxisSize>[];
    _rightAxesCount = <_AxisSize>[];
    _bottomAxes = <ChartAxis>[];
    _rightAxes = <ChartAxis>[];
    _topAxes = <ChartAxis>[];
    _leftAxes = <ChartAxis>[];

    if (_verticalAxes.isNotEmpty) {
      for (int axisIndex = 0; axisIndex < _verticalAxes.length; axisIndex++) {
        final dynamic axis = _verticalAxes[axisIndex];
        axis._calculateRangeAndInterval(_chartWidget);
        _axisCrossing(axis);
        _measureAxesSize(axis);
      }
      _calculateSeriesClipRect();
    }
    if (_horizontalAxes.isNotEmpty) {
      for (int axisIndex = 0; axisIndex < _horizontalAxes.length; axisIndex++) {
        final dynamic axis = _horizontalAxes[axisIndex];
        _calculateLabelRotationAngle(axis);
        axis._calculateRangeAndInterval(_chartWidget);
        _axisCrossing(axis);
        _measureAxesSize(axis);
      }
    }
    _calculateAxesRect();
  }

  ///Calculate the axes total size
  void _measureAxesSize(ChartAxis axis) {
    num titleSize = 0;
    axis._totalSize = 0;
    if (axis.isVisible) {
      if (axis.title.text != null && axis.title.text.isNotEmpty) {
        titleSize = _measureText(axis.title.text, axis.title.textStyle).height +
            _axisPadding;
      }
      final Rect rect = _chartWidget._chartState.containerRect;
      final int axisIndex = _getAxisIndex(axis);
      final double tickSize =
          (axisIndex == 0 && axis.tickPosition == TickPosition.inside)
              ? 0
              : math.max(
                      axis.majorTickLines.size,
                      axis.minorTicksPerInterval > 0
                          ? axis.minorTickLines.size
                          : 0) +
                  _innerPadding;
      final double labelSize = (axisIndex == 0 &&
              axis.labelPosition == ChartDataLabelPosition.inside)
          ? 0
          : ((axis._orientation == AxisOrientation.horizontal)
                  ? axis._maximumLabelSize.height
                  : axis._maximumLabelSize.width) +
              _innerPadding;

      axis._totalSize = titleSize + tickSize + labelSize;
      if (axis._orientation == AxisOrientation.horizontal) {
        if (!axis.opposedPosition) {
          axis._totalSize +=
              _bottomAxes.isNotEmpty ? _axisPadding.toDouble() : 0;
          if (axis._crossValue != null && axis._crossRange != null) {
            final num crosPosition =
                _valueToCoefficient(axis._crossValue, axis._crossAxis) *
                    rect.height;
            axis._totalSize = crosPosition - axis._totalSize < 0
                ? (crosPosition - axis._totalSize).abs()
                : !axis.placeLabelsNearAxisLine ? labelSize : 0;
          }
          _bottomSize += axis._totalSize;
          _bottomAxesCount.add(_AxisSize(axis, axis._totalSize));
        } else {
          axis._totalSize += _topAxes.isNotEmpty ? _axisPadding.toDouble() : 0;
          if (axis._crossValue != null && axis._crossRange != null) {
            final num crosPosition =
                _valueToCoefficient(axis._crossValue, axis._crossAxis) *
                    rect.height;
            axis._totalSize = crosPosition + axis._totalSize > rect.height
                ? ((crosPosition + axis._totalSize) - rect.height).abs()
                : !axis.placeLabelsNearAxisLine ? labelSize : 0;
          }
          _topSize += axis._totalSize;
          _topAxesCount.add(_AxisSize(axis, axis._totalSize));
        }
      } else if (axis._orientation == AxisOrientation.vertical) {
        if (!axis.opposedPosition) {
          axis._totalSize += _leftAxes.isNotEmpty ? _axisPadding.toDouble() : 0;
          if (axis._crossValue != null && axis._crossRange != null) {
            final num crosPosition =
                _valueToCoefficient(axis._crossValue, axis._crossAxis) *
                    rect.width;
            axis._totalSize = crosPosition - axis._totalSize < 0
                ? (crosPosition - axis._totalSize).abs()
                : !axis.placeLabelsNearAxisLine ? labelSize : 0;
          }
          _leftSize += axis._totalSize;
          _leftAxesCount.add(_AxisSize(axis, axis._totalSize));
        } else {
          axis._totalSize +=
              _rightAxes.isNotEmpty ? _axisPadding.toDouble() : 0;
          if (axis._crossValue != null && axis._crossRange != null) {
            final num crosPosition =
                _valueToCoefficient(axis._crossValue, axis._crossAxis) *
                    rect.width;
            axis._totalSize = crosPosition + axis._totalSize > rect.width
                ? ((crosPosition + axis._totalSize) - rect.width).abs()
                : !axis.placeLabelsNearAxisLine ? labelSize : 0;
          }
          _rightSize += axis._totalSize;
          _rightAxesCount.add(_AxisSize(axis, axis._totalSize));
        }
      }
    }
  }

  int _getAxisIndex(ChartAxis axis) {
    int index;
    if (axis._orientation == AxisOrientation.horizontal) {
      if (!axis.opposedPosition) {
        _bottomAxes.add(axis);
        index = _bottomAxes.length;
      } else {
        _topAxes.add(axis);
        index = _topAxes.length;
      }
    } else if (axis._orientation == AxisOrientation.vertical) {
      if (!axis.opposedPosition) {
        _leftAxes.add(axis);
        index = _leftAxes.length;
      } else {
        _rightAxes.add(axis);
        index = _rightAxes.length;
      }
    }
    return index - 1;
  }

  ///To find the axis label rotataion angle
  void _calculateLabelRotationAngle(ChartAxis axis) {
    int angle = axis._labelRotation;
    if (angle < -360 || angle > 360) {
      angle %= 360;
    }
    if (angle.isNegative) {
      angle = angle + 360;
    }
    axis._labelRotation = angle;
  }

  /// Calculate series clip rect size
  void _calculateSeriesClipRect() {
    final Rect containerRect = _chartWidget._chartState.containerRect;
    final num padding =
        _chartWidget.title.text != null && _chartWidget.title.text.isNotEmpty
            ? 10
            : 0;
    _chartWidget._chartAxis._axisClipRect = Rect.fromLTWH(
        containerRect.left + _leftSize,
        containerRect.top + _topSize + padding,
        containerRect.width - _leftSize - _rightSize,
        containerRect.height - _topSize - _bottomSize - padding);
  }

  num _updateCrossValue(num value, dynamic range) {
    if (value < range.minimum) {
      value = range.minimum;
    }
    if (value > range.maximum) {
      value = range.maximum;
    }
    return value;
  }

  num _getPrevAxisOffset(
      List<_AxisSize> axesSize, Rect rect, int currentAxisIndex, String type) {
    num prevAxisOffsetValue;
    if (currentAxisIndex > 0) {
      for (int i = currentAxisIndex - 1; i >= 0; i--) {
        final ChartAxis axis = axesSize[i].axis;
        final Rect bounds = axis._bounds;
        if (type == 'Left' &&
            ((axis._labelOffset != null
                    ? axis._labelOffset - axis._maximumLabelSize.width
                    : bounds.left - bounds.width) <
                rect.left)) {
          prevAxisOffsetValue = axis._labelOffset != null
              ? axis._labelOffset - axis._maximumLabelSize.width
              : bounds.left - bounds.width;
          break;
        } else if (type == 'Bottom' &&
            ((axis._labelOffset != null
                    ? axis._labelOffset + axis._maximumLabelSize.height
                    : bounds.top + bounds.height) >
                rect.top + rect.height)) {
          prevAxisOffsetValue = axis._labelOffset != null
              ? axis._labelOffset + axis._maximumLabelSize.height
              : bounds.top + bounds.height;
          break;
        } else if (type == 'Right' &&
            ((axis._labelOffset != null
                    ? axis._labelOffset + axis._maximumLabelSize.width
                    : bounds.left + bounds.width) >
                rect.left + rect.width)) {
          prevAxisOffsetValue = axis._labelOffset != null
              ? axis._labelOffset + axis._maximumLabelSize.width
              : bounds.left + bounds.width;
          break;
        } else if (type == 'Top' &&
            ((axis._labelOffset != null
                    ? axis._labelOffset - axis._maximumLabelSize.height
                    : bounds.top - bounds.height) <
                rect.top)) {
          prevAxisOffsetValue = axis._labelOffset != null
              ? axis._labelOffset - axis._maximumLabelSize.height
              : bounds.top - bounds.height;
          break;
        }
      }
    }
    return prevAxisOffsetValue;
  }

  /// Calculate axes bounds based on all axes
  void _calculateAxesRect() {
    num axisSize, height, width, axesLength, axisIndex;
    _calculateSeriesClipRect();
    Rect rect = _chartWidget._chartAxis._axisClipRect;

    /// Calculate the left axes rect
    if (_leftAxesCount.isNotEmpty) {
      axesLength = _leftAxesCount.length;
      for (axisIndex = 0; axisIndex < axesLength; axisIndex++) {
        width = _leftAxesCount[axisIndex].size;
        final ChartAxis axis = _leftAxesCount[axisIndex].axis;
        if (axis._crossValue != null) {
          axisSize = (_valueToCoefficient(axis._crossValue, axis._crossAxis) *
                  rect.width) +
              rect.left;
          if (axisIndex == 0 && !axis.placeLabelsNearAxisLine) {
            axis._labelOffset = rect.left - 5;
          }
        } else {
          final num prevAxisOffsetValue =
              _getPrevAxisOffset(_leftAxesCount, rect, axisIndex, 'Left');
          axisSize = prevAxisOffsetValue == null
              ? rect.left
              : (prevAxisOffsetValue -
                      (axis.labelPosition == ChartDataLabelPosition.inside
                          ? (_innerPadding + axis._maximumLabelSize.width)
                          : 0)) -
                  (axis.tickPosition == TickPosition.inside
                      ? math.max(
                          axis.majorTickLines.size,
                          axis.minorTicksPerInterval > 0
                              ? axis.minorTickLines.size
                              : 0)
                      : 0) -
                  _axisPadding;
        }
        axis._bounds = Rect.fromLTWH(axisSize, rect.top + axis.plotOffset,
            width, rect.height - 2 * axis.plotOffset);
      }
    }

    /// Calculate the bottom axes rect
    if (_bottomAxesCount.isNotEmpty) {
      rect = _chartWidget._chartAxis._axisClipRect;
      axesLength = _bottomAxesCount.length;
      for (axisIndex = 0; axisIndex < axesLength; axisIndex++) {
        height = _bottomAxesCount[axisIndex].size;
        final ChartAxis axis = _bottomAxesCount[axisIndex].axis;
        if (axis._crossValue != null) {
          axisSize = rect.top +
              rect.height -
              (_valueToCoefficient(axis._crossValue, axis._crossAxis) *
                  rect.height);
          if (axisIndex == 0 && !axis.placeLabelsNearAxisLine) {
            axis._labelOffset = rect.top + rect.height + 5;
          }
        } else {
          final num prevAxisOffsetValue =
              _getPrevAxisOffset(_bottomAxesCount, rect, axisIndex, 'Bottom');
          axisSize = (prevAxisOffsetValue == null)
              ? rect.top + rect.height
              : _axisPadding +
                  prevAxisOffsetValue +
                  (axis.labelPosition == ChartDataLabelPosition.inside
                      ? (_innerPadding + axis._maximumLabelSize.height)
                      : 0) +
                  (axis.tickPosition == TickPosition.inside
                      ? math.max(
                          axis.majorTickLines.size,
                          axis.minorTicksPerInterval > 0
                              ? axis.minorTickLines.size
                              : 0)
                      : 0);
        }
        axis._bounds = Rect.fromLTWH(rect.left + axis.plotOffset, axisSize,
            rect.width - 2 * axis.plotOffset, height);
      }
    }

    /// Calculate the right axes rect
    if (_rightAxesCount.isNotEmpty) {
      axesLength = _rightAxesCount.length;
      for (axisIndex = 0; axisIndex < axesLength; axisIndex++) {
        final ChartAxis axis = _rightAxesCount[axisIndex].axis;
        width = _rightAxesCount[axisIndex].size;
        if (axis._crossValue != null) {
          axisSize = rect.left +
              (_valueToCoefficient(axis._crossValue, axis._crossAxis) *
                  rect.width);
          if (axisIndex == 0 && !axis.placeLabelsNearAxisLine) {
            axis._labelOffset = rect.left + rect.width + 5;
          }
        } else {
          final num prevAxisOffsetValue =
              _getPrevAxisOffset(_rightAxesCount, rect, axisIndex, 'Right');
          axisSize = (prevAxisOffsetValue == null)
              ? rect.left + rect.width
              : (prevAxisOffsetValue +
                      (axis.labelPosition == ChartDataLabelPosition.inside
                          ? axis._maximumLabelSize.width + _innerPadding
                          : 0)) +
                  (axis.tickPosition == TickPosition.inside
                      ? math.max(
                          axis.majorTickLines.size,
                          axis.minorTicksPerInterval > 0
                              ? axis.minorTickLines.size
                              : 0)
                      : 0) +
                  _axisPadding;
        }
        axis._bounds = Rect.fromLTWH(axisSize, rect.top + axis.plotOffset,
            width, rect.height - 2 * axis.plotOffset);
      }
    }

    /// Calculate the top axes rect
    if (_topAxesCount.isNotEmpty) {
      axesLength = _topAxesCount.length;
      for (axisIndex = 0; axisIndex < axesLength; axisIndex++) {
        final ChartAxis axis = _topAxesCount[axisIndex].axis;
        height = _topAxesCount[axisIndex].size;
        if (axis._crossValue != null) {
          axisSize = rect.top +
              rect.height -
              (_valueToCoefficient(axis._crossValue, axis._crossAxis) *
                  rect.height);
          if (axisIndex == 0 && !axis.placeLabelsNearAxisLine) {
            axis._labelOffset = rect.top - 5;
          }
        } else {
          final num prevAxisOffsetValue =
              _getPrevAxisOffset(_topAxesCount, rect, axisIndex, 'Top');
          axisSize = (prevAxisOffsetValue == null)
              ? rect.top
              : prevAxisOffsetValue -
                  (axis.labelPosition == ChartDataLabelPosition.inside
                      ? (_axisPadding + axis._maximumLabelSize.height)
                      : 0) -
                  (axis.tickPosition == TickPosition.inside
                      ? math.max(
                          axis.majorTickLines.size,
                          axis.minorTicksPerInterval > 0
                              ? axis.minorTickLines.size
                              : 0)
                      : 0) -
                  _axisPadding;
        }
        axis._bounds = Rect.fromLTWH(rect.left + axis.plotOffset, axisSize,
            rect.width - 2 * axis.plotOffset, height);
      }
    }
  }

  /// Calculate the visible axes
  void _calculateVisibleAxes() {
    _innerPadding = _chartWidget.borderWidth;
    _axisPadding = 5;
    _axisClipRect = const Rect.fromLTRB(0, 0, 0, 0);
    _verticalAxes = <ChartAxis>[];
    _horizontalAxes = <ChartAxis>[];
    _chartWidget.primaryXAxis._name =
        (_chartWidget.primaryXAxis._name) ?? 'primaryXAxis';
    _chartWidget.primaryYAxis._name =
        _chartWidget.primaryYAxis._name ?? 'primaryYAxis';
    _axisCollections = <ChartAxis>[
      _chartWidget.primaryXAxis,
      _chartWidget.primaryYAxis
    ];
    final List<CartesianSeries<dynamic, dynamic>> visibleSeries =
        _chartWidget._chartSeries.visibleSeries;
    if (visibleSeries.isNotEmpty) {
      if (_chartWidget.axes.isNotEmpty) {
        _axisCollections.addAll(_chartWidget.axes);
      }
      for (int axisIndex = 0;
          axisIndex < _axisCollections.length;
          axisIndex++) {
        final ChartAxis axis = _axisCollections[axisIndex];
        if (axis is CategoryAxis) {
          axis._labels = <dynamic>[];
        }
        axis._series = <CartesianSeries<dynamic, dynamic>>[];
        for (int seriesIndex = 0;
            seriesIndex < visibleSeries.length;
            seriesIndex++) {
          final XyDataSeries<dynamic, dynamic> series =
              visibleSeries[seriesIndex];
          if ((axis._name != null && axis._name == series.xAxisName) ||
              (series.xAxisName == null &&
                  axis._name == _chartWidget.primaryXAxis._name) ||
              (series.xAxisName != null &&
                  axis._name != series.xAxisName &&
                  axis._name == _chartWidget.primaryXAxis._name)) {
            axis._orientation = _chartWidget._requireInvertedAxis
                ? AxisOrientation.vertical
                : AxisOrientation.horizontal;
            series._xAxis = axis;
            axis._series.add(series);
          } else if ((axis._name != null && series.yAxisName == axis._name) ||
              (series.yAxisName == null &&
                  axis._name == _chartWidget.primaryYAxis._name) ||
              (series.yAxisName != null &&
                  axis._name != series.yAxisName &&
                  axis._name == _chartWidget.primaryYAxis._name)) {
            axis._orientation = _chartWidget._requireInvertedAxis
                ? AxisOrientation.horizontal
                : AxisOrientation.vertical;
            series._yAxis = axis;
            axis._series.add(series);
          }
        }
        if (axis._orientation != null) {
          axis._orientation == AxisOrientation.vertical
              ? _verticalAxes.add(axis)
              : _horizontalAxes.add(axis);
        }
      }
    } else {
      _chartWidget.primaryXAxis._orientation = _chartWidget._requireInvertedAxis
          ? AxisOrientation.vertical
          : AxisOrientation.horizontal;
      _chartWidget.primaryYAxis._orientation = _chartWidget._requireInvertedAxis
          ? AxisOrientation.horizontal
          : AxisOrientation.vertical;
      _horizontalAxes.add(_chartWidget.primaryXAxis);
      _verticalAxes.add(_chartWidget.primaryYAxis);
      if (_chartWidget.axes != null) {
        _axisCollections.addAll(_chartWidget.axes);
      }
    }
  }
}
