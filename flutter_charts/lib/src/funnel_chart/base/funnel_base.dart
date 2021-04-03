part of flutter_charts;

/// Returns the LegendRenderArgs.
typedef FunnelLegendRenderCallback = void Function(
    LegendRenderArgs legendRenderArganimateCompleteds);

/// Returns the TooltipArgs.
typedef FunnelTooltipCallback = void Function(TooltipArgs tooltipArgs);

/// Returns the DataLabelRenderArgs.
typedef FunnelDatalabelRenderCallback = void Function(
    DataLabelRenderArgs dataLabelArgs);

/// Returns the SelectionArgs.
typedef FunnelSelectionCallback = void Function(SelectionArgs selectionArgs);

///Renders the funnel chart
///
//ignore:must_be_immutable
class SfFunnelChart extends StatefulWidget {
  SfFunnelChart({
    Key key,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.onLegendItemRender,
    this.onTooltipRender,
    this.onDataLabelRender,
    this.onLegendTapped,
    this.onSelectionChanged,
    ChartTitle title,
    FunnelSeries<dynamic, dynamic> series,
    EdgeInsets margin,
    Legend legend,
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
    TooltipBehavior tooltipBehavior,
    SmartLabelMode smartLabelMode,
    ActivationMode selectionGesture,
    bool enableMultiSelection,
  })  : title = title ?? ChartTitle(),
        series = series ?? FunnelSeries<dynamic, dynamic>(),
        margin = margin ?? const EdgeInsets.fromLTRB(10, 10, 10, 10),
        legend = legend ?? Legend(),
        tooltipBehavior = tooltipBehavior ?? TooltipBehavior(),
        smartLabelMode = smartLabelMode ?? SmartLabelMode.hide,
        selectionGesture = selectionGesture ?? ActivationMode.singleTap,
        enableMultiSelection = enableMultiSelection ?? false,
        super(key: key) {
    _chartSeries = _FunnelSeries();
    _chartLegend = _ChartLegend();
    _chartTheme = _ChartTheme();
  }

  ///Customizes the chart title
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            title: ChartTitle(text: 'Funnel Chart')
  ///        ));
  ///}
  ///```
  final ChartTitle title;

  ///Background color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color backgroundColor;

  ///Background color of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final Color borderColor;

  ///Border width of the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundColor: Colors.blue
  ///        ));
  ///}
  ///```
  final double borderWidth;

  ///Customizes the chart series.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            series: FunnelSeries<_FunnelData, String>(
  ///                          dataSource: data,
  ///                          xValueMapper: (_FunnelData data, _) => data.xData,
  ///                          yValueMapper: (_FunnelData data, _) => data.yData)
  ///        ));
  ///}
  ///```
  final FunnelSeries<dynamic, dynamic> series;

  ///Margin for chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            margin: const EdgeInsets.all(2),
  ///        ));
  ///}
  ///```
  final EdgeInsets margin;

  ///Customizes the legend in the chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            legend: Legend(isVisible: true)
  ///        ));
  ///}
  ///```
  final Legend legend;

  ///Color palette for the data points in the chart series. If the series color is
  ///not specified, then the series will be rendered with appropriate palette color.
  ///Ten colors are available by default.
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            palette: <Color>[Colors.red, Colors.green]
  ///        ));
  ///}
  ///```
  final List<Color> palette;

  ///Customizes the tooltip in chart
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            tooltipBehavior: TooltipBehavior(enable: true)
  ///        ));
  ///}
  ///```
  final TooltipBehavior tooltipBehavior;

  /// Occurs while legend is rendered. Here, you can get the legend's text, shape
  /// series index, and point index case of circular series.
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            legend: Legend(isVisible: true),
  ///            onLegendItemRender: (LegendRendererArgs args) => legend(args),
  ///        ));
  ///}
  ///dynamic legend(LegendRendererArgs args) {
  ///   args.legendIconType = LegendIconType.diamond;
  ///}
  ///```
  final FunnelLegendRenderCallback onLegendItemRender;

  final FunnelTooltipCallback onTooltipRender;
  final FunnelDatalabelRenderCallback onDataLabelRender;
  final ChartLegendTapCallback onLegendTapped;
  final SmartLabelMode smartLabelMode;

  ///Data points or series can be selected while performing interaction on the chart.
  ///It can also be selected at the initial rendering using this property.
  ///
  ///Defaults to []
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///           series: FunnelSeries<ChartData, String>(
  ///                  initialSelectedDataIndexes: <int>[1,0],
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```

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
  ///        child: SfFunnelChart(
  ///           selectionGesture: ActivationMode.singleTap,
  ///           series: FunnelSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```
  final ActivationMode selectionGesture;

  ///Enables or disables the multiple data points selection.
  ///
  ///Defaults to false
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///           enableMultiSelection: true,
  ///           series: FunnelSeries<ChartData, String>(
  ///                  selectionSettings: SelectionSettings(
  ///                    selectedColor: Colors.red,
  ///                    unselectedColor: Colors.grey
  ///                  ),
  ///                ),
  ///        ));
  ///}
  ///```
  final bool enableMultiSelection;

  ///Background image for chart.
  ///
  ///Defaults to null
  ///
  ///```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfFunnelChart(
  ///            backgroundImage: const AssetImage('image.png'),
  ///        ));
  ///}
  ///```
  final ImageProvider backgroundImage;

  final FunnelSelectionCallback onSelectionChanged;

  //Internal variables
  String _seriesType;
  List<_PointInfo<dynamic>> _dataPoints;
  List<_PointInfo<dynamic>> _renderPoints;
  _FunnelSeries _chartSeries;
  _SfFunnelChartState _chartState;
  _ChartLegend _chartLegend;
  _ChartTheme _chartTheme;

  @override
  State<StatefulWidget> createState() => _SfFunnelChartState();
}

class _SfFunnelChartState extends State<SfFunnelChart>
    with TickerProviderStateMixin {
  List<AnimationController>
      controllerList; // Holds the animation controller list for all series
  AnimationController animationController; // Animation controller for series
  AnimationController
      annotationController; // Animation controller for Annotations
  ValueNotifier<int>
      seriesRepaintNotifier; // Repaint notifier for series container
  ValueNotifier<int> tooltipRepaintNotifier;
  List<_MeasureWidgetContext>
      legendWidgetContext; // To measure legend size and position
  List<_ChartTemplateInfo> templates; // Chart Template info
  List<Widget> _chartWidgets;
  Rect chartContainerRect;
  Rect chartAreaRect;
  _ChartTemplate _chartTemplate;
  _ChartInteraction currentActive;
  bool initialRender;
  List<_LegendRenderContext> legendToggleStates;
  List<_MeasureWidgetContext> legendToggleTemplateStates;
  bool _isLegendToggled;
  Offset _tapPosition;
  bool animateCompleted;
  Animation<double> chartElementAnimation;
  _FunnelDataLabelRenderer renderDatalabel;
  bool widgetNeedUpdate;
  List<int> explodedPoints;
  List<Rect> dataLabelTemplateRegions;
  List<int> selectionData;

  @override
  void initState() {
    _initializeDefaultValues();
    super.initState();
  }

  void _initializeDefaultValues() {
    initialRender = true;
    controllerList = <AnimationController>[];
    annotationController = AnimationController(vsync: this);
    seriesRepaintNotifier = ValueNotifier<int>(0);
    legendToggleStates = <_LegendRenderContext>[];
    legendToggleTemplateStates = <_MeasureWidgetContext>[];
    tooltipRepaintNotifier = ValueNotifier<int>(0);
    explodedPoints = <int>[];
    animateCompleted = true;
    _isLegendToggled = false;
    widgetNeedUpdate = false;
    dataLabelTemplateRegions = <Rect>[];
    selectionData = <int>[];
    legendWidgetContext = <_MeasureWidgetContext>[];
  }

  @override
  void didUpdateWidget(SfFunnelChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLegendToggled = false;
    widgetNeedUpdate = true;
  }

  @override
  void dispose() {
    if (controllerList != null) {
      for (int index = 0; index < controllerList.length; index++) {
        controllerList[index].dispose();
      }
    }
    super.dispose();
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
                    color: widget.backgroundColor,
                    image: widget.backgroundImage != null
                        ? DecorationImage(
                            image: widget.backgroundImage, fit: BoxFit.fill)
                        : null,
                    border: Border.all(
                        color: widget.borderColor, width: widget.borderWidth)),
                child: Column(
                  children: <Widget>[
                    _renderChartTitle(widget),
                    _renderChartElements()
                  ],
                ))));
  }

  Widget _renderChartElements() {
    return Expanded(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Widget element;
      if (widget.series.dataSource != null) {
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
              _getElements(widget, _FunnelPlotArea(chart: widget), constraints);
        }
      } else {
        element = Container();
      }
      return element;
    }));
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

  void _redraw() {
    widget._chartState.initialRender = false;
    setState(() {});
  }

  void _initialize(BoxConstraints constraints) {
    widget._chartLegend.chart = widget;
    widget._chartSeries.chart = widget;
    widget._chartState._chartWidgets = <Widget>[];
    final dynamic width = constraints.maxWidth;
    final dynamic height = constraints.maxHeight;
    final EdgeInsets margin = widget.margin;
    if (widget.legend.position == LegendPosition.auto) {
      widget.legend.legendPosition =
          height > width ? LegendPosition.bottom : LegendPosition.right;
    } else {
      widget.legend.legendPosition = widget.legend.position;
    }
    widget._chartLegend.chartSize = Size(width - margin.left - margin.right,
        height - margin.top - margin.bottom);
  }
}

// ignore: must_be_immutable
class _FunnelPlotArea extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _FunnelPlotArea({this.chart});
  final SfFunnelChart chart;
  FunnelSeries<dynamic, dynamic> series;
  RenderBox renderBox;
  _Region pointRegion;
  TapDownDetails tapDownDetails;
  Offset doubleTapPosition;

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

  Widget _initializeChart(BoxConstraints constraints, BuildContext context) {
    _calculateSize(constraints);
    return GestureDetector(
        child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: _renderWidgets(constraints, context)));
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
    _getPathRegion();
    _findTemplates(chart);
    _renderTemplates(chart);
    _bindTooltipWidgets(constraints);
    return Container(child: Stack(children: chart._chartState._chartWidgets));
  }

  void _getPathRegion() {
    if (chart._chartSeries.visibleSeries.isNotEmpty) {
      final FunnelSeries<dynamic, dynamic> series =
          chart._chartSeries.visibleSeries[0];
      for (int i = 0; i < series._renderPoints.length; i++) {
        if (series._renderPoints[i].isVisible) {
          chart._chartSeries._calculateFunnelPathRegion(i);
        }
      }
    }
  }

  void _bindSeriesWidgets() {
    CustomPainter seriesPainter;
    Animation<double> seriesAnimation;
    for (int i = 0; i < chart._chartSeries.visibleSeries.length; i++) {
      series = chart._chartSeries.visibleSeries[i];
      chart._chartSeries._initializeSeriesProperties(series);
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
      seriesPainter = _FunnelChartPainter(
          chart: chart,
          seriesIndex: i,
          isRepaint: series._needsRepaint,
          animationController: chart._chartState.animationController,
          seriesAnimation: seriesAnimation,
          notifier: chart._chartState.seriesRepaintNotifier);
      chart._chartState._chartWidgets
          .add(RepaintBoundary(child: CustomPaint(painter: seriesPainter)));
      chart._chartState.renderDatalabel =
          _FunnelDataLabelRenderer(funnelChart: chart, show: false);
      chart._chartState._chartWidgets.add(chart._chartState.renderDatalabel);
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

  void _onTapDown(BuildContext context, Offset globalPosition) {
    renderBox = context.findRenderObject();
    chart._chartState.currentActive = null;
    chart._chartState._tapPosition = renderBox.globalToLocal(globalPosition);
    bool isPoint;
    const num seriesIndex = 0;
    num pointIndex;
    final FunnelSeries<dynamic, dynamic> series =
        chart._chartSeries.visibleSeries[seriesIndex];
    for (int j = 0; j < series._renderPoints.length; j++) {
      if (series._renderPoints[j].isVisible) {
        isPoint = _isPointInPolygon(
            series._renderPoints[j].pathRegion, chart._chartState._tapPosition);
        if (isPoint) {
          pointIndex = j;
          break;
        }
      }
    }
    doubleTapPosition = chart._chartState._tapPosition;
    if (chart._chartState._tapPosition != null && isPoint) {
      chart._chartState.currentActive = _ChartInteraction(
        seriesIndex,
        pointIndex,
        chart._chartSeries.visibleSeries[seriesIndex],
        chart._chartSeries.visibleSeries[seriesIndex]._renderPoints[pointIndex],
      );
    } else {
      chart.tooltipBehavior?._tooltipTemplate?.show = false;
      chart.tooltipBehavior?._tooltipTemplate?.state?._performTooltip();
    }
  }

  void _onDoubleTap() {
    const num seriesIndex = 0;
    if (doubleTapPosition != null && chart._chartState.currentActive != null) {
      final num pointIndex = chart._chartState.currentActive.pointIndex;
      chart._chartState.currentActive = _ChartInteraction(
          seriesIndex,
          pointIndex,
          chart._chartSeries.visibleSeries[seriesIndex],
          chart._chartSeries.visibleSeries[seriesIndex]
              ._renderPoints[pointIndex]);
      if (chart._chartState.currentActive != null) {
        if (chart._chartState.currentActive.series.explodeGesture ==
            ActivationMode.doubleTap) {
          chart._chartSeries._pointExplode(pointIndex);
        }
      }
      chart._chartSeries
          ._seriesPointSelection(pointIndex, ActivationMode.doubleTap);
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.doubleTap) {
        chart.tooltipBehavior.onDoubleTap(
            doubleTapPosition.dx.toDouble(), doubleTapPosition.dy.toDouble());
      }
    }
  }

  void _onLongPress() {
    const num seriesIndex = 0;
    if (chart._chartState._tapPosition != null &&
        chart._chartState.currentActive != null) {
      final num pointIndex = chart._chartState.currentActive.pointIndex;
      chart._chartState.currentActive = _ChartInteraction(
          seriesIndex,
          pointIndex,
          chart._chartSeries.visibleSeries[seriesIndex],
          chart._chartSeries.visibleSeries[seriesIndex]
              ._renderPoints[pointIndex],
          pointRegion);
      chart._chartSeries
          ._seriesPointSelection(pointIndex, ActivationMode.longPress);
      if (chart._chartState.currentActive != null) {
        if (chart._chartState.currentActive.series.explodeGesture ==
            ActivationMode.longPress) {
          chart._chartSeries._pointExplode(pointIndex);
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
            ._pointExplode(chart._chartState.currentActive.pointIndex);
      }
      if (chart._chartState._tapPosition != null &&
          chart._chartState.currentActive != null) {
        chart._chartSeries._seriesPointSelection(
            chart._chartState.currentActive.pointIndex,
            ActivationMode.singleTap);
      }
      if (chart.tooltipBehavior.enable &&
          chart.tooltipBehavior.activationMode == ActivationMode.singleTap &&
          chart._chartState.currentActive != null &&
          chart._chartState.currentActive.series != null) {
        if (chart.tooltipBehavior.builder != null) {
          final FunnelSeries<dynamic, dynamic> chartSeries =
              chart._chartState.currentActive.series;
          final _PointInfo<dynamic> point =
              chart._chartState.currentActive.point;
          final Offset location = point.symbolLocation;
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
}
