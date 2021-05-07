part of flutter_charts;

class _ChartPoint<D> {
  _ChartPoint(this.x, this.y);
  dynamic x;
  num y;
  num degree;
  num startAngle;
  num endAngle;
  num midAngle;
  Offset center;
  String text;
  Color fill;
  Color color;
  Color strokeColor;
  D sortValue;
  num strokeWidth;
  num innerRadius;
  num outerRadius;
  bool isExplode;
  bool isShadow;
  bool isEmpty = false;
  bool isVisible = true;
  bool isSelected = false;
  Position dataLabelPosition;
  ChartDataLabelPosition renderPosition;
  Rect labelRect;
  Size dataLabelSize = const Size(0, 0);
  bool saturationRegionOutside = false;
  num yRatio;
  num heightRatio;
  String radius;
  Color pointColor;
}

class _Region {
  _Region(
      this.start,
      this.end,
      this.startAngle,
      this.endAngle,
      this.seriesIndex,
      this.pointIndex,
      this.center,
      this.innerRadius,
      this.outerRadius);
  int seriesIndex;
  int pointIndex;
  num startAngle;
  num start;
  num end;
  num endAngle;
  Offset center;
  num innerRadius;
  num outerRadius;
}

class _StyleOptions {
  _StyleOptions(this.fill, this.strokeWidth, this.strokeColor, [this.opacity]);
  Color fill;
  Color strokeColor;
  double opacity;
  num strokeWidth;
}

/// Customizes the connector line.
class ConnectorLineSettings {
  ConnectorLineSettings(
      {this.length, double width, ConnectorType type, this.color})
      : width = width ?? 1.0,
        type = type ?? ConnectorType.line;

  ///Length of the connector line.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           dataLabelSettings: DataLabelSettings(
  ///            connectorLineSettings: ConnectorLineSettings(
  ///            length: '8%
  ///           )
  ///          )
  ///        ));
  ///}
  ///```
  final String length;

  ///Width of the connector line.
  ///
  ///Defaults to 1.0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           dataLabelSettings: DataLabelSettings(
  ///            connectorLineSettings: ConnectorLineSettings(
  ///            width: 2
  ///           )
  ///          )
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the connector line.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           dataLabelSettings: DataLabelSettings(
  ///            connectorLineSettings: ConnectorLineSettings(
  ///            color: Colors.red,
  ///           )
  ///          )
  ///        ));
  ///}
  ///```
  final Color color;

  ///Type of the connector line.
  ///
  ///Defaults to ConnectorType.line
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           dataLabelSettings: DataLabelSettings(
  ///            connectorLineSettings: ConnectorLineSettings(
  ///             type: ConnectorType.curve
  ///           )
  ///          )
  ///        ));
  ///}
  ///```
  final ConnectorType type;
}

class _ChartInteraction {
  _ChartInteraction(this.seriesIndex, this.pointIndex, this.series, this.point,
      [this.region]);
  int seriesIndex;
  int pointIndex;
  dynamic series;
  dynamic point;
  _Region region;
}

///To get circular series data label saturation color
Color _getCircularDatalabelColor(_ChartPoint<dynamic> currentPoint,
    CircularSeries<dynamic, dynamic> series, SfCircularChart chart) {
  Color color;
  final DataLabelSettings dataLabel = series.dataLabelSettings;
  final String _seriesType = series._seriesType == 'pie'
      ? 'Pie'
      : series._seriesType == 'doughnut'
          ? 'Doughnut'
          : series._seriesType == 'radialbar' ? 'RadialBar' : 'Default';
  switch (_seriesType) {
    case 'Pie':
    case 'Doughnut':
      if (currentPoint.renderPosition == ChartDataLabelPosition.inside &&
          !currentPoint.saturationRegionOutside) {
        color = _getInnerColor(
            dataLabel.color, currentPoint.fill, chart._chartTheme);
      } else {
        color = _getOuterColor(
            dataLabel.color,
            dataLabel.useSeriesColor
                ? currentPoint.fill
                : (chart.backgroundColor ??
                    chart._chartTheme.plotAreaBackgroundColor),
            chart._chartTheme);
      }
      break;
    case 'RadialBar':
      final RadialBarSeries<dynamic, dynamic> radialBar = series;
      color = radialBar.trackColor;
      break;
    default:
      color = Colors.white;
  }
  return _getSaturationColor(color);
}

///To get inner data label color
Color _getInnerColor(
        Color dataLabelColor, Color pointColor, _ChartTheme theme) =>
    dataLabelColor != null
        ? dataLabelColor
        : pointColor != null
            ? pointColor
            : theme.brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 1)
                : Colors.black;

///To get outer data label color
Color _getOuterColor(
        Color dataLabelColor, Color backgroundColor, _ChartTheme theme) =>
    dataLabelColor != null
        ? dataLabelColor
        : backgroundColor != Colors.transparent
            ? backgroundColor
            : theme.brightness == Brightness.light
                ? const Color.fromRGBO(255, 255, 255, 1)
                : Colors.black;

/// Customizes the annotation of circular chart.
class CircularChartAnnotation {
  CircularChartAnnotation(
      {int angle,
      String radius,
      this.widget,
      String height,
      String width,
      ChartAlignment horizontalAlignment,
      ChartAlignment verticalAlignment})
      : angle = angle ?? 0,
        radius = radius ?? '0%',
        height = height ?? '0%',
        width = width ?? '0%',
        verticalAlignment = verticalAlignment ?? ChartAlignment.center,
        horizontalAlignment = horizontalAlignment ?? ChartAlignment.center;

  ///Angle to rotate the annotation.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    angle: 40,
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final int angle;

  ///Radius for placing the annotation. The value ranges from 0% to 100%.
  ///
  ///Defaults to 0%
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    radius: '10%'
  ///                    child: Container(
  ///                    child: const Text('Empty data'),
  ///               ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final String radius;

  ///Considers any widget as annotation.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    child: Container(
  ///                     child:Text('Annotation')),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Widget widget;

  ///Height of the annotation.
  ///
  ///Defaults to 0%.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    height: '10%',
  ///                    child: Container(
  ///                    child: const Text('Empty data'),
  ///                 ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final String height;

  ///Width of the annotation.
  ///
  ///Defaults to 0%.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    width: '10%',
  ///                    child: Container(
  ///                    child: const Text('Empty data'),
  ///                 ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final String width;

  ///Aligns the annotation horizontally. Alignment can be set to near, far, or center.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer [ChartAlignment]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    horizonatlAlignment: ChartAlignment.near
  ///                    child: Container(
  ///                    child: const Text('Empty data'),
  ///                 ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final ChartAlignment horizontalAlignment;

  ///Aligns the annotation vertically. Alignment can be set to near, far, or center.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer [ChartAlignment]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                    verticalAlignment: ChartAlignment.near
  ///                    child: Container(
  ///                    child: const Text('Empty data'),
  ///                 ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final ChartAlignment verticalAlignment;
}

bool _checkIsAnyPointSelect(CircularSeries<dynamic, dynamic> series,
    _ChartPoint<dynamic> point, SfCircularChart chart) {
  bool isAnyPointSelected = false;
  if (series.initialSelectedDataIndexes.isNotEmpty) {
    for (int i = 0; i < series.initialSelectedDataIndexes.length; i++) {
      final int data = series.initialSelectedDataIndexes[i];
      for (int j = 0; j < series._renderPoints.length; j++) {
        if (j == data) {
          isAnyPointSelected = true;
          break;
        }
      }
    }
  }
  return isAnyPointSelected;
}
