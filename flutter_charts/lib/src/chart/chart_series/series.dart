part of flutter_charts;

/// Renders the cartesian type series.
abstract class CartesianSeries<T, D> extends ChartSeries<T, D> {
  CartesianSeries(
      {this.xValueMapper,
      this.yValueMapper,
      this.dataLabelMapper,
      this.name,
      this.dataSource,
      this.xAxisName,
      this.yAxisName,
      this.sizeValueMapper,
      this.pointColorMapper,
      this.color,
      this.legendItemText,
      this.sortFieldValueMapper,
      this.gradient,
      this.width,
      this.highValueMapper,
      this.lowValueMapper,
      MarkerSettings markerSettings,
      bool isVisible,
      bool enableTooltip,
      EmptyPointSettings emptyPointSettings,
      DataLabelSettings dataLabelSettings,
      double animationDuration,
      List<double> dashArray,
      List<int> initialSelectedDataIndexes,
      Color borderColor,
      double borderWidth,
      SelectionSettings selectionSettings,
      bool isVisibleInLegend,
      LegendIconType legendIconType,
      double opacity,
      List<ChartSegment> segments,
      SortingOrder sortingOrder})
      : isVisible = isVisible ?? true,
        markerSettings = markerSettings ?? MarkerSettings(),
        dataLabelSettings = dataLabelSettings ?? DataLabelSettings(),
        enableTooltip = enableTooltip ?? true,
        emptyPointSettings = emptyPointSettings ?? EmptyPointSettings(),
        dashArray = dashArray ?? <double>[0, 0],
        initialSelectedDataIndexes = initialSelectedDataIndexes ?? <int>[],
        animationDuration = animationDuration ?? 1500,
        borderColor = borderColor ?? Colors.transparent,
        selectionSettings = selectionSettings ?? SelectionSettings(),
        legendIconType = legendIconType ?? LegendIconType.seriesType,
        isVisibleInLegend = isVisibleInLegend ?? true,
        borderWidth = borderWidth ?? 0,
        opacity = opacity ?? 1,
        sortingOrder = sortingOrder ?? SortingOrder.none,
        segments = segments ?? <ChartSegment>[],
        super(
            name: name,
            xValueMapper: xValueMapper,
            yValueMapper: yValueMapper,
            sortFieldValueMapper: sortFieldValueMapper,
            pointColorMapper: pointColorMapper,
            dataLabelMapper: dataLabelMapper,
            dataSource: dataSource,
            emptyPointSettings: emptyPointSettings,
            dataLabelSettings: dataLabelSettings,
            enableTooltip: enableTooltip,
            animationDuration: animationDuration,
            selectionSettings: selectionSettings,
            legendIconType: legendIconType,
            sortingOrder: sortingOrder,
            opacity: opacity);

  ///Data required for rendering the series. If no data source is specified, empty
  ///chart will be rendered without series.
  ///
  ///Defaults to null.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<SalesData, num>>[
  ///                ColumnSeries<SalesData, num>(
  ///                  dataSource: chartData,
  ///                  xValueMapper: (SalesData sales, _) => sales.x,
  ///                  yValueMapper: (SalesData sales, _) => sales.y,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///final List<SalesData> chartData = <SalesData>[
  ///    SalesData(1, 23),
  ///    SalesData(2, 35),
  ///    SalesData(3, 19)
  ///  ];
  ///
  ///class SalesData {
  ///   SalesData(this.x, this.y);
  ///   final double x;
  ///   final double y;
  ///}
  ///```
  final List<T> dataSource;

  ///Field in the data source, which is considered as x-value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<SalesData, num>>[
  ///                ColumnSeries<SalesData, num>(
  ///                  dataSource: chartData,
  ///                  xValueMapper: (SalesData sales, _) => sales.x,
  ///                  yValueMapper: (SalesData sales, _) => sales.y,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///final List<SalesData> chartData = <SalesData>[
  ///    SalesData(1, 23),
  ///    SalesData(2, 35),
  ///    SalesData(3, 19)
  ///  ];
  ///
  ///class SalesData {
  ///   SalesData(this.x, this.y);
  ///   final double x;
  ///   final double y;
  ///}
  ///```
  final ChartIndexedValueMapper<D> xValueMapper;

  ///Field in the data source, which is considered as y-value.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<SalesData, num>>[
  ///                ColumnSeries<SalesData, num>(
  ///                  dataSource: chartData,
  ///                  xValueMapper: (SalesData sales, _) => sales.x,
  ///                  yValueMapper: (SalesData sales, _) => sales.y,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///final List<SalesData> chartData = <SalesData>[
  ///    SalesData(1, 23),
  ///    SalesData(2, 35),
  ///    SalesData(3, 19)
  ///  ];
  ///
  ///class SalesData {
  ///   SalesData(this.x, this.y);
  ///   final double x;
  ///   final double y;
  ///}
  ///```
  final ChartIndexedValueMapper<num> yValueMapper;

  ///Field in the data source, which is considered as fill color for the data points.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<ColumnColors, num>>[
  ///                   ColumnSeries<ColumnColors, num>(
  ///                       dataSource: chartData,
  ///                       xValueMapper: (ColumnColors sales, _) => sales.x,
  ///                       yValueMapper: (ColumnColors sales, _) => sales.y,
  ///                       pointColorMapper: (ColumnColors sales, _) => sales.pointColorMapper,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///final dynamic chartData = <ColumnColors>[
  ///    ColumnColors(1991, 7.8, const Color.fromRGBO(0, 0, 255, 1)),
  ///    ColumnColors(1992, 6.5, const Color.fromRGBO(255, 0, 0, 1)),
  ///    ColumnColors(1993, 6.0, const Color.fromRGBO(255, 100, 102, 1)),
  /// ];
  ///class ColumnColors {
  ///  ColumnColors(this.x, this.y,this.pointColorMapper);
  ///  final num x;
  ///  final num y;
  ///  final Color pointColorMapper;
  ///}
  ///```
  final ChartIndexedValueMapper<Color> pointColorMapper;

  ///Field in the data source, which is considered as text for the data points.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                 dataSource: <SalesData>[
  ///                    SalesData(DateTime(2005, 0, 1), 'India', 16),
  ///                    SalesData(DateTime(2006, 0, 1), 'China', 12),
  ///                    SalesData(DateTime(2007, 0, 1), 'USA',18),
  ///                 ],
  ///                dataLabelSettings: DataLabelSettings(isVisible:true),
  ///                dataLabelMapper: (SalesData data, _) => data.category,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class SalesData {
  ///   SalesData(this.year, this.category, this.sales1);
  ///   final DateTime year;
  ///   final String category;
  ///   final int sales1;
  ///}
  ///```
  final ChartIndexedValueMapper<String> dataLabelMapper;

  ///Field in the data source, which is considered as size of the bubble for
  ///all the data points.
  ///
  ///Note – This is applicable only for bubble series.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       dataSource: chartData,
  ///                       sizeValueMapper: (BubbleColors sales, _) => sales.bubbleSize,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///final dynamic chartData = <BubbleColors>[
  ///    BubbleColors(92.2, 7.8, 1.347, const Color.fromRGBO(0, 0, 255, 1)),
  ///    BubbleColors(74, 6.5, 1.241, const Color.fromRGBO(255, 0, 0, 1)),
  ///    BubbleColors(90.4, 6.0, 0.238, const Color.fromRGBO(255, 100, 102, 1)),
  ///    BubbleColors(99.4, 2.2, 0.197, const Color.fromRGBO(122, 100, 255, 1)),
  /// ];
  ///class BubbleColors {
  ///  BubbleColors(this.year, this.growth,[this.bubbleSize, this.sizeValueMapper]);
  ///  final num year;
  ///  final num growth;
  ///  final num bubbleSize;
  ///  final Color pointColorMapper;
  ///}
  ///```
  final ChartIndexedValueMapper<num> sizeValueMapper;

  ///Field in the data source, which is considered as high value for the data points.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                 dataSource: <SalesData>[
  ///                    SalesData(2005, 24, 16),
  ///                    SalesData(2006, 22, 12),
  ///                    SalesData(2007, 31, 18),
  ///                 ],
  ///                highValueMapper: (SalesData data, _) => data.high,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class SalesData {
  ///   SalesData(this.year, this.high, this.low);
  ///   final num year;
  ///   final num high;
  ///   final num low;
  ///}
  ///```
  final ChartIndexedValueMapper<num> highValueMapper;

  ///Field in the data source, which is considered as low value for the data points.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <RangeColumnSeries<SalesData, num>>[
  ///                RangeColumnSeries<SalesData, num>(
  ///                 dataSource: <SalesData>[
  ///                    SalesData(2005, 24, 16),
  ///                    SalesData(2006, 22, 12),
  ///                    SalesData(2007, 31, 18),
  ///                 ],
  ///                lowValueMapper: (SalesData data, _) => data.low,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///class SalesData {
  ///   SalesData(this.year, this.high, this.low);
  ///   final num year;
  ///   final num high;
  ///   final num low;
  ///}
  ///```
  final ChartIndexedValueMapper<num> lowValueMapper;

  ///Name of the x-axis to bind the series.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///             axes: <ChartAxis>[
  ///                        NumericAxis(
  ///                            plotOffset: 0,
  ///                            majorGridLines: MajorGridLines(color: Colors.transparent),
  ///                            opposedPosition: true,
  ///                            name: 'xAxis1',
  ///                            axisTitle: AxisTitle(
  ///                                text: 'China - Growth'))
  ///                      ],
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       dataSource: chartData,
  ///                       xAxisName: 'xAxis1',
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///final dynamic chartData = <BubbleColors>[
  ///    BubbleColors(92.2, 7.8, 1.347, const Color.fromRGBO(0, 0, 255, 1)),
  ///    BubbleColors(74, 6.5, 1.241, const Color.fromRGBO(255, 0, 0, 1)),
  ///    BubbleColors(90.4, 6.0, 0.238, const Color.fromRGBO(255, 100, 102, 1)),
  ///    BubbleColors(99.4, 2.2, 0.197, const Color.fromRGBO(122, 100, 255, 1)),
  /// ];
  ///```
  final String xAxisName;

  ///Name of the y-axis to bind the series.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///             axes: <ChartAxis>[
  ///                        NumericAxis(
  ///                            plotOffset: 0,
  ///                            majorGridLines: MajorGridLines(color: Colors.transparent),
  ///                            opposedPosition: true,
  ///                            name: 'yAxis1',
  ///                            axisTitle: AxisTitle(
  ///                                text: 'China - Population '))
  ///                      ],
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       dataSource: chartData,
  ///                       yAxisName: 'yAxis1',
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///final dynamic chartData = <BubbleColors>[
  ///    BubbleColors(92.2, 7.8, 1.347, const Color.fromRGBO(0, 0, 255, 1)),
  ///    BubbleColors(74, 6.5, 1.241, const Color.fromRGBO(255, 0, 0, 1)),
  ///    BubbleColors(90.4, 6.0, 0.238, const Color.fromRGBO(255, 100, 102, 1)),
  ///    BubbleColors(99.4, 2.2, 0.197, const Color.fromRGBO(122, 100, 255, 1)),
  /// ];
  ///```
  final String yAxisName;

  ///Color of the series. If no color is specified, then the series will be rendered
  ///with the default palette color.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       color: const Color.fromRGBO(255, 0, 102, 1),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Color color;

  ///Width of the series. In line, spline, step line, and fast line series, width
  ///of the line will be changed. In column series, width of the column rectangle will
  ///be changed. In bar series, the height of the bar rectangle will be changed.
  ///
  ///Note – This is not applicable for area, scatter, and bubble series.
  ///
  ///Default to 2
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<LineData, num>>[
  ///                   LineSeries<LineData, num>(
  ///                       width: 2,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final double width;

  ///Indication of data points. Mark the data point location with symbols for better
  ///indication. The shape, color, border, and size of the marker can be customized.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<ChartData, num>>[
  ///                   LineSeries<ChartData, num>(
  ///                       markerSettings: MarkerSettings(isVisible: true),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final MarkerSettings markerSettings;

  ///Customizes the empty points, i.e. null data points in a series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<ChartData, num>>[
  ///                   ColumnSeries<ChartData, num>(
  ///                       emptyPointSettings: EmptyPointSettings(color: Colors.black),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  ///
  final EmptyPointSettings emptyPointSettings;

  ///Customizes the data labels in a series. Data label is a text, which displays
  ///the details about the data point.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<ChartData, num>>[
  ///                   LineSeries<ChartData, num>(
  ///                       dataLabelSettings: DataLabelSettings(isVisible: true),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final DataLabelSettings dataLabelSettings;

  ///Fills the chart series with gradient color.
  ///
  ///Default to null
  ///
  ///```dart
  ///final List <Color> color = <Color>[];
  ///    color.add(Colors.pink[50]);
  ///    color.add(Colors.pink[200]);
  ///    color.add(Colors.pink);
  ///
  ///final List<double> stops = <double>[];
  ///    stops.add(0.0);
  ///    stops.add(0.5);
  ///    stops.add(1.0);
  ///
  ///final LinearGradient gradients = LinearGradient(colors: color, stops: stops);
  ///
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, String>>[
  ///                   BarSeries<SalesData, String>(
  ///                       gradient: gradients,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final LinearGradient gradient;

  ///Name of the series. The name will be displayed in legend item by default.
  ///If name is not specified for the series, then the current series index with ‘series’
  ///text prefix will be considered as series name.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       name: 'Bubble Series',
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final String name;

  ///Enables or disables the tooltip for this series. Tooltip will display more details
  ///about data points when tapping the data point region.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       enableTooltip: true,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final bool enableTooltip;

  ///Dashes of the series. Any number of values can be provided in the list. Odd value
  ///is considered as rendering size and even value is considered as gap.
  ///
  ///Note - This is applicable for line, spline, step line, and fast line series only.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       dashArray: <double>[10, 10],
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final List<double> dashArray;

  ///Duration of the series animation. It takes millisecond value as input.
  ///
  ///Defaults to 1500
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       animationDuration: 1000,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final double animationDuration;

  ///Border color of the series.
  ///
  ///Note – This is not applicable for line, spline, step line, and fast line series types
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       borderColor: Colors.red,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the series.
  ///
  ///Note – This is not applicable for line, spline, step line, and fast line series types.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       borderWidth: 5,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Shape of the legend icon. Any shape in the LegendIconType can be applied
  ///to this property. By default, icon will be rendered based on the type of the series.
  ///
  ///Defaults to LegendIconType.seriesType
  ///
  ///Also refer [LegendIconType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       legendIconType: LegendIconType.diamond,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final LegendIconType legendIconType;

  ///Toggles the visibility of the legend item of this specific series in the legend.
  ///If it is set to false, the legend item for this series will not be visible
  ///in the legend.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       isVisibleInLegend: true,
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final bool isVisibleInLegend;

  ///Text to be displayed in legend. By default, the series name will be displayed
  ///in the legend. You can change this by setting values to this property.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <LineSeries<SalesData, String>>[
  ///                   LineSeries<SalesData, String>(
  ///                       legendItemText: 'legend',
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final String legendItemText;

  /// Gets the Segments collection variable declarations.
  final List<ChartSegment> segments;

  ///Customizes the data points or series on selection.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey,
  ///                    selectedOpacity : 0.8,
  ///                    unselectedOpacity: 0.4
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final SelectionSettings selectionSettings;

  ///Opacity of the series. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                      opacity: 1
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double opacity;

  /// Stores the series type
  String _seriesType;

  ///Field in the data source, which is considered for sorting the data points.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <ColumnSeries<SalesData, num>>[
  ///                ColumnSeries<SalesData, num>(
  ///                  dataSource: chartData,
  ///                  xValueMapper: (SalesData sales, _) => sales.x,
  ///                  yValueMapper: (SalesData sales, _) => sales.y,
  ///                  sortFieldValueMapper: (SalesData sales, _) => sales.x,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///final List<SalesData> chartData = <SalesData>[
  ///    SalesData(1, 23),
  ///    SalesData(2, 35),
  ///    SalesData(3, 19)
  ///  ];
  ///
  ///class SalesData {
  ///   SalesData(this.x, this.y);
  ///   final double x;
  ///   final double y;
  ///}
  ///```
  final ChartIndexedValueMapper<dynamic> sortFieldValueMapper;

  ///The data points in the series can be sorted in ascending or descending order.
  ///The data points will be rendered in the specified order if it is set to none.
  ///
  ///Default to none
  ///
  ///Also refer [SortingOrder]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                    sortingOrder: SortingOrder.ascending,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final SortingOrder sortingOrder;

  ///Toggles the visibility of the series.
  ///
  ///Defaults to true.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BarSeries<SalesData, num>>[
  ///                BarSeries<SalesData, num>(
  ///                    isVisible:false,
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isVisible;

  List<_StackedValues> _stackingValues;

  /// Holds the collection of cartesian data points
  List<_CartesianChartPoint<dynamic>> _dataPoints;

  /// Name of the series
  String _seriesName;

  /// Holds the information for x Axis
  ChartAxis _xAxis;

  /// Holds the information for y Axis
  ChartAxis _yAxis;

  /// Minimum x value for Series
  num _minimumX;

  /// Maximum x value for Series
  num _maximumX;

  /// Minimum y value for Series
  num _minimumY;

  /// Maximum y value for Series
  num _maximumY;

  /// Hold the data about point regions
  Map<dynamic, dynamic> _regionalData;

  /// Color for the series based on color palette
  Color _seriesColor;

  /// Hold the information about chart class
  SfCartesianChart _chart;

  /// Side by side index for series
  int _sideBySideIndex;

  /// Contains the collection of path for markers
  List<Path> _markerShapes;

  List<Path> _markerShapes2;

  bool _visible;

  List<int> initialSelectedDataIndexes;

  // ignore: prefer_final_fields
  bool _isOuterRegion = false;

  /// calculate the series region
  void _renderSeries(SfCartesianChart chart, int index) =>
      _calculateSeriesRegion(chart, index);

  /// Create segments for series
  void _internalCreateSegments() {
    if (segments.isNotEmpty) {
      segments?.clear();
    }
    createSegments();
  }

  /// Draw series
  void _draw(Canvas canvas, [double animationFactor]) {
    for (ChartSegment chartSegment in segments) {
      chartSegment.animationFactor = animationFactor;
      chartSegment.onPaint(canvas);
    }
  }

  /// Creates collection of segments for series
  void createSegments();

  /// To create segment for series
  ChartSegment createSegment();

  /// To customize each segments
  void customizeSegment(ChartSegment segment);

  /// To customize each data markers
  void drawDataMarker(int index, Canvas canvas, Paint fillPaint,
      Paint strokePaint, double pointX, double pointY);

  /// To customize each data labels
  void drawDataLabel(int index, Canvas canvas, String dataLabel, double pointX,
      double pointY, int angle, ChartTextStyle style);
}
