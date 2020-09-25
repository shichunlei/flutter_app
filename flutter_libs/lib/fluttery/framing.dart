/// Tools for framing out user interfaces quickly.
import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Random color generator.
///
/// Use the static method [next] to obtain a random [Color]. Alpha is kept
/// constant at 100% opacity.
class RandomColor {

  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }

}

/// Widget that takes up a given [width] and [height] and paints itself with a
/// random color.
///
/// The random color survives through hot reload because [RandomColorBlock] is
/// a [StatefulWidget].  However, the color will be randomized again after a
/// full reload or a full rebuild.
class RandomColorBlock extends StatefulWidget {

  final double width;
  final double height;
  final Widget child;

  RandomColorBlock({this.width, this.height, this.child});

  @override
  _RandomColorBlockState createState() => new _RandomColorBlockState();
}

class _RandomColorBlockState extends State<RandomColorBlock> {

  /// Random color that persists across hot reload.
  Color randomColor;

  @override
  void initState() {
    super.initState();

    randomColor = RandomColor.next();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: widget.width,
      height: widget.height,
      color: randomColor,
      child: widget.child,
    );
  }
}
