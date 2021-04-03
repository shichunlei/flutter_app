part of flutter_charts;

/// Customizes the annotation of cartesian chart.
class CartesianChartAnnotation {
  CartesianChartAnnotation(
      {this.widget,
      CoordinateUnit coordinateUnit,
      AnnotationRegion region,
      ChartAlignment horizontalAlignment,
      ChartAlignment verticalAlignment,
      dynamic x,
      dynamic y,
      this.xAxisName,
      this.yAxisName})
      : coordinateUnit = coordinateUnit ?? CoordinateUnit.logicalPixel,
        region = region ?? AnnotationRegion.chart,
        x = x ?? 0,
        y = y ?? 0,
        horizontalAlignment = horizontalAlignment ?? ChartAlignment.center,
        verticalAlignment = verticalAlignment ?? ChartAlignment.center;

  ///Considers any widget as annotation.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    widget: Container(
  ///                    child: const Text('Empty Data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///                 ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Widget widget;

  ///Specifies the coordinate units for placing the annotation in either logicalPixel or point.
  ///
  ///Defaults to CoordinateUnit.logicalPixel
  ///
  ///Also refer [CoordinateUnit]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final CoordinateUnit coordinateUnit;

  ///Annotations can be placed with respect to either plotArea or chart.
  ///
  ///Defaults to AnnotationRegion.chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final AnnotationRegion region;

  ///Specifies the x-values as pixel or point values based on the coordinateUnit.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final dynamic x;

  ///Specifies the y-values as pixel or point values based on the coordinateUnit.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final num y;

  ///Specifies the x-axis name to the annotation that should be bound.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///              series: <ChartSeries<SalesData, num>>[
  ///                LineSeries<SalesData, num>(
  ///                    xAxisName: 'Gold'
  ///                ),
  ///              ],
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60,
  ///                    xAxisName: 'Gold'
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final dynamic xAxisName;

  ///Specifies the y-axis name to the annotation that should  be bound.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///             series: <ChartSeries<SalesData, num>>[
  ///                LineSeries<SalesData, num>(
  ///                    yAxisName: 'Gold'
  ///                ),
  ///              ],
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60,
  ///                    yAxisName: 'Diamond'
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final dynamic yAxisName;

  ///Aligns the annotations horizontally. Alignment can be set to near, far, or center.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer [ChartAlignment]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60,
  ///                    HorizontalAlignment: HorizontalAlignment.near,
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final ChartAlignment horizontalAlignment;

  ///Aligns the annotations vertically. Alignment can be set to near, far, or center.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer [ChartAlignment]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            annotations: <CartesianChartAnnotation>[
  ///                CartesianChartAnnotation(
  ///                    child: Container(
  ///                    child: const Text('Empty data')),
  ///                    coordinateUnit: CoordinateUnit.point,
  ///                    region: AnnotationRegion.chartArea,
  ///                    x: 3.5,
  ///                    y: 60,
  ///                    verticalAllignment: VerticalAlignment.bottom,
  ///               ),
  ///             ],
  ///        ));
  ///}
  ///```
  final ChartAlignment verticalAlignment;
}
