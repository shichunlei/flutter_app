part of flutter_charts;

bool _isPointInPolygon(List<Offset> polygon, dynamic point) {
  bool p = false;
  num i = -1;
  final num l = polygon.length;
  num j;
  for (j = l - 1; ++i < l; j = i)
    ((polygon[i].dy <= point.dy && point.dy < polygon[j].dy) ||
            (polygon[j].dy <= point.dy && point.dy < polygon[i].dy)) &&
        (point.dx <
            (polygon[j].dx - polygon[i].dx) *
                    (point.dy - polygon[i].dy) /
                    (polygon[j].dy - polygon[i].dy) +
                polygon[i].dx) &&
        // ignore: unnecessary_statements
        (p = !p);
  return p;
}

void _findTemplates(dynamic chart) {
  Offset labelLocation;
  const num lineLength = 10;
  _PointInfo<dynamic> point;
  Widget labelWidget;
  chart._chartState.templates = <_ChartTemplateInfo>[];
  chart._chartState.dataLabelTemplateRegions = <Rect>[];
  for (int k = 0; k < chart._chartSeries.visibleSeries.length; k++) {
    final dynamic series = chart._chartSeries.visibleSeries[k];
    if (series.dataLabelSettings.isVisible &&
        series.dataLabelSettings.builder != null) {
      for (int i = 0; i < series._renderPoints.length; i++) {
        point = series._renderPoints[i];
        ChartAlignment labelAlign;
        if (point.isVisible) {
          labelWidget = series.dataLabelSettings
              .builder(series.dataSource[i], point, series, i, k);
          if (series.dataLabelSettings.labelPosition ==
              ChartDataLabelPosition.inside) {
            labelLocation = point.symbolLocation;
            labelAlign = ChartAlignment.center;
          } else {
            labelLocation = point.symbolLocation;
            labelLocation = Offset(
                point.dataLabelPosition == Position.right
                    ? labelLocation.dx + lineLength + 5
                    : labelLocation.dx - lineLength - 5,
                labelLocation.dy);
            labelAlign = point.dataLabelPosition == Position.left
                ? ChartAlignment.far
                : ChartAlignment.near;
          }
          chart._chartState.templates.add(_ChartTemplateInfo(
              key: GlobalKey(),
              templateType: 'DataLabel',
              pointIndex: i,
              seriesIndex: k,
              needMeasure: true,
              clipRect: chart._chartState.chartAreaRect,
              animationDuration: 500,
              widget: labelWidget,
              horizontalAlignment: labelAlign,
              verticalAlignment: ChartAlignment.center,
              location: labelLocation));
        }
      }
    }
  }
}

void _renderTemplates(dynamic chart) {
  if (chart._chartState.templates.isNotEmpty) {
    for (int i = 0; i < chart._chartState.templates.length; i++) {
      final _ChartTemplateInfo chartTemplateInfo =
          chart._chartState.templates[i];
      chartTemplateInfo.animationDuration = !chart._chartState.initialRender
          ? 0
          : chartTemplateInfo.animationDuration;
    }
    chart._chartState._chartTemplate = _ChartTemplate(
        templates: chart._chartState.templates,
        render: chart._chartState.animateCompleted,
        chart: chart);
    chart._chartState._chartWidgets.add(chart._chartState._chartTemplate);
  }
}

///To get circular series data label saturation color
Color _getPyramidFunnelColor(
    dynamic currentPoint, dynamic series, dynamic chart) {
  Color color;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  if (currentPoint.renderPosition == ChartDataLabelPosition.inside &&
      !currentPoint.saturationRegionOutside) {
    color = _innerColor(dataLabel.color, currentPoint.fill, chart._chartTheme);
  } else {
    color = _outerColor(
        dataLabel.color,
        dataLabel.useSeriesColor
            ? currentPoint.fill
            : (chart.backgroundColor != null
                ? chart._chartTheme.plotAreaBackgroundColor
                : null),
        chart._chartTheme);
  }

  return _getSaturationColor(color);
}

///To get inner data label color
Color _innerColor(Color dataLabelColor, Color pointColor, _ChartTheme theme) =>
    dataLabelColor != null
        ? dataLabelColor
        : pointColor != null ? pointColor : Colors.black;

///To get outer data label color
Color _outerColor(
        Color dataLabelColor, Color backgroundColor, _ChartTheme theme) =>
    dataLabelColor != null
        ? dataLabelColor
        : backgroundColor != null
            ? backgroundColor
            : theme.brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 1)
                : Colors.black;

ChartTextStyle _getDataLabelTextStyle(
    dynamic series, dynamic point, dynamic chart) {
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final Color fontColor = dataLabel.textStyle.color != null
      ? dataLabel.textStyle.color
      : _getPyramidFunnelColor(point, series, chart);
  final ChartTextStyle textStyle = ChartTextStyle(
      color: fontColor,
      fontSize: dataLabel.textStyle.fontSize,
      fontFamily: dataLabel.textStyle.fontFamily,
      fontStyle: dataLabel.textStyle.fontStyle,
      fontWeight: dataLabel.textStyle.fontWeight);
  return textStyle;
}

bool _isNeedExplode(int pointIndex, dynamic series, dynamic chart) {
  bool isNeedExplode = false;
  if (series.explode) {
    if (chart._chartState.initialRender) {
      if (pointIndex == series.explodeIndex) {
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
