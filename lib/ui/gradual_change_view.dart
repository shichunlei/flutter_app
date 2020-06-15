import 'package:flutter/material.dart';

import '../page_index.dart';

/// 渐变色
class GradualChangeView extends StatelessWidget {
  final List<Color> colors;
  final double width;
  final double height;
  final Rotation rotation;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  // 包括三个状态：clamp 为默认方式，自动延伸；repeated 重复效果;mirror 镜面效果，即对称效果
  final TileMode tileMode;
  final List<double> stops;

  GradualChangeView({
    Key key,
    @required this.colors,
    this.width,
    this.height,
    this.stops,
    this.rotation = Rotation.TB,
    this.tileMode = TileMode.clamp,
    this.child,
    this.padding,
    this.alignment,
  })  : assert(tileMode != null),
        assert(rotation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry begin;
    AlignmentGeometry end;

    if (rotation == Rotation.TB) {
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
    } else if (rotation == Rotation.BT) {
      begin = Alignment.bottomCenter;
      end = Alignment.topCenter;
    } else if (rotation == Rotation.LR) {
      begin = Alignment.centerLeft;
      end = Alignment.centerRight;
    } else if (rotation == Rotation.RL) {
      begin = Alignment.centerRight;
      end = Alignment.centerLeft;
    } else if (rotation == Rotation.TL2BR) {
      begin = Alignment.topLeft;
      end = Alignment.bottomRight;
    } else if (rotation == Rotation.TR2BL) {
      begin = Alignment.topRight;
      end = Alignment.bottomLeft;
    } else if (rotation == Rotation.BL2TR) {
      begin = Alignment.bottomLeft;
      end = Alignment.topRight;
    } else if (rotation == Rotation.BR2TL) {
      begin = Alignment.bottomRight;
      end = Alignment.topLeft;
    } else {
      begin = Alignment.topCenter;
      end = Alignment.bottomCenter;
    }

    return Container(
      width: width == null ? double.infinity : width,
      height: height == null ? double.infinity : height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: begin,
            end: end,
            stops: stops,
            tileMode: tileMode),
      ),
      child: child,
      padding: padding ?? EdgeInsets.all(10),
      alignment: alignment,
    );
  }
}
