part of flutter_charts;

// ignore: must_be_immutable
class _RenderTemplate extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _RenderTemplate(
      {this.template,
      this.needMeasure,
      this.templateLength,
      this.templateIndex,
      this.chart});
  final _ChartTemplateInfo template;
  bool needMeasure;
  final int templateLength;
  final int templateIndex;
  final dynamic chart;
  bool isAnnotation;

  @override
  State<StatefulWidget> createState() => _RenderTemplateState();
}

class _RenderTemplateState extends State<_RenderTemplate>
    with TickerProviderStateMixin {
  List<AnimationController> templateControllerList;
  AnimationController animationController;
  Animation<double> animation;
  @override
  void initState() {
    templateControllerList = <AnimationController>[];
    super.initState();
  }

  @override
  void dispose() {
    if (templateControllerList.isNotEmpty) {
      for (int index = 0; index < templateControllerList.length; index++) {
        templateControllerList[index].dispose();
      }
      templateControllerList.clear();
    }
    super.dispose();
  }

  void _templatesMeasureCompleted() {
    final RenderBox renderBox = widget.template.context.findRenderObject();
    widget.template.size = renderBox.size;
    setState(() {
      widget.template.needMeasure = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    final List<Widget> templateWidgets = <Widget>[];
    if (widget.template.needMeasure) {
      currentWidget = Opacity(opacity: 0.0, child: widget.template.widget);
      widget.template.context = context;
      SchedulerBinding.instance
          .addPostFrameCallback((_) => _templatesMeasureCompleted());
    } else {
      num locationX, locationY;
      final _ChartTemplateInfo templateInfo = widget.template;
      locationX = templateInfo.location.dx -
          (templateInfo.horizontalAlignment == ChartAlignment.near
              ? 0
              : templateInfo.horizontalAlignment == ChartAlignment.center
                  ? templateInfo.size.width / 2
                  : templateInfo.size.width);
      locationY = templateInfo.location.dy -
          (templateInfo.verticalAlignment == ChartAlignment.near
              ? 0
              : templateInfo.verticalAlignment == ChartAlignment.center
                  ? templateInfo.size.height / 2
                  : templateInfo.size.height);
      final Rect rect = Rect.fromLTWH(locationX, locationY,
          templateInfo.size.width, templateInfo.size.height);
      final bool isCollide = (templateInfo.templateType == 'DataLabel')
          ? _isCollide(rect, widget.chart._chartState.dataLabelTemplateRegions)
          : false;
      if (!isCollide && _isTemplateWithinBounds(templateInfo.clipRect, rect)) {
        final Widget renderWidget = Stack(children: <Widget>[
          Positioned(
            left: locationX,
            top: locationY,
            child: templateInfo.widget,
          )
        ]);
        (templateInfo.templateType == 'DataLabel')
            ? widget.chart._chartState.dataLabelTemplateRegions.add(rect)
            : widget.chart._chartState.annotationRegions.add(rect);

        if (templateInfo.animationDuration > 0) {
          animationController = AnimationController(
              duration:
                  Duration(milliseconds: widget.template.animationDuration),
              vsync: this);
          animation = Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: animationController, curve: Curves.linear));
          animationController.forward(from: 0.0);
          templateControllerList.add(animationController);
          templateWidgets.add(AnimatedBuilder(
              animation: animationController,
              child: renderWidget,
              builder: (BuildContext context, Widget _widget) {
                final double value = animationController.value;
                return Opacity(opacity: value * 1.0, child: _widget);
              }));
        } else {
          templateWidgets.add(renderWidget);
        }
      }
      currentWidget = Container(child: Stack(children: templateWidgets));
    }
    return currentWidget;
  }

  bool _isTemplateWithinBounds(Rect bounds, Rect templateRect) =>
      templateRect.left >= bounds.left &&
      templateRect.left + templateRect.width <= bounds.left + bounds.width &&
      templateRect.top >= bounds.top &&
      templateRect.top + templateRect.height <= bounds.top + bounds.height;
}

// ignore: must_be_immutable
class _ChartTemplate extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _ChartTemplate({this.templates, this.render, this.chart});

  List<_ChartTemplateInfo> templates;

  bool render = false;

  dynamic chart;

  _ChartTemplateState state;

  @override
  State<StatefulWidget> createState() => _ChartTemplateState();
}

class _ChartTemplateState extends State<_ChartTemplate> {
  @override
  void initState() {
    widget.state = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void templateRender() {
    setState(() {
      widget.render = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget renderTemplate = Container();
    if (widget.chart._chartState.animateCompleted &&
        widget.templates.isNotEmpty) {
      final List<Widget> renderWidgets = <Widget>[];
      for (int i = 0; i < widget.templates.length; i++) {
        renderWidgets.add(_RenderTemplate(
          template: widget.templates[i],
          templateIndex: i,
          templateLength: widget.templates.length,
          chart: widget.chart,
        ));
      }
      renderTemplate = Stack(children: renderWidgets);
    }
    return renderTemplate;
  }
}

class _ChartTemplateInfo {
  _ChartTemplateInfo(
      {this.key,
      this.widget,
      this.location,
      this.animationDuration,
      this.seriesIndex,
      this.pointIndex,
      this.templateType,
      this.clipRect,
      this.needMeasure,
      ChartAlignment horizontalAlignment,
      ChartAlignment verticalAlignment})
      : horizontalAlignment = horizontalAlignment ?? ChartAlignment.center,
        verticalAlignment = verticalAlignment ?? ChartAlignment.center;
  Key key;
  Widget widget;
  Size size;
  dynamic point;
  Offset location;
  BuildContext context;
  int animationDuration;
  int pointIndex;
  int seriesIndex;
  Rect clipRect;
  String templateType;
  ChartAlignment horizontalAlignment;
  ChartAlignment verticalAlignment;
  bool needMeasure;
}
