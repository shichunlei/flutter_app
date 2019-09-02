import 'package:flutter/material.dart';

import '../utils.dart';

class CirclePainter extends CustomPainter {
  Paint circlePaint = Paint();
  Paint maskPaint = Paint();

  final double outerCircleRadiusProgress;
  final double innerCircleRadiusProgress;
  final Color startColor;
  final Color endColor;

  CirclePainter({
    @required this.outerCircleRadiusProgress,
    @required this.innerCircleRadiusProgress,
    this.startColor = const Color(0xFFFF5722),
    this.endColor = const Color(0xFFFFC107),
  }) {
    circlePaint..style = PaintingStyle.fill;
    maskPaint..blendMode = BlendMode.clear;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double center = size.width * 0.5;
    _updateCircleColor();
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawCircle(Offset(center, center),
        outerCircleRadiusProgress * center, circlePaint);
    canvas.drawCircle(Offset(center, center),
        innerCircleRadiusProgress * center + 1, maskPaint);
    canvas.restore();
  }

  void _updateCircleColor() {
    double colorProgress = clamp(outerCircleRadiusProgress, 0.5, 1.0);
    colorProgress = mapValueFromRangeToRange(colorProgress, 0.5, 1.0, 0.0, 1.0);
    circlePaint..color = Color.lerp(startColor, endColor, colorProgress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
