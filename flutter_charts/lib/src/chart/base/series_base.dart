part of flutter_charts;

class _ChartSeries {
  _ChartSeries();
  SfCartesianChart chart;

  /// Contains the visible series for chart
  List<ChartSeries<dynamic, dynamic>> visibleSeries;
  List<_ClusterStackedItemInfo> clusterStackedItemInfo;

  void processData() {
    final List<ChartSeries<dynamic, dynamic>> seriesList = visibleSeries;
    _findAreaType();
    _populateDataPoints(seriesList);
    for (ChartSeries<dynamic, dynamic> series in seriesList) {
      _setSeriesType(series);

      /// Calculate empty point
      _calculateEmptyPoints(series);
    }
    chart._chartAxis?._calculateVisibleAxes();
    _findSeriesMinMax(seriesList);
  }

  /// Find the data points for each series
  void _populateDataPoints(List<CartesianSeries<dynamic, dynamic>> seriesList) {
    for (CartesianSeries<dynamic, dynamic> series in seriesList) {
      final dynamic xValue = series.xValueMapper;
      final dynamic yValue = series.yValueMapper;
      final dynamic sortField = series.sortFieldValueMapper;
      final dynamic _pointColor = series.pointColorMapper;
      final dynamic _bubbleSize = series.sizeValueMapper;
      final dynamic _pointText = series.dataLabelMapper;
      final dynamic _highValue = series.highValueMapper;
      final dynamic _lowValue = series.lowValueMapper;

      series._dataPoints = <_CartesianChartPoint<dynamic>>[];
      if (series.dataSource != null) {
        for (int pointIndex = 0;
            pointIndex < series.dataSource.length;
            pointIndex++) {
          final dynamic xVal = xValue(pointIndex);
          final dynamic yVal =
              series is RangeColumnSeries ? null : yValue(pointIndex);
          if (xVal != null) {
            dynamic sortVal,
                pointColor,
                bubbleSize,
                pointText,
                highValue,
                lowValue;
            if (series.sortFieldValueMapper != null) {
              sortVal = sortField(pointIndex);
            }
            series._dataPoints.add(_CartesianChartPoint<dynamic>(xVal, yVal));
            if (series.sizeValueMapper != null) {
              bubbleSize = _bubbleSize(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].bubbleSize =
                  (bubbleSize != null) ? bubbleSize.toDouble() : bubbleSize;
            }
            if (series.pointColorMapper != null) {
              pointColor = _pointColor(pointIndex);
              series._dataPoints[series._dataPoints.length - 1]
                  .pointColorMapper = pointColor;
            }
            if (series.dataLabelMapper != null) {
              pointText = _pointText(pointIndex);
              series._dataPoints[series._dataPoints.length - 1]
                  .dataLabelMapper = pointText;
            }

            /// for range series
            if (series.highValueMapper != null) {
              highValue = _highValue(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].high =
                  highValue;
            }
            if (series.lowValueMapper != null) {
              lowValue = _lowValue(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].low = lowValue;
            }

            if (series.sortingOrder != SortingOrder.none && sortVal != null)
              series._dataPoints[series._dataPoints.length - 1].sortValue =
                  sortVal;
          }
        }
        if (series.sortingOrder != SortingOrder.none &&
            series.sortFieldValueMapper != null) {
          _sortDataSource(series);
        }
      }
    }
  }

  /// Sort the datasource
  void _sortDataSource(CartesianSeries<dynamic, dynamic> series) {
    series._dataPoints.sort(
        // ignore: missing_return
        (_CartesianChartPoint<dynamic> firstPoint,
            _CartesianChartPoint<dynamic> secondPoint) {
      if (series.sortingOrder == SortingOrder.ascending) {
        return (firstPoint.sortValue == null)
            ? -1
            : (secondPoint.sortValue == null
                ? 1
                : (firstPoint.sortValue is String
                    ? firstPoint.sortValue
                        .toLowerCase()
                        .compareTo(secondPoint.sortValue.toLowerCase())
                    : firstPoint.sortValue.compareTo(secondPoint.sortValue)));
      } else if (series.sortingOrder == SortingOrder.descending) {
        return (firstPoint.sortValue == null)
            ? 1
            : (secondPoint.sortValue == null
                ? -1
                : (firstPoint.sortValue is String
                    ? secondPoint.sortValue
                        .toLowerCase()
                        .compareTo(firstPoint.sortValue.toLowerCase())
                    : secondPoint.sortValue.compareTo(firstPoint.sortValue)));
      }
    });
  }

  void _findSeriesMinMax(List<CartesianSeries<dynamic, dynamic>> seriesList) {
    for (CartesianSeries<dynamic, dynamic> series in seriesList) {
      final dynamic axis = series._xAxis;
      if (axis is NumericAxis) {
        axis._findAxisMinMax(series);
      } else if (axis is CategoryAxis) {
        axis._findAxisMinMax(series);
      } else if (axis is DateTimeAxis) {
        axis._findAxisMinMax(series);
      } else {
        axis._findAxisMinMax(series);
      }
      if (series._seriesType == 'stackedcolumn' ||
          series._seriesType == 'stackedbar' ||
          series._seriesType == 'stackedarea' ||
          series._seriesType == 'stackedline') {
        if (series._dataPoints.isNotEmpty)
          _calculateStackedValues(_findSeriesCollection(chart));
      }
    }
  }

  void _calculateStackedValues(
      List<CartesianSeries<dynamic, dynamic>> seriesCollection) {
    String groupName = ' ';
    num lastValue, value;
    _CartesianChartPoint<dynamic> point;
    List<_StackingInfo> positiveValues;
    List<_StackingInfo> negativeValues;
    List<double> startValues;
    List<double> endValues;
    chart._chartSeries.clusterStackedItemInfo = <_ClusterStackedItemInfo>[];
    for (int i = 0; i < seriesCollection.length; i++) {
      final CartesianSeries<dynamic, dynamic> series = seriesCollection[i];
      if (series is _StackedSeriesBase) {
        if (series._dataPoints.isNotEmpty) {
          groupName = (series._seriesType == 'stackedarea')
              ? 'stackedareagroup'
              : (series.groupName ?? 'series ' + i.toString());
          final _StackedItemInfo stackedItemInfo = _StackedItemInfo(i, series);
          if (chart._chartSeries.clusterStackedItemInfo.isNotEmpty) {
            for (int k = 0;
                k < chart._chartSeries.clusterStackedItemInfo.length;
                k++) {
              final _ClusterStackedItemInfo clusterStackedItemInfo =
                  chart._chartSeries.clusterStackedItemInfo[k];
              if (clusterStackedItemInfo.stackName == groupName) {
                clusterStackedItemInfo.stackedItemInfo.add(stackedItemInfo);
                break;
              } else if (k ==
                  chart._chartSeries.clusterStackedItemInfo.length - 1) {
                chart._chartSeries.clusterStackedItemInfo.add(
                    _ClusterStackedItemInfo(
                        groupName, <_StackedItemInfo>[stackedItemInfo]));
                break;
              }
            }
          } else {
            chart._chartSeries.clusterStackedItemInfo.add(
                _ClusterStackedItemInfo(
                    groupName, <_StackedItemInfo>[stackedItemInfo]));
          }

          startValues = <double>[];
          endValues = <double>[];
          series._stackingValues = <_StackedValues>[];
          _StackingInfo currentPositiveStackInfo, currentNegativeStackInfo;

          if (positiveValues == null || negativeValues == null) {
            positiveValues = <_StackingInfo>[];
            currentPositiveStackInfo = _StackingInfo(groupName, <double>[]);
            positiveValues.add(currentPositiveStackInfo);
            negativeValues = <_StackingInfo>[];
            negativeValues.add(_StackingInfo(groupName, <double>[]));
          }

          for (int j = 0; j < series._dataPoints.length; j++) {
            point = series._dataPoints[j];
            value = point.y;
            if (positiveValues.isNotEmpty) {
              for (int k = 0; k < positiveValues.length; k++) {
                if (groupName == positiveValues[k].groupName) {
                  currentPositiveStackInfo = positiveValues[k];
                  break;
                } else if (k == positiveValues.length - 1) {
                  currentPositiveStackInfo =
                      _StackingInfo(groupName, <double>[]);
                  positiveValues.add(currentPositiveStackInfo);
                }
              }
            }

            if (negativeValues.isNotEmpty) {
              for (int k = 0; k < negativeValues.length; k++) {
                if (groupName == negativeValues[k].groupName) {
                  currentNegativeStackInfo = negativeValues[k];
                  break;
                } else if (k == negativeValues.length - 1) {
                  currentNegativeStackInfo =
                      _StackingInfo(groupName, <double>[]);
                  negativeValues.add(currentNegativeStackInfo);
                }
              }
            }
            dynamic isExistValue;
            try {
              isExistValue =
                  currentPositiveStackInfo._stackingValues.elementAt(j);
            } catch (e) {
              if (isExistValue == null) {
                currentPositiveStackInfo._stackingValues.add(0);
              }
            }

            try {
              isExistValue =
                  currentNegativeStackInfo._stackingValues.elementAt(j);
            } catch (e) {
              if (isExistValue == null) {
                currentNegativeStackInfo._stackingValues.add(0);
              }
            }
            if (value > 0) {
              lastValue = currentPositiveStackInfo._stackingValues[j];
              currentPositiveStackInfo._stackingValues[j] = lastValue + value;
            } else {
              lastValue = currentNegativeStackInfo._stackingValues[j];
              currentNegativeStackInfo._stackingValues[j] = lastValue + value;
            }
            startValues.add(lastValue.toDouble());
            endValues.add(value + lastValue);
            point.cumulativeValue = endValues[j];
          }
          series._stackingValues.add(_StackedValues(startValues, endValues));
          series._maximumY = endValues.reduce(max);
          series._minimumY = endValues.reduce(min);
        }
      }
    }
  }

  /// Calculate area type
  void _findAreaType() {
    if (visibleSeries.isNotEmpty) {
      final bool isBarSeries =
          visibleSeries[0].runtimeType.toString().contains('Bar');
      chart._requireInvertedAxis =
          (chart.isTransposed != true && isBarSeries) ||
              ((chart.isTransposed == true) && (isBarSeries == false));
    } else {
      chart._requireInvertedAxis = chart.isTransposed;
    }
  }

  void _setSeriesType(CartesianSeries<dynamic, dynamic> series) {
    if (series is AreaSeries)
      series._seriesType = 'area';
    else if (series is BarSeries)
      series._seriesType = 'bar';
    else if (series is BubbleSeries)
      series._seriesType = 'bubble';
    else if (series is ColumnSeries)
      series._seriesType = 'column';
    else if (series is FastLineSeries)
      series._seriesType = 'fastline';
    else if (series is LineSeries)
      series._seriesType = 'line';
    else if (series is ScatterSeries)
      series._seriesType = 'scatter';
    else if (series is SplineSeries)
      series._seriesType = 'spline';
    else if (series is StepLineSeries)
      series._seriesType = 'stepline';
    else if (series is StackedColumnSeries)
      series._seriesType = 'stackedcolumn';
    else if (series is StackedBarSeries)
      series._seriesType = 'stackedbar';
    else if (series is StackedAreaSeries)
      series._seriesType = 'stackedarea';
    else if (series is StackedLineSeries)
      series._seriesType = 'stackedline';
    else if (series is RangeColumnSeries) 
      series._seriesType = 'rangecolumn';
  }
}
