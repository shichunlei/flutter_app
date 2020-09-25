import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.data, {
    @required this.gradient,
    this.style,
    this.textAlign = TextAlign.left,
  });

  final String data;
  final Gradient gradient;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) =>
          gradient.createShader(Offset.zero & bounds.size),
      blendMode: BlendMode.srcIn,
      child: Text(
        data,
        textAlign: textAlign,
        style: (style == null)
            ? TextStyle(color: Colors.white)
            : style.copyWith(color: Colors.white),
      ),
    );
  }
}
