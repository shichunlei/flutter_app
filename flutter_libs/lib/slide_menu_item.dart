import 'dart:ui' as ui show window;

import 'package:flutter/material.dart';

class SlideMenuItem extends StatefulWidget {
  /// 每个操作按钮的宽度
  final double itemWidth;

  /// 高度
  final double itemHeight;

  /// 操作按钮
  final List<ActionsWidget> actions;

  /// key
  final GlobalKey<SlideMenuItemState> key;

  final VoidCallback onSlideStarted;

  /// item点击事件
  final VoidCallback onTap;

  /// 默认背景色
  final Color bgColor;

  /// 打开时的背景色
  final Color openBgColor;

  /// 子控件
  final Widget child;

  SlideMenuItem({
    @required this.key,
    this.itemWidth: 80.0,
    this.itemHeight: 90.0,
    this.actions,
    this.onSlideStarted,
    this.onTap,
    this.bgColor: Colors.white,
    this.openBgColor = Colors.white,
    @required this.child,
  }) : super(key: key);

  @override
  createState() => SlideMenuItemState();
}

class SlideMenuItemState extends State<SlideMenuItem>
    with TickerProviderStateMixin {
  ScrollController controller;

  double offset = 0.0;

  double maxActionWidth;

  double screenWidth;

  /// 手指按下时的X坐标
  double dxDown;

  /// 手指抬起时的X坐标
  double dxUp;

  @override
  void initState() {
    super.initState();

    screenWidth = MediaQueryData.fromWindow(ui.window).size.width;

    maxActionWidth = widget.actions.length * widget.itemWidth;

    controller = ScrollController()
      ..addListener(() {
        offset = controller.offset;

        /// 防止滑动溢出
        if (offset >= screenWidth) {
          offset = screenWidth;
        }

        print('======================>$offset');
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (offset != 0) {
            close();
            return false;
          }
          return true;
        },
        child: GestureDetector(
            onTap: () {
              if (offset > 0) {
                close();
              } else {
                if (widget.onTap != null) widget.onTap.call();
              }
            },
            onHorizontalDragDown: (DragDownDetails details) {
              if (widget.onSlideStarted != null) widget.onSlideStarted.call();
            },
            child: Container(
                height: widget.itemHeight,
                child: Stack(children: <Widget>[
                  Positioned.fill(
                      child: Row(
                          children: widget.actions
                              .map((action) => buildActionButton(action.icon,
                                  action.color, action.onTap, action.child))
                              .toList(),
                          mainAxisAlignment: MainAxisAlignment.end)),
                  Listener(
                    onPointerUp: (PointerUpEvent event) {
                      dxUp = event.position.dx;

                      if (dxUp - dxDown > 0) {
                        close();
                      } else {
                        if (offset > maxActionWidth / 4 &&
                            offset < maxActionWidth) open();

                        if (offset <= maxActionWidth / 4) close();
                      }
                    },
                    onPointerDown: (PointerDownEvent event) {
                      dxDown = event.position.dx;
                    },
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(children: <Widget>[
                          Container(
                              width: screenWidth,
                              child: widget.child,
                              color:
                                  offset >= maxActionWidth && maxActionWidth > 0
                                      ? widget.openBgColor
                                      : widget.bgColor,
                              height: double.infinity,
                              alignment: Alignment.centerLeft),
                          Opacity(
                              opacity: offset == maxActionWidth ? 1.0 : .0,
                              child: Container(
                                  width: offset > 0
                                      ? offset >= maxActionWidth
                                          ? maxActionWidth
                                          : offset
                                      : .1,
                                  child: Row(
                                      children: widget.actions
                                          .map((action) => buildActionButton(
                                              action.icon,
                                              action.color,
                                              action.onTap,
                                              action.child))
                                          .toList(),
                                      mainAxisSize: MainAxisSize.min)))
                        ])),
                  )
                ]))));
  }

  Widget buildActionButton(
      Widget icon, Color color, Function onTap, Widget child) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          close();
          onTap();
        },
        child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Center(
                    child: child ??
                        Container(
                            child: icon,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)))),
                scrollDirection: Axis.horizontal),
            color: color == null
                ? offset >= maxActionWidth && maxActionWidth > 0
                    ? widget.openBgColor
                    : widget.bgColor
                : color,
            width: offset > 0 ? offset / widget.actions.length : .1));
  }

  void close() {
    if (offset != 0)
      controller.animateTo(.0,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  void open() {
    if (offset != maxActionWidth)
      controller.animateTo(maxActionWidth,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
  }
}

class ActionsWidget {
  Widget icon;
  Color color;
  VoidCallback onTap;
  Widget child;

  ActionsWidget({this.icon, this.color, this.onTap, this.child});
}
