part of flutter_charts;

class _FunnelSeriesBase<T, D> extends ChartSeries<T, D> {
  _FunnelSeriesBase({
    this.dataSource,
    this.xValueMapper,
    this.yValueMapper,
    this.pointColorMapper,
    this.textFieldMapper,
    this.name,
    this.explodeIndex,
    String neckWidth,
    String neckHeight,
    String height,
    String width,
    double gapRatio,
    EmptyPointSettings emptyPointSettings,
    String explodeOffset,
    bool explode,
    ActivationMode explodeGesture,
    Color borderColor,
    double borderWidth,
    LegendIconType legendIconType,
    DataLabelSettings dataLabelSettings,
    double animationDuration,
    double opacity,
    SelectionSettings selectionSettings,
    List<int> initialSelectedDataIndexes,
  })  : neckWidth = neckWidth ?? '20%',
        neckHeight = neckHeight ?? '20%',
        height = height ?? '80%',
        width = width ?? '80%',
        gapRatio = gapRatio ?? 0,
        emptyPointSettings = emptyPointSettings ?? EmptyPointSettings(),
        explodeOffset = explodeOffset ?? '10%',
        explode = explode ?? false,
        explodeGesture = explodeGesture ?? ActivationMode.singleTap,
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0.0,
        legendIconType = legendIconType ?? LegendIconType.triangle,
        dataLabelSettings = dataLabelSettings ?? DataLabelSettings(),
        animationDuration = animationDuration ?? 1500,
        opacity = opacity ?? 1,
        initialSelectedDataIndexes = initialSelectedDataIndexes ?? <int>[],
        selectionSettings = selectionSettings ?? SelectionSettings(),
        super(
            name: name,
            dataSource: dataSource,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper) {
    _renderer = _FunnelSeriesRender();
  }

  ///A collection of data required for rendering the series. If no data source is specified,
  ///empty chart will be rendered without series.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///              )],
  ///        ));
  ///}
  final List<T> dataSource;

  ///Maps the field name, which will be considered as x-values.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                xValueMapper: (ChartData data, _) => data.xVal,
  ///              )],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal);
  ///   final String xVal;
  ///   final int yVal;
  ///}
  ///```
  final ChartIndexedValueMapper<D> xValueMapper;

  ///Maps the field name, which will be considered as y-values.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                dataSource: <ChartData>[
  ///                   ChartData('USA', 10),
  ///                   ChartData('China', 11),
  ///                   ChartData('Russia', 9),
  ///                   ChartData('Germany', 10),
  ///                ],
  ///                yValueMapper: (ChartData data, _) => data.yVal,
  ///              )],
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal);
  ///   final String xVal;
  ///   final int yVal;
  ///}
  ///```
  final ChartIndexedValueMapper<num> yValueMapper;

  ///Name of the series.
  ///
  ///Defaults to ''
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                name: 'Pyramid'
  ///        ));
  ///}
  ///```
  final String name;

  ///Neck height of funnel.
  ///
  ///Defaults to '20%'
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                neckHeight: '10%'
  ///        ));
  ///}
  ///```
  final String neckHeight;

  ///Neck width of funnel.
  ///
  ///Defaults to '20%'
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///                neckWidth: '10%'
  ///        ));
  ///}
  ///```
  final String neckWidth;

  ///Height of the series.
  ///
  ///Defaults to '80%'
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               height:'50%'
  ///        ));
  ///}
  ///```
  final String height;

  ///Width of the series.
  ///
  ///Defaults to '80%'
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               width:'50%'
  ///        ));
  ///}
  ///```
  final String width;

  ///Gap ratio between the segments of pyramid. Ranges from 0 to 1
  ///
  ///Defaults to 0.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               gapRatio: 0.3
  ///        ));
  ///}
  ///```
  final double gapRatio;

  ///Customizes the empty data points in the series
  ///
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               emptyPointSettings: EmptyPointSettings (color: Colors.red))
  ///        ));
  ///}
  ///```
  final EmptyPointSettings emptyPointSettings;

  ///Offset of exploded slice. The value ranges from 0% to 100%.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               explodeOffset: '5%')
  ///        ));
  ///}
  ///```
  final String explodeOffset;

  ///Enables or disables the explode of slices on tap.
  ///
  ///Default to false.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               explode: true)
  ///        ));
  ///}
  ///```
  final bool explode;

  ///Gesture for activating the explode. Explode can be activated in tap, double tap,
  ///and long press.
  ///
  ///Defaults to ActivationMode.tap
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               explode: true,
  ///               explodeGesture: ActivationMode.singleTap
  ///             )
  ///        ));
  ///}
  ///```
  final ActivationMode explodeGesture;

  ///Border width of the data points in the series.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               borderWidth: 2
  ///             )
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Border color of the data points in the series.
  ///
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               borderColor: Colors.red
  ///             )
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Shape of the legend icon. Any shape in the LegendIconType can be applied to this property.
  ///By default, icon will be rendered based on the type of the series.
  ///
  ///
  ///Also refer [LegendIconType]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               legendIconType: LegendIconType.diamond,
  ///             )
  ///        ));
  ///}
  ///```
  final LegendIconType legendIconType;

  ///Enables the datalabel of the series
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               dataLabelSettings: DataLabelSettings(isVisible: true),
  ///             )
  ///        ));
  ///}
  ///```
  final DataLabelSettings dataLabelSettings;

  //Duration for animating the data points.
  ///
  ///Defaults to 1500
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               animationDuration: 2000,
  ///             )
  ///        ));
  ///}
  ///```
  final double animationDuration;

  ///Maps the field name, which will be considered as data point color.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               pointColorMapper: (ChartData data, _) => data.pointColor,
  ///             )
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.pointColor]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final Color pointColor;
  ///}
  ///```
  final ChartIndexedValueMapper<Color> pointColorMapper;

  ///Maps the field name, which will be considered as text for data label.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               textFieldMapper: (ChartData data, _) => data.xVal,
  ///             )
  ///        ));
  ///}
  ///class ChartData {
  ///   ChartData(this.xVal, this.yVal, [this.pointColor]);
  ///   final String xVal;
  ///   final int yVal;
  ///   final Color pointColor;
  ///}
  ///```
  final ChartIndexedValueMapper<String> textFieldMapper;

  ///Opacity of the series. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               opacity: 0.5,
  ///             )
  ///        ));
  ///}
  ///```
  final double opacity;

  ///Customizes the selection of series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///             )
  ///        ));
  ///}
  ///```
  final SelectionSettings selectionSettings;

  ///Index of the slice to explode it at the initial rendering.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<ChartData, String>(
  ///               explodeIndex: 1,
  ///               explode: true
  ///             )
  ///        ));
  ///}
  ///```
  final num explodeIndex;

  List<int> initialSelectedDataIndexes;

  //Internal variables
  String _seriesType;
  List<_PointInfo<dynamic>> _dataPoints;
  List<_PointInfo<dynamic>> _renderPoints;
  num _sumOfPoints;
  List<_Region> _pointRegions;
  Size _triangleSize;
  Size _neckSize;
  num _explodeDistance;
  Rect _maximumDataLabelRegion;
  _FunnelSeriesRender _renderer;
}

///Renders the funnel series
class FunnelSeries<T, D> extends _FunnelSeriesBase<T, D> {
  FunnelSeries({
    List<T> dataSource,
    ChartValueMapper<T, D> xValueMapper,
    ChartValueMapper<T, num> yValueMapper,
    ChartValueMapper<T, Color> pointColorMapper,
    ChartValueMapper<T, String> textFieldMapper,
    String name,
    String neckWidth,
    String neckHeight,
    String height,
    String width,
    double gapRatio,
    LegendIconType legendIconType,
    EmptyPointSettings emptyPointSettings,
    DataLabelSettings dataLabelSettings,
    double animationDuration,
    double opacity,
    Color borderColor,
    double borderWidth,
    bool explode,
    ActivationMode explodeGesture,
    String explodeOffset,
    SelectionSettings selectionSettings,
    num explodeIndex,
    List<int> initialSelectedDataIndexes,
  }) : super(
            dataSource: dataSource,
            xValueMapper: (int index) => xValueMapper(dataSource[index], index),
            yValueMapper: (int index) => yValueMapper(dataSource[index], index),
            pointColorMapper: (int index) => pointColorMapper != null
                ? pointColorMapper(dataSource[index], index)
                : null,
            textFieldMapper: (int index) => textFieldMapper != null
                ? textFieldMapper(dataSource[index], index)
                : null,
            name: name,
            neckWidth: neckWidth,
            neckHeight: neckHeight,
            height: height,
            width: width,
            gapRatio: gapRatio,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabelSettings,
            legendIconType: legendIconType,
            opacity: opacity,
            borderColor: borderColor,
            borderWidth: borderWidth,
            animationDuration: animationDuration,
            explode: explode,
            explodeIndex: explodeIndex,
            explodeGesture: explodeGesture,
            explodeOffset: explodeOffset,
            selectionSettings: selectionSettings,
            initialSelectedDataIndexes: initialSelectedDataIndexes);
}

class _FunnelChartPainter extends CustomPainter {
  _FunnelChartPainter({
    this.chart,
    this.seriesIndex,
    this.isRepaint,
    this.animationController,
    this.seriesAnimation,
    ValueNotifier<num> notifier,
  }) : super(repaint: notifier);
  final SfFunnelChart chart;
  final int seriesIndex;
  final bool isRepaint;
  final AnimationController animationController;
  final Animation<double> seriesAnimation;
  FunnelSeries<dynamic, dynamic> series;
  static _PointInfo<dynamic> point;

  @override
  void paint(Canvas canvas, Size size) {
    series = chart._chartSeries.visibleSeries[seriesIndex];
    for (int pointIndex = 0;
        pointIndex < series._renderPoints.length;
        pointIndex++) {
      if (series._renderPoints[pointIndex].isVisible) {
        final double animationFactor =
            seriesAnimation != null ? seriesAnimation.value : 1;
        if (series.animationDuration > 0 &&
            !chart._chartState._isLegendToggled) {
          final double factor = (chart._chartState.chartAreaRect.top +
                  chart._chartState.chartAreaRect.height) -
              animationFactor *
                  (chart._chartState.chartAreaRect.top +
                      chart._chartState.chartAreaRect.height);
          final double height = chart._chartState.chartAreaRect.top +
              chart._chartState.chartAreaRect.height -
              factor;
          canvas.clipRect(Rect.fromLTRB(
              0,
              chart._chartState.chartAreaRect.top +
                  chart._chartState.chartAreaRect.height -
                  height,
              chart._chartState.chartAreaRect.left +
                  chart._chartState.chartAreaRect.width,
              chart._chartState.chartAreaRect.top +
                  chart._chartState.chartAreaRect.height));
        }
        chart._chartSeries._getFunnelSegments(canvas, pointIndex);
      }
    }
  }

  @override
  bool shouldRepaint(_FunnelChartPainter oldDelegate) => true;
}

abstract class _FunnelChartSegment {
  Color getPointColor(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, Color color, double opacity);

  double getPointOuterRadius(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, double outerRadius);

  double getPointInnerRadius(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, double innerRadius);

  bool getPointExplode(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, bool isExplode);

  double getOpacity(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, double opacity);

  Color getPointStrokeColor(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, Color strokeColor);

  double getPointStrokeWidth(FunnelSeries<dynamic, dynamic> series,
      _PointInfo<dynamic> point, int pointIndex, double strokeWidth);
}

class _FunnelSeriesRender with _FunnelChartSegment {
  _FunnelSeriesRender();

  @override
  Color getPointColor(
          FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point,
          int pointIndex,
          Color color,
          double opacity) =>
      color?.withOpacity(opacity);

  @override
  double getPointOuterRadius(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, double outerRadius) =>
      outerRadius;

  @override
  double getPointInnerRadius(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, double innerRadius) =>
      innerRadius;

  @override
  bool getPointExplode(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, bool isExplode) =>
      isExplode;

  @override
  Color getPointStrokeColor(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, Color strokeColor) =>
      strokeColor;

  @override
  double getPointStrokeWidth(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, double strokeWidth) =>
      strokeWidth;

  @override
  double getOpacity(FunnelSeries<dynamic, dynamic> series,
          _PointInfo<dynamic> point, int pointIndex, double opacity) =>
      opacity;
}
