import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

const double _kActiveFontSize = 14.0;
const double _kBottomMargin = 8.0;
enum BubbleBottomBarFabLocation { end, center }

// https://github.com/westdabestdb/bubble_bottom_bar
class BubbleBottomBar extends StatefulWidget {
  BubbleBottomBar(
      {Key key,
      @required this.items,
      this.onTap,
      this.currentIndex = 0,
      @required this.opacity,
      this.iconSize = 24.0,
      this.borderRadius,
      this.elevation,
      this.backgroundColor,
      this.hasNotch = false,
      this.fabLocation})
      : assert(items != null),
        assert(items.length >= 2),
        assert(
            items.every((BubbleBottomBarItem item) => item.title != null) ==
                true,
            'Every item must have a non-null title',),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(iconSize != null),
        super(key: key);

  final List<BubbleBottomBarItem> items;
  final ValueChanged<int> onTap; //stream ? or listener ? callbacks dude
  int currentIndex;
  final double iconSize;
  final double opacity;
  final BorderRadius borderRadius;
  final double elevation;
  final Color backgroundColor;
  final bool hasNotch;
  final BubbleBottomBarFabLocation fabLocation;

  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.item,
    this.opacity,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.flex,
    this.selected = false,
    this.indexLabel,
  }) : assert(selected != null);

  final BubbleBottomBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback onTap;
  final ColorTween colorTween;
  final double flex;
  final bool selected;
  final String indexLabel;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    int size;
    Widget label;
    size = (flex * 1000.0).round();
    label = _Label(
      animation: animation,
      item: item,
      color: item.backgroundColor,
    );

    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        header: true,
        selected: selected,
        child: Stack(
          children: <Widget>[
            InkResponse(
              onTap: onTap,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    color: selected
                        ? item.backgroundColor.withOpacity(opacity)
                        : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(50),
                      left: Radius.circular(50),
                    )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: selected
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _TileIcon(
                      colorTween: colorTween,
                      animation: animation,
                      iconSize: iconSize,
                      selected: selected,
                      item: item,
                    ),
                    AnimatedCrossFade(
                      alignment: Alignment(0, 0),
                      firstChild: label,
                      secondChild: Container(),
                      duration: Duration(milliseconds: 200),
                      sizeCurve: Curves.fastOutSlowIn,
                      firstCurve: Curves.fastOutSlowIn,
                      secondCurve: Curves.fastOutSlowIn.flipped,
                      crossFadeState: selected
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                    )
                  ],
                ),
              ),
            ),
            Semantics(
              label: indexLabel,
            )
          ],
        ),
      ),
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    Key key,
    @required this.colorTween,
    @required this.animation,
    @required this.iconSize,
    @required this.selected,
    @required this.item,
  }) : super(key: key);

  final ColorTween colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final BubbleBottomBarItem item;

  @override
  Widget build(BuildContext context) {
    Color iconColor;
    iconColor = Colors.white;
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: Container(
        child: IconTheme(
          data: IconThemeData(
            color: selected ? item.backgroundColor : iconColor,
            size: iconSize,
          ),
          child: selected ? item.activeIcon : item.icon,
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  _Label({
    Key key,
    @required this.animation,
    @required this.item,
    @required this.color,
  }) : super(key: key);

  final Animation<double> animation;
  final BubbleBottomBarItem item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      heightFactor: 1.0,
      child: Container(
        child: FadeTransition(
          alwaysIncludeSemantics: true,
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: _kActiveFontSize,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            child: item.title,
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBarState extends State<BubbleBottomBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations;
  Color _backgroundColor;
  ValueListenable<ScaffoldGeometry> geometryListenable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  static final Animatable<double> _flexTween =
      Tween<double>(begin: .75, end: 2.25);

  void _resetState() {
    for (AnimationController controller in _controllers) controller.dispose();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) controller.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  @override
  void didUpdateWidget(BubbleBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();

      if (widget.fabLocation == BubbleBottomBarFabLocation.center) {
        BubbleBottomBarItem _currentItem = widget.items[oldWidget.currentIndex];
        BubbleBottomBarItem _nextItem = widget.items[widget.currentIndex];

        widget.items[0] = _nextItem;
        widget.items[widget.currentIndex] = _currentItem;
        _controllers[oldWidget.currentIndex].reverse();
        _controllers[widget.currentIndex].forward();
        widget.currentIndex = 0;
        _resetState();
      }
    } else {
      if (_backgroundColor != widget.items[widget.currentIndex].backgroundColor)
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
    }
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    assert(localizations != null);
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < widget.items.length; i += 1) {
      children.add(
        _BottomNavigationTile(
          widget.items[i],
          widget.opacity,
          _animations[i],
          widget.iconSize,
          onTap: () {
            if (widget.onTap != null) widget.onTap(i);
          },
          flex: _evaluateFlex(_animations[i]),
          selected: i == widget.currentIndex,
          indexLabel: localizations.tabLabel(
              tabIndex: i + 1, tabCount: widget.items.length),
        ),
      );
    }
    if (widget.fabLocation == BubbleBottomBarFabLocation.center) {
      children.insert(
          1,
          Spacer(
            flex: 1500,
          ));
    }
    return children;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  Widget _inner(double additionalBottomPadding) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: additionalBottomPadding,
                right: widget.fabLocation == BubbleBottomBarFabLocation.end
//                    MediaQuery.of(context).size.width * 2 / 3 < _fabCenter
                    ? 72
                    : 0),
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: _createContainer(_createTiles()),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom - _kBottomMargin, 0.0);
    return Semantics(
        explicitChildNodes: true,
        child: widget.hasNotch
            ? PhysicalShape(
                elevation: widget.elevation != null ? widget.elevation : 8.0,
                color: widget.backgroundColor != null
                    ? widget.backgroundColor
                    : Colors.white,
                clipper: _BubbleBottomBarClipper(
                  shape: CircularNotchedRectangle(),
                  geometry: geometryListenable,
                  notchMargin: 8,
                ),
                child: _inner(additionalBottomPadding),
              )
            : Material(
                elevation: widget.elevation != null ? widget.elevation : 8.0,
                color: widget.backgroundColor != null
                    ? widget.backgroundColor
                    : Colors.white,
                child: _inner(additionalBottomPadding),
                borderRadius: widget.borderRadius != null
                    ? widget.borderRadius
                    : BorderRadius.zero,
              ));
  }
}

class BubbleBottomBarItem {
  const BubbleBottomBarItem({
    @required this.icon,
    this.title,
    Widget activeIcon,
    this.backgroundColor,
  })  : activeIcon = activeIcon ?? icon,
        assert(icon != null);
  final Widget icon;
  final Widget activeIcon;
  final Widget title;
  final Color backgroundColor;
}

class _BubbleBottomBarClipper extends CustomClipper<Path> {
  const _BubbleBottomBarClipper({
    @required this.geometry,
    @required this.shape,
    @required this.notchMargin,
  })  : assert(geometry != null),
        assert(shape != null),
        assert(notchMargin != null),
        super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    final Rect button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop * -1.0,
    );

    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BubbleBottomBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}
