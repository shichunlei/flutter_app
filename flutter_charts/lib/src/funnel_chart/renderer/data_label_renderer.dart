part of flutter_charts;

// ignore: must_be_immutable
class _FunnelDataLabelRenderer extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _FunnelDataLabelRenderer({this.funnelChart, this.show});

  final SfFunnelChart funnelChart;

  bool show;

  _FunnelDataLabelRendererState state;

  @override
  State<StatefulWidget> createState() => _FunnelDataLabelRendererState();
}

class _FunnelDataLabelRendererState extends State<_FunnelDataLabelRenderer>
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
        animationControllersList[index]
            .dispose(); // Need to dispose all the animation controller instance otherwise it will cause memory leak
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
    Widget dataLabelWidget;
    dataLabelWidget = Container(
        child: CustomPaint(
            painter: _FunnelDataLabelPainter(
                funnelChart: widget.funnelChart,
                animation: widget.funnelChart._chartState.chartElementAnimation,
                state: this,
                animationController:
                    widget.funnelChart._chartState.animationController)));
    return dataLabelWidget;
  }
}

class _FunnelDataLabelPainter extends CustomPainter {
  _FunnelDataLabelPainter(
      {this.funnelChart, this.state, this.animationController, this.animation})
      : super(repaint: animationController);

  final SfFunnelChart funnelChart;

  final _FunnelDataLabelRendererState state;

  final AnimationController animationController;

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final FunnelSeries<dynamic, dynamic> series = funnelChart.series;
    if (series.dataLabelSettings != null &&
        series.dataLabelSettings.isVisible) {
      _renderFunnelDataLabel(series, canvas, funnelChart, animation);
    }
  }

  @override
  bool shouldRepaint(_FunnelDataLabelPainter oldDelegate) => true;
}

void _renderFunnelDataLabel(FunnelSeries<dynamic, dynamic> series,
    Canvas canvas, SfFunnelChart chart, Animation<double> animation) {
  _PointInfo<dynamic> point;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final num angle = dataLabel.angle;
  Offset labelLocation;
  chart = chart;
  final SmartLabelMode smartLabelMode = chart.smartLabelMode;
  const int labelPadding = 2;
  String label;
  final double animateOpacity = animation != null ? animation.value : 1;
  DataLabelRenderArgs dataLabelArgs;
  ChartTextStyle dataLabelStyle;
  final List<Rect> renderDatalabelRegions = <Rect>[];
  for (int pointIndex = 0;
      pointIndex < series._renderPoints.length;
      pointIndex++) {
    point = series._renderPoints[pointIndex];
    if (point.isVisible) {
      label = point.text;
      dataLabelStyle = dataLabel.textStyle;
      if (chart.onDataLabelRender != null) {
        dataLabelArgs = DataLabelRenderArgs();
        dataLabelArgs.text = label;
        dataLabelArgs.textStyle = dataLabelStyle;
        dataLabelArgs.series = series;
        dataLabelArgs.dataPoints = series._renderPoints;
        dataLabelArgs.pointIndex = pointIndex;
        chart.onDataLabelRender(dataLabelArgs);
        label = dataLabelArgs.text;
        dataLabelStyle = dataLabelArgs.textStyle;
      }
      dataLabelStyle = chart.onDataLabelRender == null
          ? _getDataLabelTextStyle(series, point, chart)
          : dataLabelStyle;
      final Size textSize = _measureText(label, dataLabelStyle);

      if (dataLabel.labelPosition == ChartDataLabelPosition.inside) {
        labelLocation = point.symbolLocation;
        labelLocation = Offset(
            labelLocation.dx -
                (textSize.width / 2) +
                (angle == 0 ? 0 : textSize.width / 2),
            labelLocation.dy -
                (textSize.height / 2) +
                (angle == 0 ? 0 : textSize.height / 2));
        point.labelRect = Rect.fromLTWH(
            labelLocation.dx - labelPadding,
            labelLocation.dy - labelPadding,
            textSize.width + (2 * labelPadding),
            textSize.height + (2 * labelPadding));
        final bool isDataLabelCollide =
            _isCollide(point.labelRect, renderDatalabelRegions, point.region);
        if (isDataLabelCollide && smartLabelMode == SmartLabelMode.shift) {
          point.saturationRegionOutside = true;
          point.renderPosition = ChartDataLabelPosition.outside;
          _renderOutsideFunnelDataLabel(
              canvas,
              label,
              point,
              textSize,
              pointIndex,
              series,
              chart,
              dataLabelStyle,
              renderDatalabelRegions,
              animateOpacity);
        } else if (smartLabelMode == SmartLabelMode.none ||
            (!isDataLabelCollide && smartLabelMode == SmartLabelMode.shift) ||
            (!isDataLabelCollide && smartLabelMode == SmartLabelMode.hide)) {
          point.renderPosition = ChartDataLabelPosition.inside;
          _drawFunnelLabel(
              point.labelRect,
              labelLocation,
              label,
              null,
              canvas,
              series,
              point,
              pointIndex,
              chart,
              dataLabelStyle,
              renderDatalabelRegions,
              animateOpacity);
        }
      } else {
        point.renderPosition = ChartDataLabelPosition.outside;
        _renderOutsideFunnelDataLabel(
            canvas,
            label,
            point,
            textSize,
            pointIndex,
            series,
            chart,
            dataLabelStyle,
            renderDatalabelRegions,
            animateOpacity);
      }
    }
  }
}

void _renderOutsideFunnelDataLabel(
    Canvas canvas,
    String label,
    _PointInfo<dynamic> point,
    Size textSize,
    int pointIndex,
    FunnelSeries<dynamic, dynamic> series,
    SfFunnelChart chart,
    ChartTextStyle textStyle,
    List<Rect> renderDatalabelRegions,
    double animateOpacity) {
  Path connectorPath;
  Rect rect;
  Offset labelLocation;
  final EdgeInsets margin = series.dataLabelSettings.margin;
  final double marginLeft = margin.left;
  final double marginTop = margin.left;
  final double marginRight = margin.left;
  final double marginBottom = margin.left;
  const int lineLength = 10;
  final ConnectorLineSettings connector =
      series.dataLabelSettings.connectorLineSettings;
  const num regionPadding = 12;
  connectorPath = Path();
  final num connectorLength = _percentToValue(
          connector.length != null ? connector.length : '0%',
          chart._chartState.chartAreaRect.width / 2) +
      series._maximumDataLabelRegion.width / 2 -
      regionPadding;
  final Offset startPoint = series._renderPoints[pointIndex].symbolLocation;
  final Offset endPoint = Offset(
      series._renderPoints[pointIndex].symbolLocation.dx + connectorLength,
      series._renderPoints[pointIndex].symbolLocation.dy);
  connectorPath.moveTo(startPoint.dx, startPoint.dy);
  if (connector.type == ConnectorType.line) {
    connectorPath.lineTo(endPoint.dx, endPoint.dy);
  }
  point.dataLabelPosition = Position.right;
  switch (point.dataLabelPosition) {
    case Position.right:
      connector.type == ConnectorType.line
          ? connectorPath.lineTo(endPoint.dx + lineLength, endPoint.dy)
          : connectorPath.quadraticBezierTo(
              endPoint.dx, endPoint.dy, endPoint.dx + lineLength, endPoint.dy);
      rect = Rect.fromLTWH(
          endPoint.dx + lineLength,
          endPoint.dy - (textSize.height / 2) - marginTop,
          textSize.width + marginLeft + marginRight,
          textSize.height + marginTop + marginBottom);
      break;
    case Position.left:
      connector.type == ConnectorType.line
          ? connectorPath.lineTo(endPoint.dx - lineLength, endPoint.dy)
          : connectorPath.quadraticBezierTo(
              endPoint.dx, endPoint.dy, endPoint.dx - lineLength, endPoint.dy);
      rect = Rect.fromLTWH(
          endPoint.dx - lineLength - marginRight - textSize.width - marginLeft,
          endPoint.dy - (textSize.height / 2) - marginTop,
          textSize.width + marginLeft + marginRight,
          textSize.height + marginTop + marginBottom);
      break;
  }

  point.labelRect = rect;
  labelLocation = Offset(
      rect.left + marginLeft, rect.top + rect.height / 2 - textSize.height / 2);
  final Rect containerRect = chart._chartState.chartAreaRect;
  if (series.dataLabelSettings.builder == null) {
    Rect lastRenderedLabelRegion;
    if (renderDatalabelRegions.isNotEmpty) {
      lastRenderedLabelRegion =
          renderDatalabelRegions[renderDatalabelRegions.length - 1];
    }
    if (!_isFunnelLabelItersect(rect, lastRenderedLabelRegion) &&
        (rect.left > containerRect.left &&
            rect.left + rect.width <
                containerRect.left + containerRect.width) &&
        rect.top > containerRect.top &&
        rect.top + rect.height < containerRect.top + containerRect.height) {
      _drawFunnelLabel(
          rect,
          labelLocation,
          label,
          connectorPath,
          canvas,
          series,
          point,
          pointIndex,
          chart,
          textStyle,
          renderDatalabelRegions,
          animateOpacity);
    } else {
      if (rect.top < chart._chartState.chartAreaRect.top) {
        _drawFunnelLabel(
            rect,
            labelLocation,
            label,
            connectorPath,
            canvas,
            series,
            point,
            pointIndex,
            chart,
            textStyle,
            renderDatalabelRegions,
            animateOpacity);
      }
    }
  }
}

bool _isFunnelLabelItersect(Rect rect, Rect previousRect) {
  bool isIntersect = false;
  const num padding = 2;
  if (previousRect != null && (rect.bottom + padding) > previousRect.top) {
    isIntersect = true;
  }
  return isIntersect;
}

void _drawFunnelLabel(
    Rect labelRect,
    Offset location,
    String label,
    Path connectorPath,
    Canvas canvas,
    FunnelSeries<dynamic, dynamic> series,
    _PointInfo<dynamic> point,
    int pointIndex,
    SfFunnelChart chart,
    ChartTextStyle textStyle,
    List<Rect> renderDataLabelRegions,
    double animateOpacity) {
  Paint rectPaint;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final ConnectorLineSettings connector = dataLabel.connectorLineSettings;
  if (connectorPath != null) {
    canvas.drawPath(
        connectorPath,
        Paint()
          ..color = connector.width <= 0
              ? Colors.transparent
              : connector.color ??
                  point.fill.withOpacity(!chart._chartState._isLegendToggled
                      ? animateOpacity
                      : dataLabel.opacity)
          ..strokeWidth = connector.width
          ..style = PaintingStyle.stroke);
  }

  if (dataLabel.builder == null) {
    final double strokeWidth = dataLabel.borderWidth;
    final Color labelFill = dataLabel.color != null
        ? dataLabel.color
        : (dataLabel.useSeriesColor ? point.fill : dataLabel.color);
    final Color strokeColor =
        dataLabel.borderColor.withOpacity(dataLabel.opacity) ?? point.fill;
    if (strokeWidth != null && strokeWidth > 0) {
      rectPaint = Paint()
        ..color = strokeColor.withOpacity(!chart._chartState._isLegendToggled
            ? animateOpacity
            : dataLabel.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      _drawLabelRect(
          rectPaint,
          Rect.fromLTRB(
              labelRect.left, labelRect.top, labelRect.right, labelRect.bottom),
          dataLabel.borderRadius,
          canvas);
    }
    if (labelFill != null) {
      _drawLabelRect(
          Paint()
            ..color = labelFill.withOpacity(!chart._chartState._isLegendToggled
                ? (animateOpacity - (1 - dataLabel.opacity)) < 0
                    ? 0
                    : animateOpacity - (1 - dataLabel.opacity)
                : dataLabel.opacity)
            ..style = PaintingStyle.fill,
          Rect.fromLTRB(
              labelRect.left, labelRect.top, labelRect.right, labelRect.bottom),
          dataLabel.borderRadius,
          canvas);
    }
    textStyle.color = (textStyle.color ?? Colors.black).withOpacity(
        !chart._chartState._isLegendToggled
            ? animateOpacity
            : dataLabel.opacity);
    _drawText(canvas, label, location, textStyle, dataLabel.angle);
    renderDataLabelRegions.add(labelRect);
  }
}
