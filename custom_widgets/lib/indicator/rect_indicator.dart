import 'package:flutter/material.dart';

class RectIndicator extends StatelessWidget {
  final int position;
  final int count;
  final Color color;
  final Color activeColor;
  final double width;
  final double activeWidth;
  final double height;

  RectIndicator({
    Key key,
    this.width: 50.0,
    this.activeWidth: 50.0,
    this.height: 4,
    @required this.position,
    @required this.count,
    this.color: Colors.white,
    this.activeColor: const Color(0xFF3E4750),
  })  : assert(count != null && position != null),
        super(key: key);

  _indicator(bool isActive) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: height,
      width: isActive ? activeWidth : width,
      decoration: BoxDecoration(
          color: isActive ? color : activeColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 2.0),
                blurRadius: 2.0)
          ],
          borderRadius: BorderRadius.circular(height / 2.0)),
      duration: Duration(milliseconds: 150),
    );
  }

  _buildPageIndicators() {
    List<Widget> indicatorList = [];
    for (int i = 0; i < count; i++) {
      indicatorList.add(i == position ? _indicator(true) : _indicator(false));
    }
    return indicatorList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicators(),
    );
  }
}
