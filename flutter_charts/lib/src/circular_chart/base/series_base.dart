part of flutter_charts;

class _CircularSeries {
  _CircularSeries();

  SfCircularChart chart;

  CircularSeries<dynamic, dynamic> currentSeries;

  num size;

  num sumOfGroup;

  _Region explodedRegion;

  _Region selectRegion;

  List<CircularSeries<dynamic, dynamic>> visibleSeries;

  void _findVisibleSeries() {
    visibleSeries = <CircularSeries<dynamic, dynamic>>[];
    for (CircularSeries<dynamic, dynamic> series in chart.series) {
      _setSeriesType(series);
      final dynamic xValue = series.xValueMapper;
      final dynamic yValue = series.yValueMapper;
      final dynamic sortField = series.sortFieldValueMapper;
      final dynamic _radius = series.pointRadiusMapper;
      final dynamic _color = series.pointColorMapper;
      series._dataPoints = <_ChartPoint<dynamic>>[];
      if (series.dataSource != null) {
        for (int pointIndex = 0;
            pointIndex < series.dataSource.length;
            pointIndex++) {
          dynamic sortVal;
          if (xValue(pointIndex) != null) {
            dynamic radius, color;
            if (series.sortFieldValueMapper != null) {
              sortVal = sortField(pointIndex);
            }
            series._dataPoints.add(
                _ChartPoint<dynamic>(xValue(pointIndex), yValue(pointIndex)));
            if (series.pointRadiusMapper != null) {
              radius = _radius(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].radius = radius;
            }
            if (series.pointColorMapper != null) {
              color = _color(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].pointColor =
                  color;
            }
            if (series.sortingOrder != SortingOrder.none && sortVal != null)
              series._dataPoints[series._dataPoints.length - 1].sortValue =
                  sortVal;
          }
        }
      }
      if (series.sortingOrder != SortingOrder.none &&
          series.sortFieldValueMapper != null) {
        _sortDataSource(series);
      }
      visibleSeries.add(series);
      break;
    }
  }

  void _processDataPoints() {
    for (CircularSeries<dynamic, dynamic> series in visibleSeries) {
      currentSeries = series;
      _setEmptyPoint();
      _findGroupPoints();
    }
  }

  /// Sort the datasource
  void _sortDataSource(CircularSeries<dynamic, dynamic> series) {
    series._dataPoints.sort(
        // ignore: missing_return
        (_ChartPoint<dynamic> firstPoint, _ChartPoint<dynamic> secondPoint) {
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

  void _setEmptyPoint() {
    final EmptyPointSettings empty = currentSeries.emptyPointSettings;
    final int pointLength = currentSeries._dataPoints.length;
    for (int pointIndex = 0; pointIndex < pointLength; pointIndex++) {
      final _ChartPoint<dynamic> point = currentSeries._dataPoints[pointIndex];
      if (point.y == null) {
        switch (empty.mode) {
          case EmptyPointMode.average:
            final num previous = pointIndex - 1 >= 0
                ? currentSeries._dataPoints[pointIndex - 1].y == null
                    ? 0
                    : currentSeries._dataPoints[pointIndex - 1].y
                : 0;
            final num next = pointIndex + 1 <= pointLength - 1
                ? currentSeries._dataPoints[pointIndex + 1].y == null
                    ? 0
                    : currentSeries._dataPoints[pointIndex + 1].y
                : 0;
            point.y = (previous + next).abs() / 2;
            point.isVisible = true;
            point.isEmpty = true;
            break;
          case EmptyPointMode.zero:
            point.y = 0;
            point.isVisible = true;
            point.isEmpty = true;
            break;
          default:
            point.isEmpty = true;
            point.isVisible = false;
            break;
        }
      }
    }
  }

  void _findGroupPoints() {
    final num groupValue = currentSeries.groupTo;
    final CircularChartGroupMode mode = currentSeries.groupMode;
    bool isYtext;
    final dynamic textMapping = currentSeries.dataLabelMapper;
    _ChartPoint<dynamic> point;
    sumOfGroup = 0;
    currentSeries._renderPoints = <_ChartPoint<dynamic>>[];
    for (int i = 0; i < currentSeries._dataPoints.length; i++) {
      point = currentSeries._dataPoints[i];
      point.text = point.text == null
          ? textMapping != null
              ? textMapping(i) ?? point.y.toString()
              : point.y.toString()
          : point.text;
      isYtext = point.text == point.y.toString() ? true : false;

      if (point.isVisible) {
        if (mode == CircularChartGroupMode.point &&
            groupValue != null &&
            i >= groupValue) {
          sumOfGroup += point.y.abs();
        } else if (mode == CircularChartGroupMode.value &&
            groupValue != null &&
            point.y <= groupValue) {
          sumOfGroup += point.y.abs();
        } else {
          currentSeries._renderPoints.add(point);
        }
      }
    }

    if (sumOfGroup > 0) {
      currentSeries._renderPoints
          .add(_ChartPoint<dynamic>('Others', sumOfGroup));
      currentSeries._renderPoints[currentSeries._renderPoints.length - 1].text =
          isYtext == true ? 'Others : ' + sumOfGroup.toString() : 'Others';
    }
    _setPointStyle();
  }

  void _setPointStyle() {
    final EmptyPointSettings empty = currentSeries.emptyPointSettings;
    final List<Color> palette = chart.palette;
    int i = 0;
    for (_ChartPoint<dynamic> point in currentSeries._renderPoints) {
      point.fill = point.isEmpty && empty.color != null
          ? empty.color
          : point.pointColor ?? palette[i % palette.length];
      point.color = point.fill;
      point.strokeColor = point.isEmpty && empty.borderColor != null
          ? empty.borderColor
          : currentSeries.borderColor;
      point.strokeWidth = point.isEmpty && empty.borderWidth != null
          ? empty.borderWidth
          : currentSeries.borderWidth;
      point.strokeColor =
          point.strokeWidth == 0 ? Colors.transparent : point.strokeColor;

      if (chart.legend.legendItemBuilder != null) {
        final List<_MeasureWidgetContext> legendToggles =
            chart._chartState.legendToggleTemplateStates;
        if (legendToggles.isNotEmpty) {
          for (int j = 0; j < legendToggles.length; j++) {
            final _MeasureWidgetContext item = legendToggles[j];
            if (i == item.pointIndex) {
              point.isVisible = false;
              break;
            }
          }
        }
      } else {
        if (chart._chartState.legendToggleStates.isNotEmpty) {
          for (int j = 0;
              j < chart._chartState.legendToggleStates.length;
              j++) {
            final _LegendRenderContext legendRenderContext =
                chart._chartState.legendToggleStates[j];
            if (i == legendRenderContext.seriesIndex) {
              point.isVisible = false;
              break;
            }
          }
        }
      }
      i++;
    }
  }

  void _calculateAngleAndCenterPositions() {
    for (CircularSeries<dynamic, dynamic> series in visibleSeries) {
      currentSeries = series;
      _findSumOfPoints();
      _calculateAngle();
      _calculateRadius();
      _calculateOrigin();
      _calculateStartAndEndAngle();
      _calculateCenterPosition();
    }
  }

  void _calculateCenterPosition() {
    if (chart._needToMoveFromCenter &&
        currentSeries.pointRadiusMapper == null &&
        (currentSeries._seriesType == 'pie' ||
            currentSeries._seriesType == 'doughnut')) {
      final Rect areaRect = chart._chartState.chartAreaRect;
      bool needExecute = true;
      double radius = currentSeries._currentRadius;
      while (needExecute) {
        radius += 1;
        final Rect circularRect = _getArcPath(
                0.0,
                radius,
                currentSeries._center,
                currentSeries._start,
                currentSeries._end,
                currentSeries._totalAngle,
                chart,
                true)
            .getBounds();
        if (circularRect.width > areaRect.width) {
          needExecute = false;
          currentSeries._rect = circularRect;
          break;
        }
        if (circularRect.height > areaRect.height) {
          needExecute = false;
          currentSeries._rect = circularRect;
          break;
        }
      }
      currentSeries._rect = _getArcPath(
              0.0,
              currentSeries._currentRadius,
              currentSeries._center,
              currentSeries._start,
              currentSeries._end,
              currentSeries._totalAngle,
              chart,
              true)
          .getBounds();
      for (_ChartPoint<dynamic> point in currentSeries._renderPoints) {
        point.outerRadius = currentSeries._currentRadius;
      }
    }
  }

  void _calculateStartAndEndAngle() {
    int pointIndex = 0;
    num pointEndAngle;
    num pointStartAngle = currentSeries._start;
    final num innerRadius = currentSeries._currentInnerRadius;
    for (_ChartPoint<dynamic> point in currentSeries._renderPoints) {
      if (point.isVisible) {
        point.innerRadius =
            (currentSeries._seriesType == 'doughnut') ? innerRadius : 0.0;
        point.degree = (point.y.abs() /
                (currentSeries._sumOfPoints != 0
                    ? currentSeries._sumOfPoints
                    : 1)) *
            currentSeries._totalAngle;
        pointEndAngle = pointStartAngle + point.degree;
        point.startAngle = pointStartAngle;
        point.endAngle = pointEndAngle;
        point.midAngle = (pointStartAngle + pointEndAngle) / 2;
        point.outerRadius = _calculatePointRadius(
            point.radius, point, currentSeries._currentRadius);
        point.center = _needExplode(pointIndex, currentSeries)
            ? _findExplodeCenter(
                point.midAngle, currentSeries, point.outerRadius)
            : currentSeries._center;
        if (currentSeries.dataLabelSettings != null) {
          _findDataLabelPosition(point);
        }
        pointStartAngle = pointEndAngle;
      }
      pointIndex++;
    }
  }

  bool _needExplode(int pointIndex, CircularSeries<dynamic, dynamic> series) {
    bool isNeedExplode = false;
    if (series.explode) {
      if (chart._chartState.initialRender) {
        if (pointIndex == series.explodeIndex || series.explodeAll) {
          chart._chartState.explodedPoints.add(pointIndex);
          isNeedExplode = true;
        }
      } else if (chart._chartState.widgetNeedUpdate ||
          chart._chartState._isLegendToggled) {
        isNeedExplode = chart._chartState.explodedPoints.contains(pointIndex);
      }
    }
    return isNeedExplode;
  }

  void _findSumOfPoints() {
    currentSeries._sumOfPoints = 0;
    for (_ChartPoint<dynamic> point in currentSeries._renderPoints) {
      if (point.isVisible) {
        currentSeries._sumOfPoints += point.y.abs();
      }
    }
  }

  void _calculateAngle() {
    currentSeries._start = currentSeries.startAngle < 0
        ? currentSeries.startAngle < -360
            ? (currentSeries.startAngle % 360) + 360
            : currentSeries.startAngle + 360
        : currentSeries.startAngle;
    currentSeries._end = currentSeries.endAngle < 0
        ? currentSeries.endAngle < -360
            ? (currentSeries.endAngle % 360) + 360
            : currentSeries.endAngle + 360
        : currentSeries.endAngle;
    currentSeries._start = currentSeries._start > 360
        ? currentSeries._start % 360
        : currentSeries._start;
    currentSeries._end = currentSeries._end > 360
        ? currentSeries._end % 360
        : currentSeries._end;
    currentSeries._start -= 90;
    currentSeries._end -= 90;
    currentSeries._end = currentSeries._start == currentSeries._end
        ? currentSeries._start + 360
        : currentSeries._end;
    currentSeries._totalAngle = currentSeries._start > currentSeries._end
        ? (currentSeries._start - 360).abs() + currentSeries._end
        : (currentSeries._start - currentSeries._end).abs();
  }

  void _calculateRadius() {
    final Rect chartAreaRect = chart._chartState.chartAreaRect;
    size = min(chartAreaRect.width, chartAreaRect.height);
    currentSeries._currentRadius =
        _percentToValue(currentSeries.radius, size / 2).toDouble();
    currentSeries._currentInnerRadius = _percentToValue(
        currentSeries.innerRadius, currentSeries._currentRadius);
  }

  void _calculateOrigin() {
    final Rect chartAreaRect = chart._chartState.chartAreaRect;
    final Rect chartContainerRect = chart._chartState.chartContainerRect;
    currentSeries._center = Offset(
        _percentToValue(chart.centerX, chartAreaRect.width).toDouble(),
        _percentToValue(chart.centerY, chartAreaRect.height).toDouble());
    currentSeries._center = Offset(
        currentSeries._center.dx +
            (chartContainerRect.width - chartAreaRect.width).abs() / 2,
        currentSeries._center.dy +
            (chartContainerRect.height - chartAreaRect.height).abs() / 2);
    chart._chartState.centerLocation = currentSeries._center;
  }

  Offset _findExplodeCenter(num midAngle,
      CircularSeries<dynamic, dynamic> series, num currentRadius) {
    final num explodeCenter =
        _percentToValue(series.explodeOffset, currentRadius);
    return _degreeToPoint(midAngle, explodeCenter, series._center);
  }

  num _calculatePointRadius(
      dynamic value, _ChartPoint<dynamic> point, num radius) {
    if (value != null) {
      radius = value != null ? _percentToValue(value, size / 2) : radius;
    }
    return radius;
  }

  void _seriesPointSelection(_Region pointRegion, ActivationMode mode) {
    bool isPointAlreadySelected = false;
    final CircularSeries<dynamic, dynamic> series =
        chart._chartSeries.visibleSeries[pointRegion.seriesIndex];
    if (series.selectionSettings.enable && mode == chart.selectionGesture) {
      if (chart._chartState.selectionData.isNotEmpty) {
        for (int i = 0; i < chart._chartState.selectionData.length; i++) {
          final int selectionIndex = chart._chartState.selectionData[i];
          if (!chart.enableMultiSelection) {
            isPointAlreadySelected =
                chart._chartState.selectionData.length == 1 &&
                    pointRegion.pointIndex == selectionIndex;
            chart._chartState.selectionData.removeAt(i);
            chart._chartState.seriesRepaintNotifier.value++;
          } else if (pointRegion.pointIndex == selectionIndex) {
            chart._chartState.selectionData.removeAt(i);
            isPointAlreadySelected = true;
            chart._chartState.seriesRepaintNotifier.value++;
            break;
          }
        }
      }
      if (!isPointAlreadySelected) {
        chart._chartState.selectionData.add(pointRegion.pointIndex);
        chart._chartState.seriesRepaintNotifier.value++;
      }
    }
  }

  void _seriesPointExplosion(_Region pointRegion) {
    bool existExplodedRegion = false;
    final CircularSeries<dynamic, dynamic> series =
        chart._chartSeries.visibleSeries[pointRegion.seriesIndex];
    final _ChartPoint<dynamic> point =
        series._renderPoints[pointRegion.pointIndex];
    if (series.explode) {
      if (chart._chartState.explodedPoints.isNotEmpty) {
        if (chart._chartState.explodedPoints.length == 1 &&
            chart._chartState.explodedPoints.contains(pointRegion.pointIndex)) {
          existExplodedRegion = true;
          point.center = series._center;
          final int index =
              chart._chartState.explodedPoints.indexOf(pointRegion.pointIndex);
          chart._chartState.explodedPoints.removeAt(index);
          chart._chartState.seriesRepaintNotifier.value++;
        } else if (series.explodeAll &&
            chart._chartState.explodedPoints.length > 1 &&
            chart._chartState.explodedPoints.contains(pointRegion.pointIndex)) {
          for (int i = 0; i < chart._chartState.explodedPoints.length; i++) {
            final int explodeIndex = chart._chartState.explodedPoints[i];
            series._renderPoints[explodeIndex].center = series._center;
            chart._chartState.explodedPoints.removeAt(i);
            i--;
          }
          existExplodedRegion = true;
          chart._chartState.seriesRepaintNotifier.value++;
        } else if (chart._chartState.explodedPoints.length == 1) {
          for (int i = 0; i < chart._chartState.explodedPoints.length; i++) {
            final int explodeIndex = chart._chartState.explodedPoints[i];
            series._renderPoints[explodeIndex].center = series._center;
            chart._chartState.explodedPoints.removeAt(i);
            chart._chartState.seriesRepaintNotifier.value++;
          }
        }
      }
      if (!existExplodedRegion) {
        point.center = _findExplodeCenter(
            point.midAngle, currentSeries, point.outerRadius);
        chart._chartState.explodedPoints.add(pointRegion.pointIndex);
        chart._chartState.seriesRepaintNotifier.value++;
      }
    }
  }

  void _setSeriesType(CircularSeries<dynamic, dynamic> series) {
    if (series is PieSeries)
      series._seriesType = 'pie';
    else if (series is DoughnutSeries)
      series._seriesType = 'doughnut';
    else if (series is RadialBarSeries) 
      series._seriesType = 'radialbar';
  }
}
