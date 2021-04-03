part of flutter_charts;

/// Customizes the trackball.
class TrackballBehavior extends ChartBehavior {
  TrackballBehavior({
    ActivationMode activationMode,
    TrackballLineType lineType,
    TrackballDisplayMode tooltipDisplayMode,
    ChartAlignment tooltipAlignment,
    InteractiveTooltip tooltipSettings,
    this.lineDashArray,
    this.enable = false,
    this.lineColor,
    this.lineWidth = 1,
    this.shouldAlwaysShow = false,
  })  : activationMode = activationMode ?? ActivationMode.longPress,
        tooltipAlignment = tooltipAlignment ?? ChartAlignment.center,
        tooltipDisplayMode =
            tooltipDisplayMode ?? TrackballDisplayMode.floatAllPoints,
        tooltipSettings = tooltipSettings ?? InteractiveTooltip(),
        lineType = lineType ?? TrackballLineType.vertical {
    _isLongPressActivated = false;
  }

  ///Toggles the visibility of the trackball.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final bool enable;

  ///Width of the track line.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true, lineWidth: 5),
  ///        ));
  ///}
  ///```
  final double lineWidth;

  ///Color of the track line.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true, lineColor: Colors.red),
  ///        ));
  ///}
  ///```
  final Color lineColor;

  ///Dashes of the track line.
  ///
  ///Defaults to [0,0]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true, lineDashArray: [10,10]),
  ///        ));
  ///}
  ///```
  final List<double> lineDashArray;

  ///Gesture for activating the trackball. Trackball can be activated in tap, double tap,
  ///and long press.
  ///
  ///Defaults to ActivationMode.longPress
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///           enable: true,
  ///           activationMode: ActivationMode.doubleTap
  ///          ),
  ///        ));
  ///}
  ///```
  final ActivationMode activationMode;

  ///Alignment of the trackball tooltip. The trackball tooltip can be aligned at the top,
  ///bottom, and center position of the chart.
  ///
  ///Note – This is applicable only when the tooltipDisplay mode is set to groupAllPoints.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///           enable: true,
  ///           tooltipAlignment: ChartAlignment.far,
  ///           tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
  ///          ),
  ///        ));
  ///}
  ///```
  final ChartAlignment tooltipAlignment;

  ///Type of trackball line. By default, vertical line will be displayed. You can change
  ///this by specifying values to this property.
  ///
  ///Defaults to TrackballLineType.vertical
  ///
  ///Also refer [TrackballLineType]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///           enable: true,
  ///           lineType: TrackballLineType.horizontal
  ///        ),
  ///        ));
  ///}
  ///```
  final TrackballLineType lineType;

  ///Display mode of tooltip. By default, tooltip of all the series under the current point
  ///index value will be shown.
  ///
  ///Defaults to TrackballDisplayMode.floatAllPoints
  ///
  ///Also refer [TrackballDisplayMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///            enable: true,
  ///            tooltipDisplayMode: TrackballDisplayMode.floatAllPoints
  ///         ),
  ///        ));
  ///}
  ///```
  final TrackballDisplayMode tooltipDisplayMode;

  ///Shows or hides the trackball. By default, the trackball will be hidden on touch.
  /// To avoid this, set this property to true.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(enable: true, shouldAlwaysShow: true),
  ///        ));
  ///}
  ///```
  final bool shouldAlwaysShow;

  ///Customizes the trackball tooltip.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           trackballBehavior: TrackballBehavior(
  ///           tooltipSettings: InteractiveTooltip(
  ///            enable: true
  ///        ),
  ///        ),
  ///        ));
  ///}
  ///```
  InteractiveTooltip tooltipSettings;

  /// Touch position
  Offset position;

  /// Holds the instance of trackballPainter
  _TrackballPainter painter;

  /// Check whether long press activated or not .
  bool _isLongPressActivated;

  /// Displays the trackball at the specified x and y-positions.
  void show(double x, double y) {
    if (painter != null &&
        activationMode != ActivationMode.none &&
        x != null &&
        y != null) {
      painter._generateAllPoints(Offset(x, y));
      painter.canResetPath = false;
      painter.chart._chartState.trackballRepaintNotifier.value++;
    }
  }

  /// Hides the trackball if it is displayed.
  void hide() {
    if (painter != null && activationMode != ActivationMode.none) {
      painter.canResetPath = true;
      painter.chart._chartState.trackballRepaintNotifier.value++;
    }
  }

  /// Performs the double-tap action.
  @override
  void onDoubleTap(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the long press action.
  @override
  void onLongPress(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the touch-down action.
  @override
  void onTouchDown(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the touch-move action.
  @override
  void onTouchMove(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the touch-up action.
  @override
  void onTouchUp(double xPos, double yPos) => hide();

  /// Draws trackball
  @override
  void onPaint(Canvas canvas) {
    if (painter != null && !painter.canResetPath) {
      painter._drawTrackball(canvas);
    }
  }

  void _drawLine(Canvas canvas, Paint paint, int seriesIndex) {
    if (painter != null) {
      painter._drawTrackBallLine(canvas, paint, seriesIndex);
    }
  }

  Paint _linePainter(Paint paint) => painter?._getLinePainter(paint);
}
