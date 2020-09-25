import 'package:flutter/material.dart';


/// https://github.com/pedromassango/titled_navigation_bar
class TitledBottomNavigationBar extends StatefulWidget {
  final bool reverse;
  final Curve curve;
  final Color activeColor;
  final Color inactiveColor;
  final Color inactiveStripColor;
  final Color indicatorColor;
  int currentIndex;
  final ValueChanged<int> onTap;
  final List<TitledNavigationBarItem> items;

  TitledBottomNavigationBar({
    Key key,
    this.reverse = false,
    this.curve = Curves.linear,
    @required this.onTap,
    @required this.items,
    this.activeColor,
    this.inactiveColor,
    this.inactiveStripColor,
    this.indicatorColor,
    this.currentIndex = 0,
  })  : assert(items != null),
        assert(items.length >= 2 && items.length <= 5),
        assert(onTap != null),
        assert(currentIndex != null),
        super(key: key);

  @override
  createState() => _TitledBottomNavigationBarState();
}

class _TitledBottomNavigationBarState extends State<TitledBottomNavigationBar> {
  static const double BAR_HEIGHT = 60;
  static const double INDICATOR_HEIGHT = 2;

  bool get reverse => widget.reverse;

  Curve get curve => widget.curve;

  List<TitledNavigationBarItem> get items => widget.items;

  double width = 0;
  Color activeColor;
  Duration duration = Duration(milliseconds: 270);

  double _getIndicatorPosition(int index) =>
      (-1 + (2 / (items.length - 1) * index));

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    activeColor = widget.activeColor ?? Theme.of(context).indicatorColor;

    return Container(
      decoration: BoxDecoration(
        color: widget.inactiveStripColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: BAR_HEIGHT,
          width: width,
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Positioned(
                top: INDICATOR_HEIGHT,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return GestureDetector(
                      onTap: () => _select(index),
                      child:
                          _buildItemWidget(item, index == widget.currentIndex),
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                top: 0,
                width: width,
                child: AnimatedAlign(
                  alignment:
                      Alignment(_getIndicatorPosition(widget.currentIndex), 0),
                  curve: curve,
                  duration: duration,
                  child: Container(
                    color: widget.indicatorColor ?? activeColor,
                    width: width / items.length,
                    height: INDICATOR_HEIGHT,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _select(int index) {
    widget.currentIndex = index;
    widget.onTap(widget.currentIndex);

    setState(() {});
  }

  Widget _buildIcon(TitledNavigationBarItem item) {
    return Icon(
      item.icon,
      color: reverse ? widget.inactiveColor : activeColor,
    );
  }

  Widget _buildText(TitledNavigationBarItem item) {
    return Text(
      item.title,
      style: TextStyle(color: reverse ? activeColor : widget.inactiveColor),
    );
  }

  Widget _buildItemWidget(TitledNavigationBarItem item, bool isSelected) {
    return Container(
      color: item.backgroundColor,
      height: BAR_HEIGHT,
      width: width / items.length,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: duration,
            curve: curve,
            child: reverse ? _buildIcon(item) : _buildText(item),
          ),
          AnimatedAlign(
            duration: duration,
            alignment: isSelected ? Alignment.center : Alignment(0, 5.2),
            child: reverse ? _buildText(item) : _buildIcon(item),
          ),
        ],
      ),
    );
  }
}

class TitledNavigationBarItem {
  final String title;
  final IconData icon;
  final Color backgroundColor;

  TitledNavigationBarItem({
    @required this.icon,
    @required this.title,
    this.backgroundColor = Colors.white,
  });
}
