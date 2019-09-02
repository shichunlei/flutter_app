import 'package:flutter/material.dart';

/// 原插件地址：https://github.com/Pyozer/dots_indicator
class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final int position;
  final DotsDecorator decorator;
  final Axis axis;
  final bool reversed;

  DotsIndicator({
    Key key,
    this.position: 0,
    this.axis: Axis.horizontal,
    this.decorator: const DotsDecorator(),
    @required this.dotsCount,
    this.reversed: false,
  })  : assert(dotsCount != null && dotsCount > 0),
        assert(position != null && position >= 0),
        assert(decorator != null),
        assert(
          position < dotsCount,
          "Position must be inferior than dotsCount",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final dotsList = List<Widget>.generate(dotsCount, _buildDot);

    if (axis == Axis.vertical) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: reversed == true ? dotsList.reversed.toList() : dotsList,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: reversed == true ? dotsList.reversed.toList() : dotsList,
    );
  }

  Widget _buildDot(int index) {
    final isCurrent = index == position;
    final size = isCurrent ? decorator.activeSize : decorator.size;

    return Container(
      width: size.width,
      height: size.height,
      margin: decorator.spacing,
      decoration: ShapeDecoration(
        color: isCurrent ? decorator.activeColor : decorator.color,
        shape: isCurrent ? decorator.activeShape : decorator.shape,
      ),
    );
  }
}

const Size kDefaultSize = Size.square(9.0);
const EdgeInsets kDefaultSpacing = EdgeInsets.all(6.0);
const ShapeBorder kDefaultShape = CircleBorder();

class DotsDecorator {
  /// Inactive dot color
  ///
  /// @Default `Colors.grey`
  final Color color;

  /// Active dot color
  ///
  /// @Default `Colors.lightBlue`
  final Color activeColor;

  /// Inactive dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size size;

  /// Active dot size
  ///
  /// @Default `Size.square(9.0)`
  final Size activeSize;

  /// Inactive dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder shape;

  /// Active dot shape
  ///
  /// @Default `CircleBorder()`
  final ShapeBorder activeShape;

  /// Spacing between dots
  ///
  /// @Default `EdgeInsets.all(6.0)`
  final EdgeInsets spacing;

  const DotsDecorator({
    this.color = Colors.grey,
    this.activeColor = Colors.lightBlue,
    this.size = kDefaultSize,
    this.activeSize = kDefaultSize,
    this.shape = kDefaultShape,
    this.activeShape = kDefaultShape,
    this.spacing = kDefaultSpacing,
  })  : assert(color != null),
        assert(activeColor != null),
        assert(size != null),
        assert(activeSize != null),
        assert(shape != null),
        assert(activeShape != null),
        assert(spacing != null);
}
