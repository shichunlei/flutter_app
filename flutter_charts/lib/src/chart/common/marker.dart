part of flutter_charts;

/// Customizes the markers.
class MarkerSettings {
  MarkerSettings(
      {this.isVisible = false,
      this.height = 8,
      this.width = 8,
      this.color = Colors.white,
      this.shape = DataMarkerType.circle,
      this.borderWidth = 2,
      this.borderColor,
      this.image});

  ///Toggles the visibility of the marker.
  ///
  ///Defaults to false
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(isVisible: true),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Height of the marker shape.
  ///
  ///Defaults to 4
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, height: 10),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double height;

  ///Width of the marker shape.
  ///
  ///Defaults to 4
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, width: 10),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double width;

  ///Color of the marker shape.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, color: Colors.red),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color color;

  ///Shape of the marker.
  ///
  ///Defaults to DataMarkerType.circle.
  ///
  ///Also refer [DataMarkerType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, shape: DataMarkerType.diamond),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final DataMarkerType shape;

  ///Border color of the marker.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                          isVisible: true,
  ///                          borderColor: Colors.red, borderWidth: 3),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the marker.
  ///
  ///Defaults to 2
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true,
  ///                         borderWidth: 2, borderColor: Colors.pink),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Image to be used as marker.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            selectionGesture: ActivationMode.doubleTap,
  ///            series: <SplineSeries<SalesData, num>>[
  ///                SplineSeries<SalesData, num>(
  ///                  markerSettings: MarkerSettings(
  ///                         isVisible: true, image: const AssetImage('images/bike.png'),
  ///                         shape: DataMarkerType.image),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ImageProvider image;

  String _imageUrl;

  dart_ui.Image _image;
}
