import 'package:flutter/material.dart';
import 'dart:math' as math;

class BottomBarView extends StatefulWidget {
  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  const BottomBarView(
      {Key key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  @override
  createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  Animation _animation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: <
        Widget>[
      AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Transform(
                transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                child: PhysicalShape(
                  color: Colors.white,
                  elevation: 16.0,
                  clipper: TabClipper(radius: _animation.value * 38.0),
                  child: Container(
                      height: 62,
                      padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList[0],
                                removeAllSelect: () {
                                  setRemoveAllSelection(widget.tabIconsList[0]);
                                  widget.changeIndex(0);
                                })),
                        Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList[1],
                                removeAllSelect: () {
                                  setRemoveAllSelection(widget.tabIconsList[1]);
                                  widget.changeIndex(1);
                                })),
                        SizedBox(width: _animation.value * 64.0),
                        Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList[2],
                                removeAllSelect: () {
                                  setRemoveAllSelection(widget.tabIconsList[2]);
                                  widget.changeIndex(2);
                                })),
                        Expanded(
                            child: TabIcons(
                                tabIconData: widget.tabIconsList[3],
                                removeAllSelect: () {
                                  setRemoveAllSelection(widget.tabIconsList[3]);
                                  widget.changeIndex(3);
                                }))
                      ])),
                ));
          }),
      SizedBox(
          width: 38 * 2.0,
          height: 38 + 62.0,
          child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                  width: 38 * 2.0,
                  height: 38 * 2.0,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScaleTransition(
                          alignment: Alignment.center,
                          scale: _animation,
                          child: Container(
                              // alignment: Alignment.center,s
                              decoration: BoxDecoration(
                                  color: Color(0xFF2633C5),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF2633C5),
                                        Color(0xFF6A88E5)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color:
                                            Color(0xFF2633C5).withOpacity(0.4),
                                        offset: Offset(8.0, 16.0),
                                        blurRadius: 16.0)
                                  ]),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      splashColor:
                                          Colors.white.withOpacity(0.1),
                                      highlightColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      onTap: () => widget.addClick(),
                                      child: Icon(Icons.add,
                                          color: Colors.white, size: 32)))))))))
    ]);
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() => widget.tabIconsList.forEach((tab) {
          tab.isSelected = false;
          if (tabIconData.index == tab.index) tab.isSelected = true;
        }));
  }
}

class TabIcons extends StatefulWidget {
  final TabIconData tabIconData;
  final Function removeAllSelect;

  const TabIcons({Key key, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  @override
  createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  Animation _animation;

  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController.reverse();
        }
      });

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.tabIconData.animationController,
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn)));
    super.initState();
  }

  @override
  void dispose() {
    widget.tabIconData.animationController?.dispose();
    super.dispose();
  }

  void setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Center(
            child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (!widget.tabIconData.isSelected) setAnimation();
                },
                child: IgnorePointer(
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                      ScaleTransition(
                          alignment: Alignment.center,
                          scale: Tween(begin: 0.88, end: 1.0).animate(
                              CurvedAnimation(
                                  parent:
                                      widget.tabIconData.animationController,
                                  curve: Interval(0.1, 1.0,
                                      curve: Curves.fastOutSlowIn))),
                          child: widget.tabIconData.isSelected
                              ? widget.tabIconData.selectedIcon
                              : widget.tabIconData.icon),
                      Positioned(
                          top: 4,
                          left: 6,
                          right: 0,
                          child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: _animation,
                              child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF2633C5),
                                      shape: BoxShape.circle)))),
                      Positioned(
                          top: 0,
                          left: 6,
                          bottom: 8,
                          child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: _animation,
                              child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF2633C5),
                                      shape: BoxShape.circle)))),
                      Positioned(
                          top: 6,
                          right: 8,
                          bottom: 0,
                          child: ScaleTransition(
                              alignment: Alignment.center,
                              scale: _animation,
                              child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF2633C5),
                                      shape: BoxShape.circle))))
                    ])))));
  }
}

class TabClipper extends CustomClipper<Path> {
  final double radius;

  TabClipper({this.radius = 38.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    final v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}

class TabIconData {
  bool isSelected;
  int index;
  AnimationController animationController;

  Widget icon;
  Widget selectedIcon;

  TabIconData({
    this.index: 0,
    this.isSelected: false,
    this.animationController,
    @required this.icon,
    @required this.selectedIcon,
  });
}
