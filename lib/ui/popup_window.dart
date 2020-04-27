import 'package:flutter/material.dart';

class PopupWindow extends StatefulWidget {
  static void showPopWindow(
      {@required BuildContext context,
      @required GlobalKey popKey,
      @required Widget popWidget,
      PopDirection popDirection = PopDirection.bottom,
      double offset = 0.0,
      Color barrierColor}) {
    Navigator.push(
        context,
        PopRoute(
            child: PopupWindow(
                popKey: popKey,
                popDirection: popDirection,
                popWidget: popWidget,
                offset: offset),
            cusBarrierColor: barrierColor));
  }

  final GlobalKey popKey;
  final PopDirection popDirection;
  final Widget popWidget; // 自定义widget
  final double offset; // popupWindow偏移量

  const PopupWindow({
    Key key,
    @required this.popKey,
    @required this.popWidget,
    this.offset,
    this.popDirection: PopDirection.bottom,
  }) : super(key: key);

  @override
  createState() => _PopupWindowState();
}

class _PopupWindowState extends State<PopupWindow> {
  GlobalKey globalKey;
  double left = -100;
  double top = -100;

  @override
  void initState() {
    super.initState();

    globalKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = widget.popKey.currentContext.findRenderObject();
      Offset localToGlobal =
          renderBox.localToGlobal(Offset.zero); // targetWidget的坐标位置
      Size size = renderBox.size; // targetWidget的size

      RenderBox _box = globalKey.currentContext.findRenderObject();
      var widgetSize = _box.size; // button的size
      switch (widget.popDirection) {
        case PopDirection.left:
          left = localToGlobal.dx - widgetSize.width - widget.offset;
          top = localToGlobal.dy + size.height / 2 - widgetSize.height / 2;
          break;
        case PopDirection.top:
          left = localToGlobal.dx + size.width / 2 - widgetSize.width / 2;
          top = localToGlobal.dy - widgetSize.height - widget.offset;
          fixPosition(widgetSize);
          break;
        case PopDirection.right:
          left = localToGlobal.dx + size.width + widget.offset;
          top = localToGlobal.dy + size.height / 2 - widgetSize.height / 2;
          break;
        case PopDirection.bottom:
          left = localToGlobal.dx + size.width / 2 - widgetSize.width / 2;
          top = localToGlobal.dy + size.height + widget.offset;
          fixPosition(widgetSize);
          break;
      }
      setState(() {});
    });
  }

  void fixPosition(Size buttonSize) {
    if (left < 0) {
      left = 0;
    }
    if (left + buttonSize.width >= MediaQuery.of(context).size.width) {
      left = MediaQuery.of(context).size.width - buttonSize.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: GestureDetector(
            child: Stack(children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent),
              Positioned(
                  child: GestureDetector(
                      child: _buildCustomWidget(widget.popWidget)),
                  left: left,
                  top: top)
            ]),
            onTap: () {
              Navigator.maybePop(context);
            }));
  }

  Widget _buildCustomWidget(Widget child) =>
      Container(key: globalKey, child: child);
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  final Widget child;
  final Color cusBarrierColor;

  PopRoute({@required this.child, this.cusBarrierColor});

  /// 弹出蒙层的颜色，null则为透明
  @override
  Color get barrierColor => cusBarrierColor;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      child;

  @override
  Duration get transitionDuration => _duration;
}

/// popup_window的方向
enum PopDirection { left, right, top, bottom }
