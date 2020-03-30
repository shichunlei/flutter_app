import 'package:flutter/material.dart';

import '../page_index.dart';

class LeftMenu extends StatelessWidget {
  final double offsetX;

  LeftMenu({Key key, this.offsetX}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = Utils.width;

    return Transform.scale(
      scale: 0.88 + 0.12 * offsetX / screenWidth < 0.88
          ? 0.88
          : 0.88 + 0.12 * offsetX / screenWidth,
      child: Container(
        child: Image.asset(
          "images/left.png",
          fit: BoxFit.fill,
        ),
        // 前景色可以用foregroundDecoration通过改变Color的透明度来达到效果
        foregroundDecoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1 - (offsetX / screenWidth)),
        ),
      ),
    );
  }
}
