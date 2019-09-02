import 'package:flutter/material.dart';

/// https://github.com/theshivamlko/rulers_flutter_package/blob/master/lib/src/RulerWidget.dart
class RulerWidget extends StatefulWidget {
  /// total numbers on scale
  final int limit;

  /// starting number of scale to show marker
  final int lowerLimit;

  /// ending number of scale  to show marker
  final int upperLimit;

  /// mid starting number of scale (Optional)
  final int midLimitLower;

  /// mid ending number of scale (Optional)
  final int midLimitUpper;

  /// number of small bars of scale
  final int interval;

  /// number color of bars of scale
  final Color normalBarColor;

  /// color between lowerLimit and upperLimit bars of scale (Optional)
  final Color inRangeBarColor;

  /// color between midLimitUpper and upperLimit bars of scale (Optional)
  final Color outRangeBarColor;

  /// color between midLimitLower and lowerLimit bars of scale (Optional)
  final Color behindRangeBarColor;

  /// color of scale (Optional)
  final Color scaleColor;

  /// Custom Indicator over bars of scale (Optional)
  final Widget indicatorWidget;

  /// height of scale if horizontal or width of scale if vertical (Optional)
  final double scaleSize;

  /// Scale to be horizontal or vertical ,by default horizontal
  final Axis axis;

  final ScrollController scrollController;

  RulerWidget(
      {this.limit,
      this.scaleSize,
      this.indicatorWidget,
      this.lowerLimit: 0,
      this.midLimitLower: 0,
      this.midLimitUpper: 0,
      this.upperLimit: 0,
      this.interval,
      this.normalBarColor,
      this.scaleColor,
      this.inRangeBarColor,
      this.behindRangeBarColor,
      this.outRangeBarColor,
      this.scrollController,
      this.axis: Axis.horizontal})
      : assert(limit != null),
        assert(scaleSize != null),
        assert(interval != null),
        assert(normalBarColor != null);

  @override
  _RulerWidgetState createState() => _RulerWidgetState();
}

class _RulerWidgetState extends State<RulerWidget> {
  List<Widget> scaleWidgetList;

  @override
  void initState() {
    super.initState();

    scaleWidgetList = List();
    _generateScale();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.scaleColor,
        height: widget.axis == Axis.horizontal ? widget.scaleSize : null,
        width: widget.axis == Axis.vertical ? widget.scaleSize : null,
        child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: widget.axis,
            child: RotatedBox(
                quarterTurns: widget.axis == Axis.horizontal ? 4 : 3,
                child: Row(children: scaleWidgetList))));
  }

  void _generateScale() async {
    for (int i = 0; i < widget.limit; i++) {
      scaleWidgetList.add(RulerBarWidget(
          key: ValueKey(i),
          num: i,
          type: RulerBar.BIG_BAR,
          lowerLimit: widget.lowerLimit,
          upperLimit: widget.upperLimit,
          indicatorWidget: widget.indicatorWidget,
          midLimitLower: widget.midLimitLower,
          midLimitUpper: widget.midLimitUpper,
          midInterval: widget.interval,
          normalBarColor: widget.normalBarColor,
          inRangeBarColor: widget.inRangeBarColor,
          behindRangeBarColor: widget.behindRangeBarColor,
          outRangeBarColor: widget.outRangeBarColor,
          axis: widget.axis));
    }

    if (mounted) setState(() {});
  }
}

class RulerBarWidget extends StatelessWidget {
  final RulerBar type;

  int num;

  final int midInterval;
  final int lowerLimit;
  final int upperLimit;
  final int midLimitLower;
  final int midLimitUpper;
  final Color normalBarColor;
  final Color inRangeBarColor;
  final Color outRangeBarColor;
  final Color behindRangeBarColor;
  final Widget indicatorWidget;
  final Axis axis;

  RulerBarWidget(
      {Key key,
      this.num,
      this.type,
      this.indicatorWidget,
      this.lowerLimit,
      this.midLimitLower,
      this.midLimitUpper,
      this.upperLimit,
      this.midInterval,
      this.normalBarColor,
      this.inRangeBarColor,
      this.behindRangeBarColor,
      this.outRangeBarColor,
      this.axis})
      : super(key: key);

  final double _spacing = 5.0;
  List<Widget> _children = List();
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    _getSmallBars();

    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, children: _children));
  }

  /// get color of small bar according to range
  Color _getSmallBarColor() {
    if (_getScalePosition(num) >= _getScalePosition(lowerLimit) &&
        _getScalePosition(num) < _getScalePosition(midLimitLower))
      return behindRangeBarColor;
    else if (_getScalePosition(num) >= _getScalePosition(midLimitLower) &&
        _getScalePosition(num) < _getScalePosition(midLimitUpper))
      return inRangeBarColor;
    else if (_getScalePosition(num) > _getScalePosition(midLimitUpper) &&
        _getScalePosition(num) < _getScalePosition(upperLimit))
      return outRangeBarColor;
    else if (_getScalePosition(num) == _getScalePosition(midLimitUpper) &&
        _getScalePosition(num) < _getScalePosition(upperLimit))
      return outRangeBarColor;
    else if (_getScalePosition(num) == _getScalePosition(midLimitUpper) &&
        _getScalePosition(num) == _getScalePosition(upperLimit))
      return normalBarColor;
    else
      return normalBarColor;
  }

  /// get color of bigger bar according to range
  Color _getBigBarColor() {
    if (_getScalePosition(num) >= _getScalePosition(lowerLimit) &&
        _getScalePosition(num) < _getScalePosition(midLimitLower))
      return normalBarColor;
    else if (_getScalePosition(num) >= _getScalePosition(midLimitLower) &&
        _getScalePosition(num) <= _getScalePosition(midLimitUpper))
      return inRangeBarColor;
    else if (_getScalePosition(num) > _getScalePosition(midLimitUpper) &&
        _getScalePosition(num) <= _getScalePosition(upperLimit))
      return outRangeBarColor;
    else
      return normalBarColor;
  }

  void _getSmallBars() {
    num = num + 1;

    _show = lowerLimit == num ||
        upperLimit == num ||
        midLimitLower == num ||
        midLimitUpper == num;

    _children = List();

    _children.add(Stack(alignment: Alignment.topCenter, children: <Widget>[
      _show
          ? indicatorWidget
          /*Text(
                  num.toString(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )*/
          : Container(),
      Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
              margin: EdgeInsets.all(_spacing),
              color: _getBigBarColor(),
              width: 2,
              height: 20)),
      Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(num.toString(),
              style: TextStyle(
                  fontSize: 14,
                  color: normalBarColor,
                  fontWeight: FontWeight.bold)))
    ]));

    for (int i = 1; i <= midInterval; i++) {
      _children.add(Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Container(
              margin: EdgeInsets.all(_spacing),
              color: _getSmallBarColor(),
              width: 2,
              height: 10)));
    }
  }

  _getScalePosition(int num) {
    return num + (num - 1) * 3;
  }
}

enum RulerBar { BIG_BAR, SMALL_BAR }
