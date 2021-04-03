part of flutter_charts;

/// Returns the LegendRenderArgs.
typedef CircularLegendRenderCallback = void Function(
    LegendRenderArgs legendRenderArgs);

/// Returns the TooltipArgs.
typedef CircularTooltipCallback = void Function(TooltipArgs tooltipArgs);

/// Returns the DataLabelRenderArgs.
typedef CircularDatalabelRenderCallback = void Function(
    DataLabelRenderArgs dataLabelArgs);

/// Returns the PointTapArgs.
typedef CircularPointTapCallback = void Function(PointTapArgs pointTapArgs);

/// Returns the SelectionArgs.
typedef CircularSelectionCallback = void Function(SelectionArgs selectionArgs);

///Renders the circular chart
///
///```dart
///Widget build(BuildContext context) {
///  return Center(
///    child:SfCircularChart(
///    title: ChartTitle(text: 'Sales by sales person'),
///    legend: Legend(isVisible: true),
///    series: <PieSeries<_PieData, String>>[
///      PieSeries<_PieData, String>(
///        explode: true,
///        explodeIndex: 0,
///        dataSource: pieData,
///        xValueMapper: (_PieData data, _) => data.xData,
///        yValueMapper: (_PieData data, _) => data.yData,
///        dataLabelMapper: (_PieData data, _) => data.text,
///        dataLabelSettings: DataLabelSettings(isVisible: true)),
///    ]
///   )
///  );
/// }
///
/// class _PieData {
///  _PieData(this.xData, this.yData, [this.text]);
///  final String xData;
///  final num yData;
///  final String text;
/// }
/// ```
//ignore:must_be_immutable
class SfCircularChart extends StatefulWidget {
  SfCircularChart(
      {Key key,
      this.backgroundColor,
      this.backgroundImage,
      this.annotations,
      this.borderColor = Colors.transparent,
      this.borderWidth = 0.0,
      this.onLegendItemRender,
      this.onTooltipRender,
      this.onDataLabelRender,
      this.onPointTapped,
      this.onLegendTapped,
      this.onSelectionChanged,
      this.palette = const <Color>[
        Color.fromRGBO(53, 92, 125, 1),
        Color.fromRGBO(192, 108, 132, 1),
        Color.fromRGBO(246, 114, 128, 1),
        Color.fromRGBO(248, 177, 149, 1),
        Color.fromRGBO(116, 180, 155, 1),
        Color.fromRGBO(0, 168, 181, 1),
        Color.fromRGBO(73, 76, 162, 1),
        Color.fromRGBO(255, 205, 96, 1),
        Color.fromRGBO(255, 240, 219, 1),
        Color.fromRGBO(238, 238, 238, 1)
      ],
      ChartTitle title,
      EdgeInsets margin,
      List<CircularSeries<dynamic, dynamic>> series,
      Legend legend,
      String centerX,
      String centerY,
      TooltipBehavior tooltipBehavior,
      ActivationMode selectionGesture,
      bool enableMultiSelection})
      : series = series = series ?? <CircularSeries<dynamic, dynamic>>[],
        title = title ?? ChartTitle(),
        legend = legend ?? Legend(),
        margin = margin ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
        centerX = centerX ?? '50%',
        centerY = centerY ?? '50%',
        tooltipBehavior = tooltipBehavior ?? TooltipBehavior(),
        selectionGesture = selectionGesture ?? ActivationMode.singleTap,
        enableMultiSelection = enableMultiSelection ?? false,
        super(key: key) {
    _chartSeries = _CircularSeries();
    _chartLegend = _ChartLegend();
    _chartTheme = _ChartTheme();
    _needToMoveFromCenter = true;
  }

  ///Customizes the chart title
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            title: ChartTitle(text: 'Default rendering')
  ///        ));
  ///}
  ///```
  final ChartTitle title;

  ///Customizes the chart series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                enableTooltip: true,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final List<CircularSeries<dynamic, dynamic>> series;

  ///Margin for chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            margin: const EdgeInsets.all(2),
  ///            borderColor: Colors.blue
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Customizes the legend in the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            legend: Legend(isVisible: true, position: LegendPosition.auto)
  ///        ));
  ///}
  ///```
  final Legend legend;

  ///Customizes the tooltip in chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///        ));
  ///}
  ///```
  final TooltipBehavior tooltipBehavior;

  ///Background color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  ///Customizes the annotations. Annotations are used to mark the specific area
  ///of interest in the plot area with texts, shapes, or images
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            annotations: <CircularChartAnnotation>[
  ///                CircularChartAnnotation(
  ///                   child Container(
  ///                   child: const Text('Empty data'),
  ///                    angle: 200,
  ///                    radius: '80%'
  ///                 ),
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///```
  final List<CircularChartAnnotation> annotations;

  ///Border color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            borderColor: Colors.red
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            borderWidth: 2,
  ///            borderColor: Colors.red
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Data points or series can be selected while performing interaction on the chart.
  ///It can also be selected at the initial rendering using this property.
  ///
  ///Defaults to []
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///           series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  initialSelectedDataIndexes: <int>[2,0],
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red.withOpacity(0.8),
  ///                    unselectedColor: Colors.grey.withOpacity(0.5)
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```

  ///Background image for chart.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            backgroundImage: const AssetImage('image.png'),
  ///        ));
  ///}
  ///```
  final ImageProvider backgroundImage;

  ///X value for placing the chart.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            centerX: '50%'
  ///        ));
  ///}
  ///```
  final String centerX;

  ///Y value for placing the chart.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            centerY: '50%'
  ///        ));
  ///}
  ///```
  final String centerY;

  bool _needToMoveFromCenter;

  /// Occurs while legend is rendered. Here, you can get the legend's text, shape
  /// series index, and point index case of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            legend: Legend(isVisible: true),
  ///            onLegendItemRender: (LegendRendererArgs args) => legend(args),
  ///        ));
  ///}
  ///dynamic legend(LegendRendererArgs args) {
  ///   args.legendIconType = LegendIconType.diamond;
  ///}
  ///```
  final CircularLegendRenderCallback onLegendItemRender;

  /// Occurs while tooltip is rendered. You can customize the position and header. Here,
  /// you can get the text, header, point index, series, x and y-positions.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///            onTooltipRender: (TooltipArgs args) => tool(args)
  ///        ));
  ///}
  ///dynamic tool(TooltipArgs args) {
  ///   args.locationX = 30;
  ///}
  ///```
  final CircularTooltipCallback onTooltipRender;

  /// Occurs while rendering the data label. The data label and text styles such as color,
  /// font size, and font weight can be customized. You can get the series index, point
  /// index, text, and text style.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            onDataLabelRender: (DataLabelRenderArgs args) => datalabel(args),
  ///            series: <PieSeries<ChartData, String>>[
  ///              PieSeries<ChartData, String>(
  ///                enableTooltip: true,
  ///              ),
  ///             ],
  ///        ));
  ///}
  ///dynamic datalabel(DataLabelRenderArgs args) {
  ///    args.text = 'datalabel';
  ///}
  ///```
  final CircularDatalabelRenderCallback onDataLabelRender;

  /// Occurs when tapping a series point. Here, you can get the series, series index
  /// and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            onPointTapped: (PointTapArgs args) => point(args),
  ///        ));
  ///}
  ///dynamic point(PointTapArgs args) {
  ///   print(args.seriesIndex);
  ///}
  ///```
  final CircularPointTapCallback onPointTapped;

  /// Occurs when the legend is tapped. Here, you can get the series,
  /// series index, and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            onLegendTapped: (LegendTapArgs args) => legend(args),
  ///        ));
  ///}
  ///dynamic legend(LegendTapArgs args) {
  ///   print(args.pointIndex);
  ///}
  ///```
  final ChartLegendTapCallback onLegendTapped;

  /// Occurs while selection changes. Here, you can get the series, selected color,
  /// unselected color, selected border color, unselected border color, selected
  /// border width, unselected border width, series index, and point index.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            onSelectionChanged: (SelectionArgs args) => select(args),
  ///        ));
  ///}
  ///dynamic select(SelectionArgs args) {
  ///   print(args.selectedBorderColor);
  ///}
  ///```
  final CircularSelectionCallback onSelectionChanged;

  ///Color palette for the data points in the chart series. If the series color is
  ///not specified, then the series will be rendered with appropriate palette color.
  ///Ten colors are available by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            palette: <Color>[Colors.red, Colors.green]
  ///        ));
  ///}
  ///```
  final List<Color> palette;

  /// Holds the information of chart state class
  _SfCircularChartState _chartState;

  ///Gesture for activating the selection. Selection can be activated in tap,
  ///double tap, and long press.
  ///
  ///Defaults to ActivationMode.tap
  ///
  ///Also refer [ActivationMode]
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            selectionGesture: ActivationMode.singleTap,
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red.withOpacity(0.8),
  ///                    unselectedColor: Colors.grey.withOpacity(0.5)
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final ActivationMode selectionGesture;

  ///Enables or disables the multiple data points or series selection.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfCircularChart(
  ///            enableMultiSelection: true,
  ///            series: <PieSeries<ChartData, String>>[
  ///                PieSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red.withOpacity(0.8),
  ///                    unselectedColor: Colors.grey.withOpacity(0.5)
  ///                  ),
  ///                ),
  ///              ],
  ///        ));
  ///}
  ///```
  final bool enableMultiSelection;

  _ChartLegend _chartLegend;

  /// Chart theme for chart
  ///
  _ChartTheme _chartTheme;

  /// Holds the information of SeriesBase class
  _CircularSeries _chartSeries;

  @override
  State<StatefulWidget> createState() => _SfCircularChartState();
}

class _SfCircularChartState extends State<SfCircularChart>
    with TickerProviderStateMixin {
  /// Holds the animation controller list for all series
  List<AnimationController> controllerList;

  /// Animation controller for series
  AnimationController animationController;

  /// Repaint notifier for tooltip container
  ValueNotifier<int> tooltipRepaintNotifier;

  /// Animation controller for Annotations
  AnimationController annotationController;

  /// Repaint notifier for series container
  ValueNotifier<int> seriesRepaintNotifier;

  /// To measure legend size and position
  List<_MeasureWidgetContext> legendWidgetContext;

  /// Chart Template info
  List<_ChartTemplateInfo> templates;

  /// List of container widgets for chart series
  List<Widget> _chartWidgets;
  Offset centerLocation;
  Rect chartContainerRect;
  Rect chartAreaRect;
  bool animateCompleted;
  List<int> explodedPoints;
  List<_LegendRenderContext> legendToggleStates;
  List<_MeasureWidgetContext> legendToggleTemplateStates;
  bool initialRender;
  List<_ChartPoint<dynamic>> selectedDataPoints;
  List<_ChartPoint<dynamic>> unselectedDataPoints;
  List<_Region> selectedRegions;
  List<_Region> unselectedRegions;
  List<Rect> dataLabelTemplateRegions;
  List<Rect> annotationRegions;
  _ChartTemplate _chartTemplate;
  _ChartInteraction currentActive;
  Offset _tapPosition;
  _CircularDataLabelRenderer renderDatalabel;
  bool widgetNeedUpdate;
  bool _isLegendToggled;
  CircularSeries<dynamic, dynamic> prevSeries;
  List<_ChartPoint<dynamic>> _oldPoints;
  List<int> selectionData;
  Animation<double> chartElementAnimation;

  @override
  void initState() {
    _initializeDefaultValues();
    super.initState();
  }

  void _initializeDefaultValues() {
    animateCompleted = false;
    initialRender = true;
    controllerList = <AnimationController>[];
    annotationController = AnimationController(vsync: this);
    tooltipRepaintNotifier = ValueNotifier<int>(0);
    seriesRepaintNotifier = ValueNotifier<int>(0);
    legendWidgetContext = <_MeasureWidgetContext>[];
    explodedPoints = <int>[];
    templates = <_ChartTemplateInfo>[];
    legendToggleStates = <_LegendRenderContext>[];
    selectedDataPoints = <_ChartPoint<dynamic>>[];
    unselectedDataPoints = <_ChartPoint<dynamic>>[];
    selectedRegions = <_Region>[];
    unselectedRegions = <_Region>[];
    legendToggleTemplateStates = <_MeasureWidgetContext>[];
    dataLabelTemplateRegions = <Rect>[];
    annotationRegions = <Rect>[];
    widgetNeedUpdate = false;
    _isLegendToggled = false;
    selectionData = <int>[];
  }

  @override
  void didUpdateWidget(SfCircularChart oldWidget) {
    _needsRepaintCircularChart(widget, oldWidget);
    _isLegendToggled = false;
    oldWidget._chartState.initialRender = false;
    widgetNeedUpdate = true;
    prevSeries = oldWidget.series[0];
    if (legendWidgetContext.isNotEmpty) {
      legendWidgetContext.clear();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (controllerList != null) {
      for (int index = 0; index < controllerList.length; index++) {
        controllerList[index].dispose();

        /// Need to dispose all the animation controller instance otherwise it will cause memory leak
      }
    }
    super.dispose();
  }

  void _redraw() {
    widget._chartState.initialRender = false;
    if (_isLegendToggled) {
      prevSeries = widget.series[0];
      _oldPoints =
          List<_ChartPoint<dynamic>>(widget.series[0]._renderPoints.length);
      for (int i = 0; i < widget.series[0]._renderPoints.length; i++) {
        _oldPoints[i] = widget.series[0]._renderPoints[i];
      }
    }
    setState(() {});
  }

  void _refresh() {
    if (widget._chartState.legendWidgetContext.isNotEmpty) {
      for (int i = 0; i < widget._chartState.legendWidgetContext.length; i++) {
        final _MeasureWidgetContext templateContext =
            widget._chartState.legendWidgetContext[i];
        final RenderBox renderBox = templateContext.context.findRenderObject();
        templateContext.size = renderBox.size;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    widget._chartTheme.initializeChartTheme(theme);
    widget._chartState = this;
    return Container(
      child: GestureDetector(
          child: Container(
        decoration: BoxDecoration(
            color: widget.backgroundColor ??
                widget._chartTheme.plotAreaBackgroundColor,
            image: widget.backgroundImage != null
                ? DecorationImage(
                    image: widget.backgroundImage, fit: BoxFit.fill)
                : null,
            border: Border.all(
                color: widget.borderColor, width: widget.borderWidth)),
        child: Column(
          children: <Widget>[_renderChartTitle(widget), _renderChartElements()],
        ),
      )),
    );
  }

  Widget _renderChartElements() {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        Widget element;
        _initialize(constraints);
        widget._chartSeries._findVisibleSeries();
        widget._chartSeries._processDataPoints();
        final List<Widget> legendTemplates = _bindLegendTemplateWidgets(widget);
        if (legendTemplates.isNotEmpty && legendWidgetContext.isEmpty) {
          element = Container(child: Stack(children: legendTemplates));
          SchedulerBinding.instance.addPostFrameCallback((_) => _refresh());
        } else {
          widget._chartLegend
              ._calculateLegendBounds(widget._chartLegend.chartSize);
          element =
              _getElements(widget, _CircularArea(chart: widget), constraints);
        }
        return element;
      }),
    );
  }

  void _initialize(BoxConstraints constraints) {
    widget._chartLegend.chart = widget;
    widget._chartSeries.chart = widget;
    final dynamic width = constraints.maxWidth;
    final dynamic height = constraints.maxHeight;
    final EdgeInsets margin = widget.margin;
    widget.legend.legendPosition =
        (widget.legend.position == LegendPosition.auto)
            ? (height > width ? LegendPosition.bottom : LegendPosition.right)
            : widget.legend.position;
    widget._chartLegend.chartSize = Size(width - margin.left - margin.right,
        height - margin.top - margin.bottom);
  }
}

// ignore: must_be_immutable
class _CircularArea extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _CircularArea({this.chart});
  final SfCircularChart chart;
  CircularSeries<dynamic, dynamic> series;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Listener(
          onPointerUp: (PointerUpEvent event) =>
              _onTapUp(context, event.position),
          onPointerDown: (PointerDownEvent event) =>
              _onTapDown(context, event.position),
          child: GestureDetector(
              onLongPress: _onLongPress,
              onDoubleTap: _onDoubleTap,
              child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: _initializeChart(constraints, context))));
    });
  }

  void _getPointSeriesIndex(SfCircularChart chart, _Region pointRegion) {
    PointTapArgs pointTapArgs;
    pointTapArgs = PointTapArgs();
    pointTapArgs.pointIndex = pointRegion.pointIndex;
    pointTapArgs.seriesIndex = pointRegion.seriesIndex;
    pointTapArgs.dataPoints =
        chart._chartSeries.visibleSeries[pointTapArgs.seriesIndex]._dataPoints;
    chart.onPointTapped(pointTapArgs);
  }

  RenderBox renderBox;
  _Region pointRegion;
  TapDownDetails tapDownDetails;
  Offset doubleTapPosition;
  void _onTapDown(BuildContext context, Offset globalPosition) {
    renderBox = context.findRenderObject();
    chart._chartState.currentActive = null;
    chart._chartState._tapPosition = renderBox.globalToLocal(globalPosition);
    pointRegion = _getPointRegion(chart, chart._chartState._tapPosition);
    if (chart.onPointTapped != null && pointRegion != null) {
      _getPointSeriesIndex(chart, pointRegion);
    }
    doubleTapPosition = chart._chartState._tapPosition;
    if (chart._chartState._tapPosition != null && pointRegion != null) {
      chart._chartState.currentActive = _ChartInteraction(
          pointRegion.seriesIndex,
          pointRegion.pointIndex,
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex],
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex]
              ._renderPoints[pointRegion.pointIndex],
          pointRegion);
    } else {
      chart.tooltipBehavior?._tooltipTemplate?.show = false;
      chart.tooltipBehavior?._tooltipTemplate?.state?._performTooltip();
    }
  }

  void _onDoubleTap() {
    if (doubleTapPosition != null && pointRegion != null) {
      chart._chartState.currentActive = _ChartInteraction(
          pointRegion.seriesIndex,
          pointRegion.pointIndex,
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex],
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex]
              ._renderPoints[pointRegion.pointIndex],
          pointRegion);
      if (chart._chartState.currentActive != null) {
        if (chart._chartState.currentActive.series.explodeGesture ==
            ActivationMode.doubleTap) {
          chart._chartSeries
              ._seriesPointExplosion(chart._chartState.currentActive.region);
        }
      }
      chart._chartSeries
          ._seriesPointSelection(pointRegion, ActivationMode.doubleTap);
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.doubleTap) {
        chart.tooltipBehavior.onDoubleTap(
            doubleTapPosition.dx.toDouble(), doubleTapPosition.dy.toDouble());
      }
    }
  }

  void _onLongPress() {
    if (chart._chartState._tapPosition != null && pointRegion != null) {
      chart._chartState.currentActive = _ChartInteraction(
          pointRegion.seriesIndex,
          pointRegion.pointIndex,
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex],
          chart._chartSeries.visibleSeries[pointRegion.seriesIndex]
              ._renderPoints[pointRegion.pointIndex],
          pointRegion);
      chart._chartSeries
          ._seriesPointSelection(pointRegion, ActivationMode.longPress);
      if (chart._chartState.currentActive != null) {
        if (chart._chartState.currentActive.series.explodeGesture ==
            ActivationMode.longPress) {
          chart._chartSeries
              ._seriesPointExplosion(chart._chartState.currentActive.region);
        }
      }
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.longPress) {
        chart.tooltipBehavior.onLongPress(
            chart._chartState._tapPosition.dx.toDouble(),
            chart._chartState._tapPosition.dy.toDouble());
      }
    }
  }

  void _onTapUp(BuildContext context, Offset globalPosition) {
    if (chart._chartState._tapPosition != null) {
      if (chart._chartState.currentActive != null &&
          chart._chartState.currentActive.series != null &&
          chart._chartState.currentActive.series.explodeGesture ==
              ActivationMode.singleTap) {
        chart._chartSeries
            ._seriesPointExplosion(chart._chartState.currentActive.region);
      }

      if (chart._chartState._tapPosition != null &&
          chart._chartState.currentActive != null) {
        chart._chartSeries._seriesPointSelection(
            chart._chartState.currentActive.region, ActivationMode.singleTap);
      }
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.singleTap &&
          chart._chartState.currentActive != null &&
          chart._chartState.currentActive.series != null) {
        if (chart.tooltipBehavior.builder != null) {
          final CircularSeries<dynamic, dynamic> chartSeries =
              chart._chartState.currentActive.series;
          final _ChartPoint<dynamic> point =
              chart._chartState.currentActive.point;
          final Offset location = _degreeToPoint(point.midAngle,
              (point.innerRadius + point.outerRadius) / 2, point.center);
          chart.tooltipBehavior._tooltipTemplate.rect =
              Rect.fromLTWH(location.dx, location.dy, 0, 0);
          chart.tooltipBehavior._tooltipTemplate.template =
              chart.tooltipBehavior.builder(
                  chartSeries
                      .dataSource[chart._chartState.currentActive.pointIndex],
                  point,
                  chartSeries,
                  chart._chartState.currentActive.seriesIndex,
                  chart._chartState.currentActive.pointIndex);
          chart.tooltipBehavior._tooltipTemplate.show = true;
          chart.tooltipBehavior._tooltipTemplate?.state?._performTooltip();
        } else {
          final RenderBox renderBox = context.findRenderObject();
          final Offset position = renderBox.globalToLocal(globalPosition);
          chart.tooltipBehavior
              .onTouchUp(position.dx.toDouble(), position.dy.toDouble());
        }
      }
    }
    chart._chartState._tapPosition = null;
  }

  Widget _initializeChart(BoxConstraints constraints, BuildContext context) {
    _calculateSize(constraints);
    chart._chartSeries?._calculateAngleAndCenterPositions();
    return Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: _renderWidgets(constraints, context));
  }

  void _calculateSize(BoxConstraints constraints) {
    final dynamic width = constraints.maxWidth;
    final dynamic height = constraints.maxHeight;
    chart._chartState.chartContainerRect = Rect.fromLTWH(0, 0, width, height);
    final EdgeInsets margin = chart.margin;
    chart._chartState.chartAreaRect = Rect.fromLTWH(
        margin.left,
        margin.top,
        width - margin.right - margin.left,
        height - margin.top - margin.bottom);
  }

  Widget _renderWidgets(BoxConstraints constraints, BuildContext context) {
    _bindSeriesWidgets();
    _findTemplates();
    _renderTemplates();
    _bindTooltipWidgets(constraints);
    return Container(child: Stack(children: chart._chartState._chartWidgets));
  }

  void _findTemplates() {
    Offset labelLocation;
    const num lineLength = 10;
    _ChartPoint<dynamic> point;
    Widget labelWidget;
    chart._chartState.templates = <_ChartTemplateInfo>[];
    chart._chartState.dataLabelTemplateRegions = <Rect>[];
    chart._chartState.annotationRegions = <Rect>[];
    for (int k = 0; k < chart._chartSeries.visibleSeries.length; k++) {
      final CircularSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[k];
      final ConnectorLineSettings connector =
          series.dataLabelSettings.connectorLineSettings;
      if (series.dataLabelSettings.isVisible &&
          series.dataLabelSettings.builder != null) {
        for (int i = 0; i < series._renderPoints.length; i++) {
          point = series._renderPoints[i];
          ChartAlignment labelAlign;
          if (point.isVisible) {
            labelWidget = series.dataLabelSettings
                .builder(series.dataSource[i], point, series, i, k);
            if (series.dataLabelSettings.labelPosition ==
                ChartDataLabelPosition.inside) {
              labelLocation = _degreeToPoint(point.midAngle,
                  (point.innerRadius + point.outerRadius) / 2, point.center);
              labelLocation = Offset(labelLocation.dx, labelLocation.dy);
              labelAlign = ChartAlignment.center;
            } else {
              final num connectorLength =
                  _percentToValue(connector.length, point.outerRadius);
              labelLocation = _degreeToPoint(point.midAngle,
                  point.outerRadius + connectorLength, point.center);
              labelLocation = Offset(
                  point.dataLabelPosition == Position.right
                      ? labelLocation.dx + lineLength + 5
                      : labelLocation.dx - lineLength - 5,
                  labelLocation.dy);
              labelAlign = point.dataLabelPosition == Position.left
                  ? ChartAlignment.far
                  : ChartAlignment.near;
            }
            chart._chartState.templates.add(_ChartTemplateInfo(
                key: GlobalKey(),
                templateType: 'DataLabel',
                pointIndex: i,
                seriesIndex: k,
                needMeasure: true,
                clipRect: chart._chartState.chartAreaRect,
                animationDuration: 500,
                widget: labelWidget,
                horizontalAlignment: labelAlign,
                verticalAlignment: ChartAlignment.center,
                location: labelLocation));
          }
        }
      }
    }

    if (chart.annotations != null && chart.annotations.isNotEmpty) {
      for (int i = 0; i < chart.annotations.length; i++) {
        final CircularChartAnnotation annotation = chart.annotations[i];
        if (annotation.widget != null) {
          final double radius =
              _percentToValue(annotation.radius, chart._chartSeries.size / 2)
                  .toDouble();
          final Offset point = _degreeToPoint(
              annotation.angle, radius, chart._chartState.centerLocation);
          final double annotationHeight =
              _percentToValue(annotation.height, chart._chartSeries.size / 2);
          final double annotationWidth =
              _percentToValue(annotation.width, chart._chartSeries.size / 2);
          final _ChartTemplateInfo templateInfo = _ChartTemplateInfo(
              key: GlobalKey(),
              templateType: 'Annotation',
              needMeasure: true,
              horizontalAlignment: annotation.horizontalAlignment,
              verticalAlignment: annotation.verticalAlignment,
              clipRect: chart._chartState.chartContainerRect,
              widget: annotationHeight > 0 && annotationWidth > 0
                  ? Container(
                      height: annotationHeight,
                      width: annotationWidth,
                      child: annotation.widget)
                  : annotation.widget,
              pointIndex: i,
              animationDuration: 500,
              location: point);

          chart._chartState.templates.add(templateInfo);
        }
      }
    }
  }

  void _renderTemplates() {
    if (chart._chartState.templates.isNotEmpty) {
      for (int i = 0; i < chart._chartState.templates.length; i++) {
        final _ChartTemplateInfo chartTemplateInfo =
            chart._chartState.templates[i];
        chartTemplateInfo.animationDuration = !chart._chartState.initialRender
            ? 0
            : chartTemplateInfo.animationDuration;
      }
      chart._chartState._chartTemplate = _ChartTemplate(
          templates: chart._chartState.templates,
          render: chart._chartState.animateCompleted,
          chart: chart);
      chart._chartState._chartWidgets.add(chart._chartState._chartTemplate);
    }
  }

  void _bindTooltipWidgets(BoxConstraints constraints) {
    if (chart.tooltipBehavior.enable) {
      if (chart.tooltipBehavior.builder != null) {
        chart.tooltipBehavior._tooltipTemplate = _TooltipTemplate(
            show: false, clipRect: chart._chartState.chartContainerRect);
        chart._chartState._chartWidgets
            .add(chart.tooltipBehavior._tooltipTemplate);
      } else {
        final _TooltipPainter tooltipPainter = _TooltipPainter(
            valueNotifier: chart._chartState.tooltipRepaintNotifier);
        tooltipPainter._chartState = chart._chartState;
        tooltipPainter._chart = chart;
        tooltipPainter.tooltip = chart.tooltipBehavior;
        chart.tooltipBehavior._painter = tooltipPainter;
        chart._chartState._chartWidgets.add(
          Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: CustomPaint(painter: tooltipPainter)),
        );
      }
    }
  }

  void _bindSeriesWidgets() {
    CustomPainter seriesPainter;
    Animation<double> seriesAnimation;
    chart._chartState._chartWidgets ??= <Widget>[];
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      series = chart._chartSeries.visibleSeries[i];
      if (series.selectionSettings != null) {
        if (series.initialSelectedDataIndexes.isNotEmpty) {
          for (int index = 0;
              index < series.initialSelectedDataIndexes.length;
              index++) {
            chart._chartState.selectionData
                .add(series.initialSelectedDataIndexes[index]);
          }
        }
      }
      if (series.animationDuration > 0 &&
          (chart._chartState.initialRender ||
              chart._chartState.widgetNeedUpdate ||
              chart._chartState._isLegendToggled)) {
        //chart._chartState.animateCompleted = false;
        chart._chartState.animationController =
            AnimationController(vsync: chart._chartState)
              ..addListener(() {
                chart._chartState.seriesRepaintNotifier.value++;
              });
        chart._chartState.animationController.duration =
            Duration(milliseconds: series.animationDuration.toInt());
        seriesAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: chart._chartState.animationController,
          curve: const Interval(0.1, 0.8, curve: Curves.linear),
        )..addStatusListener((AnimationStatus status) {
                if (status == AnimationStatus.completed) {
                  chart._chartState.animateCompleted = true;
                  if (chart._chartState._chartTemplate != null &&
                      chart._chartState._chartTemplate.state != null) {
                    chart._chartState._chartTemplate.state.templateRender();
                  }
                }
              }));
        chart._chartState.chartElementAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: chart._chartState.animationController,
          curve: const Interval(0.85, 1.0, curve: Curves.decelerate),
        ));
        chart._chartState.animationController.forward(from: 0.0);
        chart._chartState.controllerList
            .add(chart._chartState.animationController);
      } else {
        chart._chartState.animateCompleted = true;
      }
      _animateComplete(chart._chartState.controllerList, chart);
      if (series._seriesType == 'pie') {
        seriesPainter = _PieChartPainter(
            chart: chart,
            index: i,
            isRepaint: series._needsRepaint,
            animationController: chart._chartState.animationController,
            seriesAnimation: seriesAnimation,
            notifier: chart._chartState.seriesRepaintNotifier);
      } else if (series._seriesType == 'doughnut') {
        seriesPainter = _DoughnutChartPainter(
            chart: chart,
            index: i,
            isRepaint: series._needsRepaint,
            animationController: chart._chartState.animationController,
            seriesAnimation: seriesAnimation,
            notifier: chart._chartState.seriesRepaintNotifier);
      } else if (series._seriesType == 'radialbar') {
        seriesPainter = _RadialBarPainter(
            chart: chart,
            index: i,
            isRepaint: series._needsRepaint,
            animationController: chart._chartState.animationController,
            seriesAnimation: seriesAnimation,
            notifier: chart._chartState.seriesRepaintNotifier);
      }
      chart._chartState._chartWidgets
          .add(RepaintBoundary(child: CustomPaint(painter: seriesPainter)));
      chart._chartState.renderDatalabel =
          _CircularDataLabelRenderer(circularChart: chart, show: false);
      chart._chartState._chartWidgets.add(chart._chartState.renderDatalabel);
    }
  }
}
