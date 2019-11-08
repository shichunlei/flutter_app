import 'package:flutter/material.dart';

class RectIndicator extends StatelessWidget {
  final int position;
  final int count;
  final Color color;
  final Color activeColor;

  RectIndicator({
    Key key,
    this.position,
    this.count,
    this.color: Colors.white,
    this.activeColor: const Color(0xFF3E4750),
  }) : super(key: key);

  _indicator(bool isActive) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 4.0,
        width: 50.0,
        decoration: BoxDecoration(
            color: isActive ? color : activeColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 2.0)
            ],
            borderRadius: BorderRadius.circular(2.0)),
      ),
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
      children: _buildPageIndicators(),
    );
  }
}
