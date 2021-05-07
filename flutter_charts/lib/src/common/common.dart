part of flutter_charts;

class _ChartContainer extends SingleChildRenderObjectWidget {
  const _ChartContainer({Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ChartContainerBox();
  }
}

class _ChartContainerBox extends RenderShiftedBox {
  _ChartContainerBox() : super(null);
  double minHeight = 300;
  double minWidth = 300;

  @override
  void performLayout() {
    double height = constraints.maxHeight;
    double width = constraints.maxWidth;
    if (height == double.infinity) {
      height = minHeight;
    }
    if (width == double.infinity) {
      width = minWidth;
    }
    child.layout(
        BoxConstraints(
          minHeight: 0.0,
          maxHeight: height,
          minWidth: 0.0,
          maxWidth: width,
        ),
        parentUsesSize: true);
    size = Size(width,
        height); // constraints.maxHeight become infinity when widget is placed inside row/column
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
  }
}

/// Customizes the chart title.
class ChartTitle {
  ChartTitle(
      {this.text = '',
      ChartTextStyle textStyle,
      this.alignment = ChartAlignment.center,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0,
      this.backgroundColor})
      : textStyle = _getTextStyle(
            textStyle: textStyle,
            fontSize: 15.0,
            fontFamily: 'Segoe UI',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal);

  ///Text to be displayed as chart title. Any desired text can be set as chart title.
  ///If the width of the chart title exceeds the width of the chart, then the title will
  ///be wrapped to multiple rows.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title'
  ///                   )
  ///        ));
  ///}
  ///```
  final String text;

  ///Customizes the appearance of the chart title text.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title',
  ///                    textStyle: ChartTextStyle(
  ///                                 color: Colors.red,
  ///                                 fontSize: 12,
  ///                                 fontStyle: FontStyle.normal,
  ///                                 fontWeight: FontWeight.w400,
  ///                                 fontFamily: 'Roboto'
  ///                               ))
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Aligns the chart title. The alignment change is applicable only when the width of the
  ///chart title is less than the width of the chart.
  ///
  ///ChartAlignment.near places the chart title at the beginning of the chart, whereas
  ///ChartAlignment.far moves the chart title to end of the chart, and ChartAlignment.center
  ///places the title at the center position of the chart’s width.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer [ChartAlignment]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title',
  ///                    alignment: ChartAlignment.near
  ///                   )
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;

  ///Background color of the chart title.
  ///
  ///Defaults to Colors.transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title',
  ///                    backgroundColor: Colors.white,
  ///                   )
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  ///Border color of the chart title.
  ///
  ///Defaults to Colors.transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title',
  ///                    borderColor: Colors.red,
  ///                   )
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the chart title.
  ///
  ///Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            title: ChartTitle(
  ///                    text: 'Chart Title',
  ///                    borderWidth: 1
  ///                   )
  ///        ));
  ///}
  ///```
  final double borderWidth;
}

/// Customizes the text in chart.
class ChartTextStyle {
  ChartTextStyle(
      {this.color,
      this.fontFamily = 'Roboto',
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 12});
  Color color;
  String fontFamily;
  FontStyle fontStyle;
  FontWeight fontWeight;
  double fontSize;
}

/// Customizes the legend.
class Legend {
  Legend(
      {bool isVisible,
      LegendPosition position,
      ChartAlignment alignment,
      this.backgroundColor,
      Color borderColor,
      double borderWidth,
      double opacity,
      this.height,
      this.width,
      double padding,
      double iconHeight,
      double iconWidth,
      bool toggleSeriesVisibility,
      ChartTextStyle textStyle,
      bool isResponsive,
      LegendItemOrientation orientation,
      LegendTitle title,
      LegendItemOverflowMode overflowMode,
      this.legendItemBuilder,
      Color iconBorderColor,
      double iconBorderWidth,
      double itemPadding,
      this.image})
      : isVisible = isVisible ?? false,
        position = position ?? LegendPosition.auto,
        alignment = alignment ?? ChartAlignment.center,
        borderColor = borderColor ?? Colors.transparent,
        borderWidth = borderWidth ?? 0.0,
        iconBorderColor = iconBorderColor ?? Colors.transparent,
        iconBorderWidth = iconBorderWidth ?? 0.0,
        opacity = opacity ?? 1.0,
        padding = padding ?? 5.0,
        textStyle = _getTextStyle(
            textStyle: textStyle,
            fontSize: 13.0,
            fontStyle: FontStyle.normal,
            fontFamily: 'Segoe UI'),
        iconHeight = iconHeight ?? 12.0,
        iconWidth = iconWidth ?? 12.0,
        toggleSeriesVisibility = toggleSeriesVisibility ?? true,
        isResponsive = isResponsive ?? false,
        orientation = orientation ?? LegendItemOrientation.auto,
        overflowMode = overflowMode ?? LegendItemOverflowMode.scroll,
        itemPadding = itemPadding ?? 10.0,
        title = title ?? LegendTitle() {
    _renderer = _LegendRenderer();
  }

  /// Toggles the visibility of the legend.
  ///
  /// Defaults to false.
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true)
  ///        ));
  ///}
  ///```
  final bool isVisible;

  ///Position of the legend. By default, the legend position is auto. i.e. If the chart
  ///width is greater than chart height, then the legend will be placed at the right,
  ///else it will be placed at the bottom of the chart.
  ///
  ///Defaults to LegendPosition.auto
  ///
  ///Also refer LegendPosition
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               position: LegendPosition.bottom)
  ///        ));
  ///}
  ///```
  final LegendPosition position;

  ///Alignment of the legend. Alignment will work if the legend width is greater than
  ///the total legend items’ width.
  ///
  ///Defaults to ChartAlignment.center
  ///
  ///Also refer ChartAlignment
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               alignment: ChartAlignment.near)
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;

  ///Background color of the legend.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               backgroundColor: Colors.transparent)
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  ///Border color of the legend.
  ///
  ///Defaults to Colors.transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               boderColor: Colors.brown)
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the legend.
  ///
  ///Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               borderWidth: 3)
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Border color of the icon in the legend items.
  ///
  ///Defaults to Colors.transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               iconBorderColor: Colors.yellow)
  ///        ));
  ///}
  ///```
  final Color iconBorderColor;

  ///Border width of the icon in the legend items.
  ///
  ///Defaults to 0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               iconBorderwidth: 2)
  ///        ));
  ///}
  ///```
  final double iconBorderWidth;

  ///Opacity of the legend. The value ranges from 0 to 1.
  ///
  ///Defaults to 1
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               opacity: 0.5)
  ///        ));
  ///}
  ///```
  final double opacity;

  ///The height of the legend. It takes percentage value from the overall chart height.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               height: '30%')
  ///        ));
  ///}
  ///```
  final String height;

  ///The width of the legend. It takes percentage value from the overall chart width.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               width: '30%')
  ///        ));
  ///}
  ///```
  final String width;

  ///Padding between the legend items.
  ///
  ///Defaults to 5.0
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               padding: 4.0)
  ///        ));
  ///}
  ///```
  final double padding;

  ///Height of the icon in legend item.
  ///
  ///Defaults to 12
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               iconWidth: 14)
  ///        ));
  ///}
  ///```
  final double iconHeight;

  ///Width of the icon in legend item.
  ///
  ///Defaults to 12
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               iconWidth: 14)
  ///        ));
  ///}
  ///```
  final double iconWidth;

  ///Toggles the series visibility. If it is set to false, then on tapping the legend
  ///item, series visibility will not be toggled.
  ///
  ///Defaults to true
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               toggleSeriesVisibility: false)
  ///        ));
  ///}
  ///```
  final bool toggleSeriesVisibility;

  ///Customizes the legend item text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               textStyle: ChartTextStyle(color: Colors.red))
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  ///Toggles the visibility of the legend if the width or height of the legend is greater
  ///than the plot area bounds.
  ///
  ///Defaults to false
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               isResponsive: true)
  ///        ));
  ///}
  ///```
  final bool isResponsive;

  ///Orientation of the legend. The legend items will be placed either in horizontal or
  ///in vertical orientation. By default, it is set to auto, i.e. if the legend position
  ///is top or bottom, orientation is set to horizontal, else it is set to vertical.
  ///
  ///Defaults to LegendItemOrientation.auto
  ///
  ///Also refer LegendItemOrientation
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               orientation: LegendItemOrientation.vertical)
  ///        ));
  ///}
  ///```
  final LegendItemOrientation orientation;

  ///Customizes the legend title.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               title: ChartTitle(
  ///                    text: 'Countries'
  ///            ))
  ///        ));
  ///}
  ///```
  final LegendTitle title;

  ///Widget builder for legend items.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               legendItemBuilder: (String name, dynamic series,dynamic point, int index) {
  ///                 return Container(
  ///                  height: 30, width: 80,child: Row(children: <Widget>[
  ///                         Container(child: Image.asset('images/bike.png')),
  ///                       Container(child: Text(index.toString())),
  ///                     ]));
  ///               })
  ///        ));
  ///}
  ///```
  final LegendItemBuilder legendItemBuilder;

  ///The legend items can be scrolled, wrapped, or left as it is when it exceeds the
  ///available size.
  ///
  ///Defaults to LegendItemOverflowMode.scroll
  ///
  ///Also refer [LegendItemOverflowMode]
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               overflowMode: LegendOverflowMode.wrap)
  ///        ));
  ///}
  ///```
  final LegendItemOverflowMode overflowMode;

  ///Padding of the legend items.
  ///
  ///Defaults to 10.0.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               itemPadding: 5)
  ///        ));
  ///}
  ///```
  final double itemPadding;

  ///Padding of the legend items.
  ///
  ///Defaults to 10.0.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               image: const AssetImage('images/bike.png'))
  ///        ));
  ///}
  ///```
  final ImageProvider image;

  String _imageUrl;

  _LegendRenderer _renderer;

  LegendPosition legendPosition;

  LegendItemOrientation _orientation;
}

class _MeasureWidgetContext {
  _MeasureWidgetContext(
      {this.context, this.key, this.widget, this.seriesIndex, this.pointIndex});
  BuildContext context;
  int seriesIndex;
  int pointIndex;
  Key key;
  Size size;
  Widget widget;
  bool isRender = false;
}

/// Customizes the legend title.
class LegendTitle {
  LegendTitle({this.text, ChartTextStyle textStyle, ChartAlignment alignment})
      : textStyle = _getTextStyle(
            textStyle: textStyle,
            fontSize: 12.0,
            fontStyle: FontStyle.normal,
            fontFamily: 'Segoe UI'),
        alignment = alignment ?? ChartAlignment.center;

  /// Legend title text.
  ///
  /// Defaults to ‘’
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               title: ChartTitle(
  ///                    text: 'Countries'
  ///            ))
  ///        ));
  ///}
  ///```
  final String text;

  /// Customize the legend title text.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               title: ChartTitle(
  ///                    text: 'Countries',
  ///                    textStyle: ChartTextStyle(
  ///                                 color: Colors.red,
  ///                                 fontSize: 12,
  ///                                 fontStyle: FontStyle.normal,
  ///                                 fontWeight: FontWeight.w400,
  ///                                 fontFamily: 'Roboto')
  ///            ))
  ///        ));
  ///}
  ///```
  final ChartTextStyle textStyle;

  /// Alignment of the legend title.
  ///
  /// Defaults to ChartAlignment.center.
  ///
  /// Also refer ChartAlignment
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            legend: Legend(
  ///               isVisible: true,
  ///               title: ChartTitle(
  ///                    text: 'Countries',
  ///                    alignment: ChartAlignment.center
  ///            ))
  ///        ));
  ///}
  ///```
  final ChartAlignment alignment;
}

/// Returns the widget.
typedef LegendItemBuilder = Widget Function(
    String legendText, dynamic series, dynamic point, int seriesIndex);

/// Customizes the empty point.
class EmptyPointSettings {
  EmptyPointSettings(
      {this.color = Colors.grey,
      this.mode = EmptyPointMode.gap,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0});

  ///Color of the empty data point.
  ///
  ///Defaults to grey
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       emptyPointSettings: EmptyPointSettings(color: Colors.black, mode:EmptyPointMode.Zero),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Color color;

  ///Border color of the empty data point.
  ///
  ///Defaults to transparent
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       emptyPointSettings: EmptyPointSettings(borderColor: Colors.black, EmptyPointMode.zero),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the empty data point.
  ///
  ///Defaults to null
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       emptyPointSettings: EmptyPointSettings(borderColor: Colors.black,
  ///                         borderWidth:2, EmptyPointMode.average),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///By default, gap will be generated for empty points, i.e. data points with null value.
  ///The empty points display the values that can be considered as zero, average, or gap.
  ///
  /// Defaults to EmptyPointMode.gap.
  ///
  /// Also refer EmptyPointMode
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCartesianChart(
  ///            series: <BubbleSeries<BubbleColors, num>>[
  ///                   BubbleSeries<BubbleColors, num>(
  ///                       emptyPointSettings: EmptyPointSettings(EmptyPointMode.zero),
  ///                  ),
  ///             ],
  ///        ));
  ///}
  ///```
  final EmptyPointMode mode;
}

/// Maps the index value.
typedef ChartIndexedValueMapper<R> = R Function(int index);

/// Maps the data from data source.
typedef ChartValueMapper<T, R> = R Function(T datum, int index);

/// Returns the widget.
typedef ChartWidgetBuilder<T> = Widget Function(dynamic data, dynamic point,
    dynamic series, int pointIndex, int seriesIndex);
