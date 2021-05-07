part of flutter_charts;

/// Customizes the data label.
class DataLabelSettings {
  DataLabelSettings(
      {this.alignment = ChartAlignment.center,
      this.color,
      ChartTextStyle textStyle,
      EdgeInsets margin,
      this.opacity = 1,
      this.labelAlignment = ChartDataLabelAlignment.auto,
      this.borderRadius = 5,
      this.isVisible = false,
      this.angle = 0,
      this.builder,
      bool useSeriesColor,
      this.showCumulativeValues = false,
      Color borderColor,
      double borderWidth,
      LabelIntersectAction labelIntersectAction,
      ConnectorLineSettings connectorLineSettings,
      ChartDataLabelPosition labelPosition})
      : borderColor = borderColor ?? Colors.transparent,
        useSeriesColor = useSeriesColor ?? false,
        labelPosition = labelPosition ?? ChartDataLabelPosition.inside,
        borderWidth = borderWidth ?? 0,
        margin = margin ?? const EdgeInsets.fromLTRB(5, 5, 5, 5),
        connectorLineSettings =
            connectorLineSettings ?? ConnectorLineSettings(),
        labelIntersectAction =
            labelIntersectAction ?? LabelIntersectAction.hide,
        textStyle = textStyle ?? ChartTextStyle();

  ///Alignment of the data label. The data label can be aligned far, near, or center of the data point position.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer ChartAlignment
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(isVisible: true, alignment: ChartAlignment.center),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;

  ///Color of the data label.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(isVisible: true, color: Colors.red),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color color;

  ///Customizes the data label font.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(isVisible:true,
  ///                    textStyle: ChartTextStyle(color: Colors.red)),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Margin between the data label text and its shape.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       margin: const EdgeInsets.all(2),
  ///                       borderColor: Colors.red,
  ///                       borderWidth: 2),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Opacity of the data label. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       color: Colors.pink,
  ///                       opacity: 0.5),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double opacity;

  ///Uses the series color for filling the data label shape
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       useSeriesColor: true),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool useSeriesColor;

  ///Position of the data label.
  ///
  /// Note - This is applicable for Cartesian chart.
  ///
  ///Defaults to ChartDataLabelAlignment.auto
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, num>>[
  ///                LineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                         isVisible: true,
  ///                         labelAlignment: ChartDataLabelAlignment.auto),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ChartDataLabelAlignment labelAlignment;

  /// Customizes the data label border radius.
  ///
  /// Defaults to 5
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       borderRadius: 3,
  ///                       borderColor: Colors.red,
  ///                       borderWidth: 2),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double borderRadius;

  ///Toggles the visibility of the data label in the series.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true)
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Rotation angle of the data label.
  ///
  ///Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       angle:40)
  ///              ],
  ///        ));
  ///}
  ///```
  final int angle;

  ///Border color of the data label.
  ///
  ///Defaults to Colors.transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       borderColor: Colors.red,
  ///                       borderWidth: 2),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the data label.
  ///
  ///Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       borderColor: Colors.red,
  ///                       borderWidth: 2),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Position of the data label.
  ///
  ///Note - This is applicable for pie and doughnut series types alone.
  ///
  ///Defaults to ChartDataLabelPosition.inside
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<SalesData, String>>[
  ///                PieSeries<SalesData, String>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       labelPosition: ChartDataLabelPosition.outside),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ChartDataLabelPosition labelPosition;

  ///Customizes the connector lines. Connector line is rendered when the data label is
  /// placed outside the chart.
  ///
  /// Note - This is applicable for pie and doughnut series types alone.
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<SalesData, String>>[
  ///                PieSeries<SalesData, String>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,
  ///                       connectorLineSettings:ConnectorLineSettings(
  ///                             width: 6,
  ///                             type:ConnectorType.curve)),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ConnectorLineSettings connectorLineSettings;

  ///Action on data labels intersection. The intersecting data labels can be hidden.
  ///
  ///Defaults to LabelIntersectAction.hide
  ///
  ///Also refer LabelIntersectAction
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,color: Colors.yellow
  ///                       labelIntersectAction: LabelIntersectAction.none),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final LabelIntersectAction labelIntersectAction;

  ///Builder for data label.
  ///
  /// Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  dataLabelSettings: DataLabelSettings(
  ///                       isVisible: true,color: Colors.yellow
  ///                       builder: (dynamic data, dynamic point, dynamic series,
  ///                           int pointIndex, int seriesIndex) {
  ///                         return Container(height: 30, width: 30,
  ///                          child: Image.asset('images/horse.jpg'));
  ///          }),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ChartWidgetBuilder<dynamic> builder;

  final bool showCumulativeValues;
}
