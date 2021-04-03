part of flutter_charts;

/// Renders the spline series.
class SplineSeries<T, D> extends XyDataSeries<T, D> {
  SplineSeries(
      {@required List<T> dataSource,
      @required ChartValueMapper<T, D> xValueMapper,
      @required ChartValueMapper<T, num> yValueMapper,
      ChartValueMapper<T, dynamic> sortFieldValueMapper,
      ChartValueMapper<T, Color> pointColorMapper,
      ChartValueMapper<T, String> dataLabelMapper,
      String xAxisName,
      String yAxisName,
      String name,
      Color color,
      double width,
      LinearGradient gradient,
      MarkerSettings markerSettings,
      this.splineType,
      this.cardinalSplineTension,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      bool isVisible,
      bool enableTooltip,
      List<double> dashArray,
      double animationDuration,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      SortingOrder sortingOrder,
      String legendItemText,
      double opacity,
      List<int> initialSelectedDataIndexes})
      : super(
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            xAxisName: xAxisName,
            yAxisName: yAxisName,
            name: name,
            color: color,
            width: width ?? 2,
            gradient: gradient,
            markerSettings: markerSettings,
            dataLabelSettings: dataLabelSettings,
            emptyPointSettings: emptyPointSettings,
            enableTooltip: enableTooltip,
            isVisible: isVisible,
            dashArray: dashArray,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendItemText: legendItemText,
            isVisibleInLegend: isVisibleInLegend,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity,
            initialSelectedDataIndexes: initialSelectedDataIndexes);

  ///Type of the spline curve. Various type of curves such as clamped, cardinal,
  ///monotonic, and natural can be rendered between the data points.
  ///
  ///Defaults to splineType.natural
  ///
  ///Also refer [SplineType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  splineType: SplineType.monotonic,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final SplineType splineType;

  ///Line tension of the cardinal spline. The value ranges from 0 to 1.
  ///
  ///Defaults to 0.5
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  splineType: SplineType.natural,
  ///                  cardinalSplineTension: 0.4,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  double cardinalSplineTension;

  /// Creates a segment for a data point in the series.
  @override
  ChartSegment createSegment() => SplineSegment();

  /// Creates a collection of segments for the points in the series.
  @override
  void createSegments() {
    final Rect rect = _calculatePlotOffset(_chart._chartAxis._axisClipRect,
        Offset(_xAxis.plotOffset, _yAxis.plotOffset));
    List<num> yCoef = <num>[];
    final List<num> xValues = <num>[];
    final List<num> yValues = <num>[];
    List<double> controlPoints = <double>[];
    double x1, x2, y1, y2;
    double startControlX;
    double startControlY;
    double endControlX;
    double endControlY;
    dynamic splineType;

    if (this is SplineSeries) {
      splineType = this.splineType;
    }

    for (int i = 0; i < _dataPoints.length; i++) {
      if (_dataPoints[i].isDrop != true) {
        xValues.add(_dataPoints[i].xValue);
        yValues.add(_dataPoints[i].yValue);
      }
    }

    if (xValues.isNotEmpty) {
      final List<num> dx = List<num>(xValues.length - 1);

      /// Check the type of spline
      if (splineType == SplineType.monotonic) {
        yCoef =
            _getMonotonicSpline(xValues, yValues, yCoef, xValues.length, dx);
      } else if (splineType == SplineType.cardinal) {
        if (this is SplineSeries) {
          cardinalSplineTension = cardinalSplineTension ?? 0.5;
          yCoef = _getCardinalSpline(
              xValues, yValues, yCoef, xValues.length, cardinalSplineTension);
        }
      } else {
        yCoef =
            _naturalSpline(xValues, yValues, yCoef, xValues.length, splineType);
      }
      for (int pointIndex = 0; pointIndex < xValues.length - 1; pointIndex++) {
        if (xValues[pointIndex] != null &&
            yValues[pointIndex] != null &&
            xValues[pointIndex + 1] != null &&
            yValues[pointIndex + 1] != null) {
          final double x = xValues[pointIndex].toDouble();
          final double y = yValues[pointIndex].toDouble();
          final double nextX = xValues[pointIndex + 1].toDouble();
          final double nextY = yValues[pointIndex + 1].toDouble();
          if (splineType == SplineType.monotonic) {
            controlPoints = _calculateMonotonicControlPoints(
                x,
                y,
                nextX,
                nextY,
                yCoef[pointIndex].toDouble(),
                yCoef[pointIndex + 1].toDouble(),
                dx[pointIndex].toDouble());
          } else if (splineType == SplineType.cardinal) {
            controlPoints = _calculateCardinalControlPoints(x, y, nextX, nextY,
                yCoef[pointIndex].toDouble(), yCoef[pointIndex + 1].toDouble());
          } else {
            controlPoints = _calculateControlPoints(
                xValues,
                yValues,
                yCoef[pointIndex].toDouble(),
                yCoef[pointIndex + 1].toDouble(),
                pointIndex);
          }

          final num currentPointXValue = xValues[pointIndex];
          final num currentPointYValue = yValues[pointIndex];
          final num nextPointXValue = xValues[pointIndex + 1];
          final num nextPointYValue = yValues[pointIndex + 1];

          x1 = _calculatePoint(currentPointXValue, currentPointYValue, _xAxis,
                  _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          y1 = _calculatePoint(currentPointXValue, currentPointYValue, _xAxis,
                  _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;

          x2 = _calculatePoint(nextPointXValue, nextPointYValue, _xAxis, _yAxis,
                  _chart._requireInvertedAxis, this, rect)
              .x;
          y2 = _calculatePoint(nextPointXValue, nextPointYValue, _xAxis, _yAxis,
                  _chart._requireInvertedAxis, this, rect)
              .y;

          startControlX = _calculatePoint(controlPoints[0], controlPoints[1],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          startControlY = _calculatePoint(controlPoints[0], controlPoints[1],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;
          endControlX = _calculatePoint(controlPoints[2], controlPoints[3],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .x;
          endControlY = _calculatePoint(controlPoints[2], controlPoints[3],
                  _xAxis, _yAxis, _chart._requireInvertedAxis, this, rect)
              .y;

          final List<num> values = <num>[];
          values.add(x1);
          values.add(y1);
          values.add(x2);
          values.add(y2);
          values.add(startControlX);
          values.add(startControlY);
          values.add(endControlX);
          values.add(endControlY);
          _createSegment(
              values, _dataPoints[pointIndex], _dataPoints[pointIndex + 1]);
        }
      }
    }
  }

  /// Spline segment is created here
  void _createSegment(List<num> values, _CartesianChartPoint<dynamic> currentPt,
      _CartesianChartPoint<dynamic> nextPt) {
    final SplineSegment segment = createSegment();
    _isRectSeries = false;
    if (segment != null) {
      segment._currentPoint = currentPt;
      segment._pointColorMapper = currentPt.pointColorMapper;
      segment._nextPoint = nextPt;
      segment.currentSegmentIndex = _dataPoints.indexOf(currentPt);
      segment._seriesIndex = _chart._chartSeries.visibleSeries.indexOf(this);
      segment.series = this;
      if (_chart._chartState.widgetNeedUpdate &&
          _xAxis._zoomFactor == 1 &&
          _yAxis._zoomFactor == 1 &&
          _chart._chartState.prevWidgetSeries != null &&
          _chart._chartState.prevWidgetSeries.isNotEmpty &&
          _chart._chartState.prevWidgetSeries.length - 1 >=
              segment._seriesIndex &&
          _chart._chartState.prevWidgetSeries[segment._seriesIndex]
                  ._seriesName ==
              segment.series._seriesName) {
        segment.oldSeries =
            _chart._chartState.prevWidgetSeries[segment._seriesIndex];
      }
      segment._setData(values);
      segment.calculateSegmentPoints();
      customizeSegment(segment);
      segment.strokePaint = segment.getStrokePaint();
      segment.fillPaint = segment.getFillPaint();
      segments.add(segment);
    }
  }

  /// Changes the series color, border color, and border width.
  @override
  void customizeSegment(ChartSegment segment) {
    segment.color = segment.series._seriesColor;
    segment.strokeColor = segment.series._seriesColor;
    segment.strokeWidth = segment.series.width;
  }

  ///Draws marker with different shape and color of the appropriate data point in the series.
  @override
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY) {
    canvas.drawPath(_markerShapes[index], strokePaint);
    canvas.drawPath(_markerShapes[index], fillPaint);
  }

  /// Draws data label text of the appropriate data point in a series.
  @override
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
          double pointY, int angle, ChartTextStyle style) =>
      _drawText(canvas, dataLabel, Offset(pointX, pointY), style, angle);

  /// To find MonotonicSpline
  List<num> _getMonotonicSpline(List<num> xValues, List<num> yValues,
      List<num> yCoef, int dataCount, List<num> dx) {
    final int count = dataCount;
    int index = -1;

    final dynamic slope = List<dynamic>(count - 1);
    final dynamic coefficient = List<dynamic>(count);

    for (int i = 0; i < count - 1; i++) {
      dx[i] = xValues[i + 1] - xValues[i];
      slope[i] = (yValues[i + 1] - yValues[i]) / dx[i];
      if (slope[i].toDouble() == double.infinity) {
        slope[i] = 0;
      }
    }
    // Add the first and last coefficient value as Slope[0] and Slope[n-1]
    if (slope.length == 0) {
      return null;
    }

    slope[0] == double.nan
        ? coefficient[++index] = 0
        : coefficient[++index] = slope[0];

    for (int i = 0; i < dx.length - 1; i++) {
      if (slope.length > i + 1) {
        final dynamic m = slope[i], next = slope[i + 1];
        if (m * next <= 0) {
          coefficient[++index] = 0;
        } else {
          if (dx[i] == 0) {
            coefficient[++index] = 0;
          } else {
            final double firstPoint = dx[i].toDouble(),
                nextPoint = dx[i + 1].toDouble();
            final double interPoint = firstPoint + nextPoint;
            coefficient[++index] = 3 *
                interPoint /
                (((interPoint + nextPoint) / m) +
                    ((interPoint + firstPoint) / next));
          }
        }
      }
    }
    slope[slope.length - 1] == double.nan
        ? coefficient[++index] = 0
        : coefficient[++index] = slope[slope.length - 1];

    for (int i = 0; i < coefficient.length; i++) {
      yCoef.add(coefficient[i]);
    }

    return yCoef;
  }

  /// To find CardinalSpline
  List<num> _getCardinalSpline(List<num> xValues, List<num> yValues,
      List<num> yCoef, int dataCount, double tension) {
    if (tension < 0.1) {
      tension = 0;
    } else if (tension > 1) {
      tension = 1;
    }

    final int count = dataCount;

    final dynamic tangentsX = List<dynamic>(count);

    for (int i = 0; i < count; i++) {
      if (i == 0 && xValues.length > 2) {
        tangentsX[i] = tension * (xValues[i + 2] - xValues[i]);
      } else if (i == count - 1 && count - 3 >= 0) {
        tangentsX[i] = tension * (xValues[count - 1] - xValues[count - 3]);
      } else if (i - 1 >= 0 && xValues.length > i + 1) {
        tangentsX[i] = tension * (xValues[i + 1] - xValues[i - 1]);
      }

      if (tangentsX[i] == double.nan) {
        tangentsX[i] = 0;
      }
    }

    for (int i = 0; i < tangentsX.length; i++) {
      yCoef.add(tangentsX[i]);
    }
    return yCoef;
  }

  /// To find NaturalSpline
  List<num> _naturalSpline(List<num> xValues, List<num> yValues,
      List<num> yCoeff, int dataCount, SplineType splineType) {
    const double a = 6;
    final int count = dataCount;
    final dynamic yCoef = List<dynamic>(count);
    for (int i = 0; i < count; i++) {
      yCoef[i] = 0;
    }

    final dynamic u = List<dynamic>(count);
    if (splineType == SplineType.clamped && xValues.length > 1) {
      u[0] = 0.5;
      final dynamic d0 = (xValues[1] - xValues[0]) / (yValues[1] - yValues[0]);
      final dynamic dn = (xValues[count - 1] - xValues[count - 2]) /
          (yValues[count - 1] - yValues[count - 2]);
      yCoef[0] = (3 * (yValues[1] - yValues[0]) / (xValues[1] - xValues[0])) -
          (3 * d0);
      yCoef[count - 1] = (3 * dn) -
          ((3 * (yValues[count - 1] - yValues[count - 2])) /
              (xValues[count - 1] - xValues[count - 2]));

      if (yCoef[0] == double.infinity || yCoef[0] == double.nan) {
        yCoef[0] = 0;
      }

      if (yCoef[count - 1] == double.infinity ||
          yCoef[count - 1] == double.nan) {
        yCoef[count - 1] = 0;
      }
    } else {
      yCoef[0] = u[0] = 0;
      yCoef[count - 1] = 0;
    }

    for (int i = 1; i < count - 1; i++) {
      if ((yValues[i + 1] != double.nan) &&
          (yValues[i - 1] != double.nan) &&
          (yValues[i] != double.nan) &&
          yValues[i + 1] != null &&
          xValues[i + 1] != null &&
          yValues[i - 1] != null &&
          xValues[i - 1] != null &&
          xValues[i] != null &&
          yValues[i] != null) {
        final double d1 = xValues[i].toDouble() - xValues[i - 1].toDouble();
        final double d2 = xValues[i + 1].toDouble() - xValues[i - 1].toDouble();
        final double d3 = xValues[i + 1].toDouble() - xValues[i].toDouble();
        final double dy1 = yValues[i + 1].toDouble() - yValues[i].toDouble();
        final double dy2 = yValues[i].toDouble() - yValues[i - 1].toDouble();
        if (xValues[i] == xValues[i - 1] || xValues[i] == xValues[i + 1]) {
          yCoef[i] = 0;
          u[i] = 0;
        } else {
          final dynamic p = 1 / ((d1 * yCoef[i - 1]) + (2 * d2));
          yCoef[i] = -p * d3;
          if (d1 != null && u[i - 1] != null) {
            u[i] = p * ((a * ((dy1 / d3) - (dy2 / d1))) - (d1 * u[i - 1]));
          }
        }
      }
    }

    for (int k = count - 2; k >= 0; k--) {
      if (u[k] != null && yCoef[k] != null && yCoef[k + 1] != null) {
        yCoef[k] = (yCoef[k] * yCoef[k + 1]) + u[k];
      }
    }

    for (int i = 0; i < yCoef.length; i++) {
      yCoeff.add(yCoef[i]);
    }
    return yCoeff;
  }

  /// To find Monotonic ControlPoints
  List<double> _calculateMonotonicControlPoints(
      double pointX,
      double pointY,
      double pointX1,
      double pointY1,
      double coefficientY,
      double coefficientY1,
      double dx) {
    final dynamic value = dx / 3;
    final List<double> values = List<double>(4);
    values[0] = pointX + value;
    values[1] = pointY + (coefficientY * value);
    values[2] = pointX1 - value;
    values[3] = pointY1 - (coefficientY1 * value);
    return values;
  }

  /// To find Cardinal ControlPoints
  List<double> _calculateCardinalControlPoints(
      double pointX,
      double pointY,
      double pointX1,
      double pointY1,
      double coefficientY,
      double coefficientY1) {
    final List<double> values = List<double>(4);
    values[0] = pointX + (coefficientY / 3);
    values[1] = pointY + (coefficientY / 3);
    values[2] = pointX1 - (coefficientY1 / 3);
    values[3] = pointY1 - (coefficientY1 / 3);
    return values;
  }

  /// To find Natural ControlPoints
  List<double> _calculateControlPoints(List<num> xValues, List<num> yValues,
      double yCoef, double nextyCoef, int i) {
    final List<double> controlPoints = List<double>(4);
    final double yCoeff1 = yCoef;
    final double yCoeff2 = nextyCoef;
    final double x = xValues[i].toDouble();
    final double y = yValues[i].toDouble();
    final double nextX = xValues[i + 1].toDouble();
    final double nextY = yValues[i + 1].toDouble();
    const double oneThird = 1 / 3.0;
    double deltaX2 = nextX - x;
    deltaX2 = deltaX2 * deltaX2;
    final double dx1 = (2 * x) + nextX;
    final double dx2 = x + (2 * nextX);
    final double dy1 = (2 * y) + nextY;
    final double dy2 = y + (2 * nextY);
    final double y1 =
        oneThird * (dy1 - (oneThird * deltaX2 * (yCoeff1 + (0.5 * yCoeff2))));
    final double y2 =
        oneThird * (dy2 - (oneThird * deltaX2 * ((0.5 * yCoeff1) + yCoeff2)));
    final dynamic startControlPointsX = dx1 * oneThird;
    final dynamic startControlPointsY = y1;
    final dynamic endControlPointsX = dx2 * oneThird;
    final dynamic endControlPointsY = y2;
    controlPoints[0] = startControlPointsX;
    controlPoints[1] = startControlPointsY;
    controlPoints[2] = endControlPointsX;
    controlPoints[3] = endControlPointsY;
    return controlPoints;
  }
}
