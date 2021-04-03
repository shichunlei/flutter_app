part of flutter_charts;

class _PyramidSeries {
  _PyramidSeries();

  SfPyramidChart chart;

  PyramidSeries<dynamic, dynamic> currentSeries;

  List<PyramidSeries<dynamic, dynamic>> visibleSeries;
  SelectionArgs _selectionArgs;

  void _findVisibleSeries() {
    visibleSeries = <PyramidSeries<dynamic, dynamic>>[];
    chart.series._dataPoints = <_PointInfo<dynamic>>[];

    //Considered the first series, since in tringular series one series will be considered for rendering
    final PyramidSeries<dynamic, dynamic> currentSeries = chart.series;
    _setSeriesType(currentSeries);
    final dynamic xValue = currentSeries.xValueMapper;
    final dynamic yValue = currentSeries.yValueMapper;
    for (int pointIndex = 0;
        pointIndex < currentSeries.dataSource.length;
        pointIndex++) {
      if (xValue(pointIndex) != null) {
        currentSeries._dataPoints
            .add(_PointInfo<dynamic>(xValue(pointIndex), yValue(pointIndex)));
      }
    }

    visibleSeries.add(chart.series);
  }

  void _setSeriesType(PyramidSeries<dynamic, dynamic> series) {
    series._seriesType = 'pyramid';
  }

  void _processDataPoints() {
    for (PyramidSeries<dynamic, dynamic> series in visibleSeries) {
      currentSeries = series;
      _setEmptyPoint();
      _getVisiblePoints();
      _setPointStyle();
      _findSumOfPoints();
    }
  }

  void _getVisiblePoints() {
    final List<_PointInfo<dynamic>> points = currentSeries._dataPoints;
    chart.series._renderPoints = <_PointInfo<dynamic>>[];
    for (int i = 0; i < points.length; i++) {
      if (points[i].isVisible) {
        chart.series._renderPoints.add(points[i]);
      }
    }
  }

  void _setPointStyle() {
    final List<Color> palette = chart.palette;
    final dynamic pointColor = currentSeries.pointColorMapper;
    final EmptyPointSettings empty = currentSeries.emptyPointSettings;
    final dynamic textMapping = currentSeries.textFieldMapper;
    final List<_PointInfo<dynamic>> points = currentSeries._renderPoints;
    for (int i = 0; i < points.length; i++) {
      _PointInfo<dynamic> currentPoint;
      currentPoint = points[i];
      currentPoint.fill = currentPoint.isEmpty && empty.color != null
          ? empty.color
          : pointColor(i) ?? palette[i % palette.length];
      currentPoint.color = currentPoint.fill;
      currentPoint.borderColor =
          currentPoint.isEmpty && empty.borderColor != null
              ? empty.borderColor
              : currentSeries.borderColor;
      currentPoint.borderWidth =
          currentPoint.isEmpty && empty.borderWidth != null
              ? empty.borderWidth
              : currentSeries.borderWidth;
      currentPoint.borderColor = currentPoint.borderWidth == 0
          ? Colors.transparent
          : currentPoint.borderColor;

      currentPoint.text = currentPoint.text == null
          ? textMapping != null
              ? textMapping(i) ?? currentPoint.y.toString()
              : currentPoint.y.toString()
          : currentPoint.text;

      if (chart.legend.legendItemBuilder != null) {
        final List<_MeasureWidgetContext> legendToggles =
            chart._chartState.legendToggleTemplateStates;
        if (legendToggles.isNotEmpty) {
          for (int j = 0; j < legendToggles.length; j++) {
            final _MeasureWidgetContext item = legendToggles[j];
            if (i == item.pointIndex) {
              currentPoint.isVisible = false;
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
              currentPoint.isVisible = false;
              break;
            }
          }
        }
      }
    }
  }

  void _findSumOfPoints() {
    currentSeries._sumOfPoints = 0;
    for (_PointInfo<dynamic> point in currentSeries._renderPoints) {
      if (point.isVisible) {
        currentSeries._sumOfPoints += point.y.abs();
      }
    }
  }

  void _setEmptyPoint() {
    final EmptyPointSettings empty = currentSeries.emptyPointSettings;
    final int pointLength = currentSeries._dataPoints.length;
    for (int pointIndex = 0; pointIndex < pointLength; pointIndex++) {
      final _PointInfo<dynamic> point = currentSeries._dataPoints[pointIndex];
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

  void _initializeSeriesProperties(PyramidSeries<dynamic, dynamic> series) {
    final Rect chartAreaRect = chart._chartState.chartAreaRect;
    final bool reverse = series._seriesType == 'pyramid' ? true : false;
    series._triangleSize = Size(
        _percentToValue(series.width, chartAreaRect.width).toDouble(),
        _percentToValue(series.height, chartAreaRect.height).toDouble());
    series._explodeDistance =
        _percentToValue(series.explodeOffset, chartAreaRect.width);
    if (series.pyramidMode == PyramidMode.linear) {
      _initilaizeSizeRatio(series, reverse);
    } else {
      _initializeSurfaceSizeRatio(series);
    }
  }

  void _initializeSurfaceSizeRatio(PyramidSeries<dynamic, dynamic> series) {
    final num count = series._renderPoints.length;
    final num sumOfValues = series._sumOfPoints;
    List<num> y;
    List<num> height;
    y = <num>[];
    height = <num>[];
    final num gapRatio = min(max(series.gapRatio, 0), 1);
    final num gapHeight = gapRatio / (count - 1);
    final num preSum = _getSurfaceHeight(0, sumOfValues);
    num currY = 0;
    for (num i = 0; i < count; i++) {
      if (series._renderPoints[i].isVisible) {
        y.add(currY);
        height.add(_getSurfaceHeight(currY, series._renderPoints[i].y.abs()));
        currY += height[i] + gapHeight * preSum;
      }
    }
    final num coef = 1 / (currY - gapHeight * preSum);
    for (num i = 0; i < count; i++) {
      if (series._renderPoints[i].isVisible) {
        series._renderPoints[i].yRatio = coef * y[i];
        series._renderPoints[i].heightRatio = coef * height[i];
      }
    }
  }

  num _getSurfaceHeight(num y, num surface) =>
      _solveQuadraticEquation(1, 2 * y, -surface);

  num _solveQuadraticEquation(num a, num b, num c) {
    num root1;
    num root2;
    final num d = b * b - 4 * a * c;
    if (d >= 0) {
      final num sd = sqrt(d);
      root1 = (-b - sd) / (2 * a);
      root2 = (-b + sd) / (2 * a);
      return max(root1, root2);
    }
    return 0;
  }

  void _initilaizeSizeRatio(PyramidSeries<dynamic, dynamic> series,
      [bool reverse]) {
    final List<_PointInfo<dynamic>> points = series._renderPoints;
    double y;
    final double gapRatio = min(max(series.gapRatio, 0), 1);
    final double coEff =
        1 / (series._sumOfPoints * (1 + gapRatio / (1 - gapRatio)));
    final double spacing = gapRatio / (points.length - 1);
    y = 0;
    num index;
    num height;
    for (num i = points.length - 1; i >= 0; i--) {
      index = reverse ? points.length - 1 - i : i;
      if (points[index].isVisible) {
        height = coEff * points[index].y;
        points[index].yRatio = y;
        points[index].heightRatio = height;
        y += height + spacing;
      }
    }
  }

  void _pointExplode(num pointIndex) {
    bool existExplodedRegion = false;
    final PyramidSeries<dynamic, dynamic> series =
        chart._chartSeries.visibleSeries[0];
    final _PointInfo<dynamic> point = series._renderPoints[pointIndex];
    if (series.explode) {
      if (chart._chartState.explodedPoints.isNotEmpty) {
        existExplodedRegion = true;
        final int previousIndex = chart._chartState.explodedPoints[0];
        series._renderPoints[previousIndex].explodeDistance = 0;
        point.explodeDistance =
            previousIndex == pointIndex ? 0 : series._explodeDistance;
        chart._chartState.explodedPoints[0] = pointIndex;
        if (previousIndex == pointIndex) {
          chart._chartState.explodedPoints = <int>[];
        }
        chart._chartState.seriesRepaintNotifier.value++;
      }
      if (!existExplodedRegion) {
        point.explodeDistance = series._explodeDistance;
        chart._chartState.explodedPoints.add(pointIndex);
        chart._chartState.seriesRepaintNotifier.value++;
      }
      _calculatePathRegion(pointIndex);
    }
  }

  void _calculatePathRegion(num pointIndex) {
    final dynamic currentPoint = currentSeries._renderPoints[pointIndex];
    currentPoint.pathRegion = <Offset>[];
    final Size area = currentSeries._triangleSize;
    final num seriesTop = chart._chartState.chartContainerRect.top +
        (chart._chartState.chartContainerRect.height - area.height) / 2;
    const num offset = 0;
    final num extraSpace = (currentPoint.explodeDistance != null
            ? currentPoint.explodeDistance
            : _isNeedExplode(pointIndex, currentSeries, chart)
                ? currentSeries._explodeDistance
                : 0) +
        (chart._chartState.chartContainerRect.width -
                currentSeries._triangleSize.width) /
            2;
    final num emptySpaceAtLeft =
        extraSpace + chart._chartState.chartContainerRect.left;
    num top = currentPoint.yRatio;
    num bottom = currentPoint.yRatio + currentPoint.heightRatio;
    final num topRadius = 0.5 * (1 - currentPoint.yRatio);
    final num bottomRadius = 0.5 * (1 - bottom);
    top += seriesTop / area.height;
    bottom += seriesTop / area.height;
    num line1X;
    num line1Y;
    num line2X;
    num line2Y;
    num line3X;
    num line3Y;
    num line4X;
    num line4Y;
    line1X = emptySpaceAtLeft + offset + topRadius * area.width;
    line1Y = top * area.height;
    line2X = emptySpaceAtLeft + offset + (1 - topRadius) * area.width;
    line2Y = top * area.height;
    line3X = emptySpaceAtLeft + offset + (1 - bottomRadius) * area.width;
    line3Y = bottom * area.height;
    line4X = emptySpaceAtLeft + offset + bottomRadius * area.width;
    line4Y = bottom * area.height;
    currentPoint.pathRegion.add(Offset(line1X, line1Y));
    currentPoint.pathRegion.add(Offset(line2X, line2Y));
    currentPoint.pathRegion.add(Offset(line3X, line3Y));
    currentPoint.pathRegion.add(Offset(line4X, line4Y));
    _getPathSegment(currentSeries._seriesType, currentPoint);
  }

  void _getPyramidSegments(Canvas canvas, num pointIndex) {
    _calculatePathRegion(pointIndex);
    final dynamic currentPoint = currentSeries._renderPoints[pointIndex];
    final Path path = Path();
    path.moveTo(currentPoint.pathRegion[0].dx, currentPoint.pathRegion[0].dy);
    path.lineTo(currentPoint.pathRegion[1].dx, currentPoint.pathRegion[0].dy);
    path.lineTo(currentPoint.pathRegion[1].dx, currentPoint.pathRegion[1].dy);
    path.lineTo(currentPoint.pathRegion[2].dx, currentPoint.pathRegion[2].dy);
    path.lineTo(currentPoint.pathRegion[3].dx, currentPoint.pathRegion[3].dy);
    path.close();
    if (pointIndex == currentSeries._renderPoints.length - 1) {
      currentSeries._maximumDataLabelRegion = path.getBounds();
    }
    _segmentPaint(canvas, path, pointIndex);
  }

  void _segmentPaint(Canvas canvas, Path path, num pointIndex) {
    final dynamic point = currentSeries._renderPoints[pointIndex];
    final _StyleOptions style =
        _getPointStyle(pointIndex, currentSeries, chart, point);

    final Color fillColor = style != null && style.fill != null
        ? style.fill
        : (point.fill != Colors.transparent
            ? currentSeries._renderer.getPointColor(currentSeries, point,
                pointIndex, point.fill, currentSeries.opacity)
            : point.fill);

    final Color strokeColor = style != null && style.strokeColor != null
        ? style.strokeColor
        : currentSeries._renderer.getPointStrokeColor(
            currentSeries, point, pointIndex, point.borderColor);

    final double strokeWidth = style != null && style.strokeWidth != null
        ? style.strokeWidth
        : currentSeries._renderer.getPointStrokeWidth(
            currentSeries, point, pointIndex, point.borderWidth);

    final double opacity = style != null && style.opacity != null
        ? style.opacity
        : currentSeries._renderer.getOpacity(
            currentSeries, point, pointIndex, currentSeries.opacity);

    _drawPath(
        canvas,
        _StyleOptions(
            fillColor,
            chart._chartState.animateCompleted ? strokeWidth : 0,
            strokeColor,
            opacity),
        path);
  }

  void _getPathSegment(String seriesType, _PointInfo<dynamic> point) {
    final List<Offset> pathRegion = point.pathRegion;
    final num bottom =
        seriesType == 'funnel' ? pathRegion.length - 2 : pathRegion.length - 1;
    final num x = (pathRegion[0].dx + pathRegion[bottom].dx) / 2;
    final num right = (pathRegion[1].dx + pathRegion[bottom - 1].dx) / 2;
    point.region = Rect.fromLTWH(x, pathRegion[0].dy, right - x,
        pathRegion[bottom].dy - pathRegion[0].dy);
    point.symbolLocation = Offset(point.region.left + point.region.width / 2,
        point.region.top + point.region.height / 2);
  }

  void _seriesPointSelection(num pointIndex, ActivationMode mode) {
    bool isPointAlreadySelected = false;
    final dynamic series = chart._chartSeries.visibleSeries[0];
    if (series.selectionSettings.enable && mode == chart.selectionGesture) {
      if (chart._chartState.selectionData.isNotEmpty) {
        for (int i = 0; i < chart._chartState.selectionData.length; i++) {
          final int selectionIndex = chart._chartState.selectionData[i];
          if (!chart.enableMultiSelection) {
            isPointAlreadySelected =
                chart._chartState.selectionData.length == 1 &&
                    pointIndex == selectionIndex;
            chart._chartState.selectionData.removeAt(i);
            chart._chartState.seriesRepaintNotifier.value++;
          } else if (pointIndex == selectionIndex) {
            chart._chartState.selectionData.removeAt(i);
            isPointAlreadySelected = true;
            chart._chartState.seriesRepaintNotifier.value++;
            break;
          }
        }
      }
      if (!isPointAlreadySelected) {
        chart._chartState.selectionData.add(pointIndex);
        chart._chartState.seriesRepaintNotifier.value++;
      }
    }
  }

  _StyleOptions _getPointStyle(
      int currentPointIndex,
      PyramidSeries<dynamic, dynamic> series,
      SfPyramidChart chart,
      _PointInfo<dynamic> point) {
    _StyleOptions pointStyle;
    final SelectionSettings selection = series.selectionSettings;
    const num seriesIndex = 0;
    if (selection.enable) {
      if (chart._chartState.selectionData.isNotEmpty) {
        if (chart.onSelectionChanged != null) {
          chart.onSelectionChanged(
              _getSelectionEventArgs(series, seriesIndex, currentPointIndex));
        }
        for (int i = 0; i < chart._chartState.selectionData.length; i++) {
          final int selectionIndex = chart._chartState.selectionData[i];
          if (currentPointIndex == selectionIndex) {
            pointStyle = _StyleOptions(
                _selectionArgs != null
                    ? _selectionArgs.selectedColor
                    : selection.selectedColor,
                _selectionArgs != null
                    ? _selectionArgs.selectedBorderWidth
                    : selection.selectedBorderWidth,
                _selectionArgs != null
                    ? _selectionArgs.selectedBorderColor
                    : selection.selectedBorderColor,
                selection.selectedOpacity);
            break;
          } else if (i == chart._chartState.selectionData.length - 1) {
            pointStyle = _StyleOptions(
                _selectionArgs != null
                    ? _selectionArgs.unselectedColor
                    : selection.unselectedColor,
                _selectionArgs != null
                    ? _selectionArgs.unselectedBorderWidth
                    : selection.unselectedBorderWidth,
                _selectionArgs != null
                    ? _selectionArgs.unselectedBorderColor
                    : selection.unselectedBorderColor,
                selection.unselectedOpacity);
          }
        }
      }
    }
    return pointStyle;
  }

  SelectionArgs _getSelectionEventArgs(
      dynamic series, num seriesIndex, num pointIndex) {
    if (series != null) {
      _selectionArgs = SelectionArgs();
      _selectionArgs.series = series;
      _selectionArgs.selectedBorderColor =
          series.selectionSettings.selectedBorderColor;
      _selectionArgs.selectedBorderWidth =
          series.selectionSettings.selectedBorderWidth;
      _selectionArgs.selectedColor = series.selectionSettings.selectedColor;
      _selectionArgs.unselectedBorderColor =
          series.selectionSettings.unselectedBorderColor;
      _selectionArgs.unselectedBorderWidth =
          series.selectionSettings.unselectedBorderWidth;
      _selectionArgs.unselectedColor = series.selectionSettings.unselectedColor;
      _selectionArgs.seriesIndex = seriesIndex;
      _selectionArgs.pointIndex = pointIndex;
    }
    return _selectionArgs;
  }
}
