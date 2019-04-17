import 'package:flutter/material.dart';

class GradualChangeView extends StatelessWidget {
  final List<Color> colors;
  final double width;
  final double height;
  final Rotation rotation;

  GradualChangeView({
    Key key,
    @required this.colors,
    this.width,
    this.height,
    this.rotation = Rotation.TB,
  }) : super(key: key);

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
        ),
      ),
    );
  }
}

enum Rotation { LR, RL, TB, BT, TL2BR, BL2TR, TR2BL, BR2TL }
