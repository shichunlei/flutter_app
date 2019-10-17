import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final double size;
  final EdgeInsetsGeometry padding;
  final void Function() onPressedAction;
  final double elevation;
  final double highlightElevation;
  final Color fillColor;
  final Color splashColor;
  final Color highlightColor;
  final Color iconColor;

  const CircleButton(
      {Key key,
      this.icon,
      this.onPressedAction,
      this.iconSize: 30,
      this.size: 50,
      this.padding = const EdgeInsets.all(0.0),
      this.fillColor: Colors.white,
      this.splashColor,
      this.highlightColor,
      this.elevation,
      this.highlightElevation,
      this.iconColor: Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: size,
        height: size,
        child: RawMaterialButton(
          fillColor: fillColor,
          splashColor: splashColor,
          highlightColor: highlightColor,
          elevation: elevation,
          highlightElevation: highlightElevation,
          onPressed: onPressedAction,
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
