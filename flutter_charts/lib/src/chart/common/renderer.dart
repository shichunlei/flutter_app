part of flutter_charts;

// ignore: must_be_immutable
class _DataLabelRenderer extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _DataLabelRenderer({this.cartesianChart, this.show});

  final SfCartesianChart cartesianChart;

  bool show;

  _DataLabelRendererState state;

  @override
  State<StatefulWidget> createState() => _DataLabelRendererState();
}

class _DataLabelRendererState extends State<_DataLabelRenderer>
    with TickerProviderStateMixin {
  List<AnimationController> animationControllersList;

  @override
  void initState() {
    animationControllersList = <AnimationController>[];
    super.initState();
  }

  @override
  void dispose() {
    if (animationControllersList != null) {
      for (int index = 0; index < animationControllersList.length; index++) {
        animationControllersList[index].dispose();

        /// Need to dispose all the animation controller instance otherwise it will cause memory leak
      }
    }
    super.dispose();
  }

  void render() {
    setState(() {
      widget.show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.state = this;
    return Container(
        child: CustomPaint(
            painter: _DataLabelPainter(
                cartesianChart: widget.cartesianChart,
                animation:
                    widget.cartesianChart._chartState.chartElementAnimation,
                state: this,
                animationController:
                    widget.cartesianChart._chartState.animationController)));
  }
}

class _DataLabelPainter extends CustomPainter {
  _DataLabelPainter(
      {this.cartesianChart,
      this.state,
      this.animationController,
      this.animation})
      : super(repaint: animationController);

  final SfCartesianChart cartesianChart;

  final _DataLabelRendererState state;

  final AnimationController animationController;

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    cartesianChart._chartState.renderDatalabelRegions = <Rect>[];
    for (int i = 0; i < cartesianChart._chartSeries.visibleSeries.length; i++) {
      final XyDataSeries<dynamic, dynamic> series =
          cartesianChart._chartSeries.visibleSeries[i];
      if (series.dataLabelSettings.isVisible &&
          series.dataLabelSettings.builder == null) {
        for (dynamic Point in series._dataPoints) {
          if (series._visible && series.dataLabelSettings != null) {
            _drawDataLabel(
                canvas,
                series,
                series._chart,
                series.dataLabelSettings,
                Point,
                series._dataPoints.indexOf(Point),
                animation);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(_DataLabelPainter oldDelegate) => true;
}

void _calculateSeriesRegion(SfCartesianChart chartBase, int index) {
  final SfCartesianChart chart = chartBase;
  final List<Color> palette = chart.palette;
  int seriesIndex;
  final XyDataSeries<dynamic, dynamic> series =
      chart._chartSeries.visibleSeries[index];
  series._chart = chartBase;
  seriesIndex = series._chart._chartSeries.visibleSeries.indexOf(series);
  series._seriesColor = series.color ??
      palette[index % palette.length]; // sets default color for series.
  final ChartAxis xAxis = series._xAxis;
  final ChartAxis yAxis = series._yAxis;
  final Rect rect = _calculatePlotOffset(chart._chartAxis._axisClipRect,
      Offset(xAxis.plotOffset, yAxis.plotOffset));
  series._isRectSeries = (series._seriesType == 'column' ||
          series._seriesType == 'bar' ||
          series._seriesType == 'stackedcolumn' ||
          series._seriesType == 'stackedbar' ||
          series._seriesType == 'rangecolumn')
      ? true
      : false;
  series._regionalData = <dynamic, dynamic>{};
  _CartesianChartPoint<dynamic> point;
  _ChartLocation currentPoint;
  final num markerHeight = series.markerSettings.height,
      markerWidth = series.markerSettings.width;
  final dynamic tempSize = <dynamic>[];
  double bubbleSize;
  final bool isPointSeries =
      (series._seriesType == 'scatter' || series._seriesType == 'bubble')
          ? true
          : false;
  final bool isFastLine = (series._seriesType == 'fastline') ? true : false;

  if (series._seriesType == 'bubble') {
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      if (series.sizeValueMapper == null) {
        point.bubbleSize = 4;
        bubbleSize = point.bubbleSize.toDouble();
        tempSize.add(bubbleSize.abs());
      } else {
        if (point.bubbleSize == null) {
          continue;
        } else {
          bubbleSize = point.bubbleSize.toDouble();
          tempSize.add(bubbleSize.abs());
        }
      }
    }
    tempSize.sort();
  }
  if ((!isFastLine ||
          (isFastLine &&
              (series.markerSettings.isVisible ||
                  series.dataLabelSettings.isVisible ||
                  series.enableTooltip))) &&
      series._visible) {
    for (int pointIndex = 0;
        pointIndex < series._dataPoints.length;
        pointIndex++) {
      point = series._dataPoints[pointIndex];
      if (series._isRectSeries) {
        /// side by side range calculated
        final _VisibleRange sideBySideInfo =
            _calculateSideBySideInfo(series, chart);
        final num origin = math.max(yAxis._visibleRange.minimum, 0);

        /// Get the rectangle based on points
        final Rect rect = series._seriesType == 'stackedcolumn' ||
                series._seriesType == 'stackedbar'
            ? _calculateRectangle(
                point.xValue + sideBySideInfo.minimum,
                series._stackingValues[0].endValues[pointIndex],
                point.xValue + sideBySideInfo.maximum,
                series._stackingValues[0].startValues[pointIndex],
                series,
                chart)
            : _calculateRectangle(
                point.xValue + sideBySideInfo.minimum,
                series._seriesType == 'rangecolumn' ? point.high : point.yValue,
                point.xValue + sideBySideInfo.maximum,
                series._seriesType == 'rangecolumn' ? point.low : origin,
                series,
                chart);
        point.region = rect;

        ///Get shadow rect region
        final Rect shadowPointRect = _calculateShadowRectangle(
            point.xValue + sideBySideInfo.minimum,
            series._seriesType == 'rangecolumn' ? point.high : point.yValue,
            point.xValue + sideBySideInfo.maximum,
            series._seriesType == 'rangecolumn' ? point.high : origin,
            series,
            chart,
            Offset(xAxis?.plotOffset, yAxis?.plotOffset));
        point.trackerRectRegion = shadowPointRect;
        if (series._seriesType == 'rangecolumn') {
          point.markerPoint = chart._requireInvertedAxis != true
              ? _ChartLocation(rect.topCenter.dx, rect.topCenter.dy)
              : _ChartLocation(rect.centerRight.dx, rect.centerRight.dy);
          point.markerPoint2 = chart._requireInvertedAxis != true
              ? _ChartLocation(rect.bottomCenter.dx, rect.bottomCenter.dy)
              : _ChartLocation(rect.centerLeft.dx, rect.centerLeft.dy);
        } else {
          point.markerPoint = chart._requireInvertedAxis != true
              ? (yAxis.isInversed
                  ? (point.yValue.isNegative
                      ? _ChartLocation(rect.topCenter.dx, rect.topCenter.dy)
                      : _ChartLocation(
                          rect.bottomCenter.dx, rect.bottomCenter.dy))
                  : (point.yValue.isNegative
                      ? _ChartLocation(
                          rect.bottomCenter.dx, rect.bottomCenter.dy)
                      : _ChartLocation(rect.topCenter.dx, rect.topCenter.dy)))
              : (yAxis.isInversed
                  ? (point.yValue.isNegative
                      ? _ChartLocation(rect.centerRight.dx, rect.centerRight.dy)
                      : _ChartLocation(rect.centerLeft.dx, rect.centerLeft.dy))
                  : (point.yValue.isNegative
                      ? _ChartLocation(rect.centerLeft.dx, rect.centerLeft.dy)
                      : _ChartLocation(
                          rect.centerRight.dx, rect.centerRight.dy)));
        }
      } else if (isPointSeries) {
        /// Get the location of current point.
        currentPoint = _calculatePoint(point.xValue, point.yValue, xAxis, yAxis,
            chartBase._requireInvertedAxis, series, rect);
        point.markerPoint = currentPoint;
        if (series._seriesType == 'scatter') {
          point.region = Rect.fromLTRB(
              currentPoint.x - series.markerSettings.width,
              currentPoint.y - series.markerSettings.width,
              currentPoint.x + series.markerSettings.width,
              currentPoint.y + series.markerSettings.width);
        } else {
          final BubbleSeries<dynamic, dynamic> bubbleSeries = series;
          num bubbleRadius, sizeRange, radiusRange, maxSize, minSize;
          maxSize = tempSize[tempSize.length - 1];
          minSize = tempSize[0];
          sizeRange = maxSize - minSize;
          bubbleSize = ((point.bubbleSize) ?? 4).toDouble();
          if (bubbleSeries.sizeValueMapper == null)
            bubbleSeries.minimumRadius != null
                ? bubbleRadius = bubbleSeries.minimumRadius
                : bubbleRadius = bubbleSeries.maximumRadius;
          else {
            if ((bubbleSeries.maximumRadius != null) &&
                (bubbleSeries.minimumRadius != null)) {
              if (sizeRange == 0)
                bubbleRadius = bubbleSeries.maximumRadius;
              else {
                radiusRange =
                    (bubbleSeries.maximumRadius - bubbleSeries.minimumRadius) *
                        2;
                bubbleRadius =
                    (((bubbleSize.abs() - minSize) * radiusRange) / sizeRange) +
                        bubbleSeries.minimumRadius;
              }
            }
          }
          point.region = Rect.fromLTRB(
              currentPoint.x - 2 * bubbleRadius,
              currentPoint.y - 2 * bubbleRadius,
              currentPoint.x + 2 * bubbleRadius,
              currentPoint.y + 2 * bubbleRadius);
        }
      } else {
        /// Get the location of current point.
        currentPoint = series._seriesType == 'stackedarea' ||
                series._seriesType == 'stackedline'
            ? currentPoint = _calculatePoint(
                point.xValue,
                series._stackingValues[0].endValues[pointIndex],
                xAxis,
                yAxis,
                chartBase._requireInvertedAxis,
                series,
                rect)
            : _calculatePoint(point.xValue, point.yValue, xAxis, yAxis,
                chartBase._requireInvertedAxis, series, rect);
        point.region = Rect.fromLTWH(currentPoint.x - markerWidth,
            currentPoint.y - markerHeight, 2 * markerWidth, 2 * markerHeight);
        point.markerPoint = currentPoint;
      }

      /// For tooltip implementation
      if (series.enableTooltip != null &&
          series.enableTooltip &&
          point != null &&
          !point.isGap &&
          !point.isDrop) {
        final List<String> regionData = <String>[];
        String date;
        final List<dynamic> regionRect = <dynamic>[];
        if (xAxis is DateTimeAxis) {
          final DateFormat dateFormat =
              xAxis.dateFormat ?? xAxis._getLabelFormat(xAxis);
          date = dateFormat
              .format(DateTime.fromMillisecondsSinceEpoch(point.xValue));
        }
        xAxis is CategoryAxis
            ? regionData.add(point.x.toString())
            : xAxis is DateTimeAxis
                ? regionData.add(date.toString())
                : regionData.add(_getLabelValue(point.xValue, xAxis,
                        chart.tooltipBehavior.decimalPlaces)
                    .toString());
        if (series._seriesType == 'rangecolumn') {
          regionData.add(_getLabelValue(
                  point.high, yAxis, chart.tooltipBehavior.decimalPlaces)
              .toString());
          regionData.add(_getLabelValue(
                  point.low, yAxis, chart.tooltipBehavior.decimalPlaces)
              .toString());
        } else {
          regionData.add(_getLabelValue(
                  point.yValue, yAxis, chart.tooltipBehavior.decimalPlaces)
              .toString());
        }
        regionData.add(series.name ?? 'series $seriesIndex');
        regionRect.add(point.region);
        regionRect.add((series._isRectSeries)
            ? series._seriesType == 'column' ||
                    series._seriesType == 'stackedcolumn'
                ? point.yValue > 0
                    ? point.region.topCenter
                    : point.region.bottomCenter
                : point.region.topCenter
            : point.region.center);
        regionRect.add(point.pointColorMapper);
        regionRect.add(point.bubbleSize);
        if (series._seriesType == 'stackedcolumn' ||
            series._seriesType == 'stackedbar' ||
            series._seriesType == 'stackedarea' ||
            series._seriesType == 'stackedline') {
          regionData.add((point.cumulativeValue).toString());
        }
        series._regionalData[regionRect] = regionData;
      }
    }

    /// Store the marker points before rendering

    if (series._seriesType == 'scatter') {
      series._markerShapes = <Path>[];
      for (int i = 0; i < series._dataPoints.length; i++) {
        final _CartesianChartPoint<dynamic> point = series._dataPoints[i];
        final DataMarkerType markerType = series.markerSettings.shape;
        final Size size =
            Size(series.markerSettings.width, series.markerSettings.height);
        series._markerShapes.add(_getMarkerShapes(markerType,
            Offset(point.markerPoint.x, point.markerPoint.y), size, series));
      }
    } else {
      if (series.markerSettings.isVisible) {
        series._markerShapes = <Path>[];
        series._markerShapes2 = <Path>[];
        for (int i = 0; i < series._dataPoints.length; i++) {
          final _CartesianChartPoint<dynamic> point = series._dataPoints[i];
          final DataMarkerType markerType = series.markerSettings.shape;
          final Size size =
              Size(series.markerSettings.width, series.markerSettings.height);
          series._markerShapes.add(_getMarkerShapes(markerType,
              Offset(point.markerPoint.x, point.markerPoint.y), size, series));
          if (series._seriesType == 'rangecolumn') {
            series._markerShapes2.add(_getMarkerShapes(
                markerType,
                Offset(point.markerPoint2.x, point.markerPoint2.y),
                size,
                series));
          }
        }
      }
    }
  }
}

void _renderSeriesElements(
  Canvas canvas,
  CartesianSeries<dynamic, dynamic> series, [
  Animation<double> animationController,
  Color scatterColor,
  Color scatterBorderColor,
]) {
  Paint strokePaint;
  Paint fillPaint;
  final Size size =
      Size(series.markerSettings.width, series.markerSettings.height);
  final DataMarkerType markerType = series.markerSettings.shape;
  _CartesianChartPoint<dynamic> point;
  Color _borderColor;
  final bool hasPointColor = (series.pointColorMapper != null) ? true : false;
  final double opacity =
      (animationController != null) ? animationController.value : 1;
  for (int pointIndex = 0;
      pointIndex < series._dataPoints.length;
      pointIndex++) {
    point = series._dataPoints[pointIndex];
    _borderColor = series.markerSettings.borderColor ?? series._seriesColor;
    strokePaint = Paint()
      ..color = point.isEmpty == true
          ? (series.emptyPointSettings.borderWidth == 0
              ? Colors.transparent
              : series.emptyPointSettings.borderColor.withOpacity(opacity))
          : (series.markerSettings.borderWidth == 0
              ? Colors.transparent
              : ((hasPointColor && point.pointColorMapper != null)
                  ? point.pointColorMapper.withOpacity(opacity)
                  : _borderColor.withOpacity(opacity)))
      ..style = PaintingStyle.stroke
      ..strokeWidth = point.isEmpty == true
          ? series.emptyPointSettings.borderWidth
          : series.markerSettings.borderWidth;

    if (series.gradient != null && series.markerSettings.borderColor == null) {
      strokePaint = _getLinearGradientPaint(
          series.gradient,
          _getMarkerShapes(
                  markerType,
                  Offset(point.markerPoint.x, point.markerPoint.y),
                  size,
                  series)
              .getBounds(),
          series._chart._requireInvertedAxis);
      strokePaint.style = PaintingStyle.stroke;
      strokePaint.strokeWidth = point.isEmpty == true
          ? series.emptyPointSettings.borderWidth
          : series.markerSettings.borderWidth;
    }

    fillPaint = Paint()
      ..color = point.isEmpty == true
          ? series.emptyPointSettings.color
          : series.markerSettings.color != Colors.transparent
              ? series.markerSettings.color.withOpacity(opacity)
              : series.markerSettings.color
      ..style = PaintingStyle.fill;
    final bool isScatter = series._seriesType == 'scatter';

    /// Render marker points
    if ((series.markerSettings.isVisible || isScatter) &&
        point.isVisible &&
        point.isGap != true &&
        series._markerShapes != null &&
        series._markerShapes.isNotEmpty &&
        (!isScatter || series.markerSettings.shape == DataMarkerType.image)) {
      series.drawDataMarker(pointIndex, canvas, fillPaint, strokePaint,
          point.markerPoint.x, point.markerPoint.y);
      if (series.markerSettings.shape == DataMarkerType.image) {
        _loadImage(series, canvas, fillPaint, point.markerPoint.x,
            point.markerPoint.y);
        if (series._seriesType == 'rangecolumn')
          _loadImage(series, canvas, fillPaint, point.markerPoint2.x,
              point.markerPoint2.y);
      }
    }
  }
}

/// Load image from asset to render marker
void _loadImage(CartesianSeries<dynamic, dynamic> series, Canvas canvas,
    Paint fillPaint, double pointX, double pointY) {
  if (series.markerSettings._image != null) {
    final double imageWidth = 2 * series.markerSettings.width;
    final double imageHeight = 2 * series.markerSettings.height;
    final Rect positionRect = Rect.fromLTWH(pointX - imageWidth / 2,
        pointY - imageHeight / 2, imageWidth, imageHeight);
    canvas.drawImageNine(
        series.markerSettings._image, positionRect, positionRect, fillPaint);
  }
}

/// This method is for to calculate and rendering the length and Offsets of the dashed lines
void _drawDashedLine(Canvas canvas, CartesianSeries<dynamic, dynamic> series,
    Paint paint, Path path,
    [List<Path> pathList, List<Color> colorList]) {
  bool even = false;
  for (int i = 1; i < series.dashArray.length; i = i + 2) {
    if (series.dashArray[i] == 0) {
      even = true;
    }
  }
  if (even == false) {
    paint.isAntiAlias = false;
    canvas.drawPath(
        _dashPath(
          path,
          dashArray: _CircularIntervalList<double>(series.dashArray),
        ),
        paint);
  } else
    canvas.drawPath(path, paint);
}
