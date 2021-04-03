part of flutter_charts;

/// Customizes the crosshair.
class CrosshairBehavior extends ChartBehavior {
  CrosshairBehavior({
    ActivationMode activationMode,
    CrosshairLineType lineType,
    this.lineDashArray,
    this.enable = false,
    this.lineColor,
    this.lineWidth = 1,
    this.shouldAlwaysShow = false,
  })  : activationMode = activationMode ?? ActivationMode.longPress,
        lineType = lineType ?? CrosshairLineType.both {
    _isLongPressActivated = false;
  }

  /// Toggles the visibility of the crosshair.
  ///
  ///Defaults to false
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final bool enable;

  /// Width of the crosshair line.
  ///
  /// Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineWidth: 5),
  ///        ));
  ///}
  ///```
  final double lineWidth;

  ///Color of the crosshair line. Color will be applied based on the brightness
  ///property of the app.
  ///
  ///Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineColor: Colors.red),
  ///        ));
  ///}
  ///```
  final Color lineColor;

  /// Dashes of the crosshair line. Any number of values can be provided in the list.
  /// Odd value is considered as rendering size and even value is considered as gap.
  ///
  /// Dafaults to [0,0]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                   enable: true, lineDashArray: [10,10]),
  ///        ));
  ///}
  ///```
  final List<double> lineDashArray;

  /// Gesture for activating the crosshair. Crosshair can be activated in tap, double tap
  /// and long press.
  ///
  /// Defaults to ActivationMode.longPress
  ///
  /// Also refer ActivationMode
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///               enable: true, activationMode: ActivationMode.doubleTap),
  ///        ));
  ///}
  ///```
  final ActivationMode activationMode;

  /// Type of crosshair line. By default, both vertical and horizontal lines will be
  /// displayed. You can change this by specifying values to this property.
  ///
  /// Defaults to CrosshairLineType.both
  ///
  /// Also refer CrosshairLineType
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(
  ///                 enable: true, lineType: CrosshairLineType.horizontal),
  ///        ));
  ///}
  ///```
  final CrosshairLineType lineType;

  /// Enables or disables the crosshair. By default, the crosshair will be hidden on touch.
  /// To avoid this, set this property to true.
  ///
  /// Defaults to false
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           crosshairBehavior: CrosshairBehavior(enable: true, shouldAlwaysShow: true),
  ///        ));
  ///}
  ///```
  final bool shouldAlwaysShow;

  /// Touch position
  Offset _position;

  /// Holds the instance of CrosshairPainter
  _CrosshairPainter _crosshairPainter;

  /// Check whether long press activated or not .
  bool _isLongPressActivated;

  /// Displays the crosshair at the specified x and y-positions.
  void show(double x, double y) {
    if (_crosshairPainter != null &&
        activationMode != ActivationMode.none &&
        x != null &&
        y != null) {
      _crosshairPainter._generateAllPoints(Offset(x, y));
      _crosshairPainter.canResetPath = false;
      _crosshairPainter.chart._chartState.crosshairRepaintNotifier.value++;
    }
  }

  /// Hides the crosshair if it is displayed.
  void hide() {
    if (_crosshairPainter != null) {
      _crosshairPainter.canResetPath = true;
      _crosshairPainter.chart._chartState.crosshairRepaintNotifier.value++;
    }
  }

  /// Enables the crosshair on double tap.
  @override
  void onDoubleTap(double xPos, double yPos) => show(xPos, yPos);

  /// Enables the crosshair on long press.
  @override
  void onLongPress(double xPos, double yPos) => show(xPos, yPos);

  /// Enables the crosshair on touch down.
  @override
  void onTouchDown(double xPos, double yPos) => show(xPos, yPos);

  /// Enables the crosshair on touch move.
  @override
  void onTouchMove(double xPos, double yPos) => show(xPos, yPos);

  /// Enables the crosshair on touch up.
  @override
  void onTouchUp(double xPos, double yPos) => hide();

  /// Draws the crosshair.
  @override
  void onPaint(Canvas canvas) {
    if (_crosshairPainter != null) {
      _crosshairPainter._drawCrosshair(canvas);
    }
  }

  void _drawLine(Canvas canvas, Paint paint, int seriesIndex) {
    if (_crosshairPainter != null) {
      _crosshairPainter._drawCrosshairLine(canvas, paint, seriesIndex);
    }
  }

  Paint _linePainter(Paint paint) => _crosshairPainter?._getLinePainter(paint);
}

class _ChartPointInfo {
  /// Marker x position
  double markerXPos;

  /// Marker y position
  double markerYPos;

  /// label for trackball and cross hair
  String label;

  /// Data point index
  int dataPointIndex;

  /// Instance of chart series
  XyDataSeries<dynamic, dynamic> series;

  /// Chart data point
  _CartesianChartPoint<dynamic> chartDataPoint;

  /// X position of the label
  double xPosition;

  /// Y position of the label
  double yPosition;

  /// Color of the segment
  Color color;
}
