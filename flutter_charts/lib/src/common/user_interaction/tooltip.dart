part of flutter_charts;

/// Customizes the tooltip.
class TooltipBehavior extends ChartBehavior {
  TooltipBehavior(
      {ChartTextStyle textStyle,
      ActivationMode activationMode,
      int animationDuration,
      bool enable,
      double opacity,
      Color borderColor,
      double borderWidth,
      double duration,
      bool shouldAlwaysShow,
      double elevation,
      bool canShowMarker,
      ChartAlignment textAlignment,
      int decimalPlaces,
      this.color,
      this.header,
      this.format,
      this.builder,
      this.shadowColor})
      : animationDuration = animationDuration ?? 350,
        textAlignment = textAlignment ?? ChartAlignment.center,
        textStyle = textStyle ?? ChartTextStyle(fontSize: 12),
        activationMode = activationMode ?? ActivationMode.singleTap,
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0,
        duration = duration ?? 3000,
        enable = enable ?? false,
        opacity = opacity ?? 1,
        shouldAlwaysShow = shouldAlwaysShow ?? false,
        canShowMarker = canShowMarker ?? true,
        elevation = elevation ?? 5.0,
        decimalPlaces = decimalPlaces ?? 3;

  ///Toggles the visibility of the tooltip.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true),
  ///        ));
  ///}
  ///```
  final bool enable;

  ///Color of the tooltip.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, color: Colors.yellow),
  ///        ));
  ///}
  ///```
  final Color color;

  /// Header of the tooltip. By default, the series name will be displayed in the header.
  ///
  ///Defaults to ‘’
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, header: 'Default'),
  ///        ));
  ///}
  ///```
  final String header;

  ///Opacity of the tooltip. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, opacity: 0.7),
  ///        ));
  ///}
  ///```
  final double opacity;

  ///Customizes the tooltip text
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(
  ///           enable: true,
  ///            textStyle: ChartTextStyle(color: Colors.green)),
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Specifies the number decimals to be displayed in tooltip text
  ///
  ///Defaults to 3
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(
  ///           enable: true, decimalPlaces:5),
  ///        ));
  ///}
  ///```
  final int decimalPlaces;

  _TooltipPainter _painter;

  ///Formats the tooltip text. By default, the tooltip will be rendered with x and y-values.
  ///You can add prefix or suffix to x, y, and series name values in the
  ///tooltip by formatting them.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, format: '{value}%'),
  ///        ));
  ///}
  ///```
  final String format;

  ///Duration for animating the tooltip.
  ///
  ///Defaults to 350
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, animationDuration: 1000),
  ///        ));
  ///}
  ///```
  final int animationDuration;

  ///Toggles the visibility of the marker in the tooltip.
  ///
  ///Defaults to true
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: true),
  ///        ));
  ///}
  ///```
  final bool canShowMarker;

  ///Gesture for activating the tooltip. Tooltip can be activated in tap,
  ///double tap, and long press.
  ///Defaults to ActivationMode.tap
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(
  ///           enable: true,
  ///           activationMode: ActivationMode.doubleTap),
  ///        ));
  ///}
  ///```
  final ActivationMode activationMode;

  ///Border color of the tooltip.
  ///
  ///Defaults to Colors.transparent
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, borderColor: Colors.red),
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the tooltip.
  ///
  ///Defaults to 0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(
  ///           enable: true,
  ///           borderWidth: 2,
  ///           borderColor: Colors.red
  ///         ),
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Builder of the tooltip.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(
  ///           enable: true,
  ///           builder: (dynamic data, dynamic point,
  ///           dynamic series, int pointIndex, int seriesIndex) {
  ///           return Container(
  ///              height: 50,
  ///              width: 100,
  ///              decoration: const BoxDecoration(
  ///              color: Color.fromRGBO(66, 244, 164, 1)),
  ///              child: Row(
  ///              children: <Widget>[
  ///              Container(
  ///              width: 50,
  ///              child: Image.asset('images/bike.png')),],
  ///         ));
  ///         }),
  ///        ));
  ///}
  ///```
  final ChartWidgetBuilder<dynamic> builder;

  _TooltipTemplate _tooltipTemplate;

  ///Color of the tooltip shadow.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, shadowColor: Colors.green),
  ///        ));
  ///}
  ///```
  final Color shadowColor;

  ///Elevation of the tooltip.
  ///
  ///Defaults to 5.0
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, elevation: 10),
  ///        ));
  ///}
  ///```
  final double elevation;

  ///Shows or hides the tooltip. By default, the tooltip will be hidden on touch.
  ///To avoid this, set this property to true.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, shouldAlwaysShow: true),
  ///        ));
  ///}
  ///```
  final bool shouldAlwaysShow;

  ///Duration for displaying the tooltip.
  ///
  ///Defaults to 3000
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true, duration: 1000),
  ///        ));
  ///}
  ///```
  final double duration;

  ///Alignment of the text in the tooltip
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///           tooltipBehavior: TooltipBehavior(enable: true,textAlignment : ChartAlignment.near),
  ///        ));
  ///}
  ///```
  final ChartAlignment textAlignment;

  /// Displays the tooltip at the specified x and y-positions.
  void show(double x, double y) {
    if (_painter != null &&
        activationMode != ActivationMode.none &&
        x != null &&
        y != null) {
      _painter.show(x, y);
    }
  }

  /// Hides the tooltip if it is displayed.
  void hide() => _painter._getLocation(Offset(null, null));

  /// Draws tooltip
  @override
  void onPaint(Canvas canvas) {
    if (_painter != null) {
      _painter._renderTooltip(canvas);
    }
  }

  /// Performs the double-tap action of appropriate point.
  @override
  void onDoubleTap(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the double-tap action of appropriate point.
  @override
  void onLongPress(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the touch-down action of appropriate point.
  @override
  void onTouchDown(double xPos, double yPos) => show(xPos, yPos);

  /// Performs the touch move action of chart.
  @override
  void onTouchMove(double xPos, double yPos) {
    // Not valid for tooltip
  }

  /// Performs the touch move action of chart.
  @override
  void onTouchUp(double xPos, double yPos) => show(xPos, yPos);
}
