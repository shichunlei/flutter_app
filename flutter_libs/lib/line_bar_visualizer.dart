import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

class LineBarVisualizer extends CustomPainter {
  final List<int> waveData;
  final double height;
  final double width;
  final Color color;
  final Color progressColor;
  final Paint wavePaint;
  final Paint progressPaint;

  final int density;
  final int gap;
  List<double> points;
  final double progressValue;

  LineBarVisualizer(
      {@required this.waveData,
      @required this.height,
      @required this.width,
      @required this.color,
      this.progressValue = 0.0,
      @required this.progressColor,
      this.density = 50,
      this.gap = 2})
      : wavePaint = new Paint()
          ..color = color.withOpacity(1.0)
          ..style = PaintingStyle.fill,
        progressPaint = new Paint()
          ..color = progressColor
          ..style = PaintingStyle.fill,
        assert(waveData != null),
        assert(height != null),
        assert(width != null),
        assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    if (waveData != null) {
      double barWidth = width / density;
      double div = waveData.length / density;
      wavePaint.strokeWidth = barWidth - gap;
      progressPaint.strokeWidth = barWidth - gap;
      for (int i = 0; i < density; i++) {
        int bytePosition = (i * div).ceil();
        double bottom = height / 2 * scaleData(waveData[bytePosition]);
        double top = -(height / 2 * scaleData(waveData[bytePosition]));
        double barX = (i * barWidth) + (barWidth / 2);
        canvas.drawLine(Offset(barX, 0), Offset(barX, top), wavePaint);
        canvas.drawLine(Offset(barX, bottom), Offset(barX, 0), wavePaint);
        if (barX <= width * progressValue) {
          canvas.drawLine(Offset(barX, 0), Offset(barX, top), progressPaint);
          canvas.drawLine(Offset(barX, bottom), Offset(barX, 0), progressPaint);
        }
      }
    }
  }

  scaleData(int data) {
    double res;
    final max = pow(2, 9 - 1).toDouble();
    res = data.toDouble() / max;
    if (res >= 1.0) {
      res = 1.0;
    }
    if (res == 0.0) {
      res = 0.2;
    }
    return res;
  }

  @override
  bool shouldRepaint(LineBarVisualizer oldDelegate) {
    if (oldDelegate.waveData != waveData ||
        oldDelegate.progressValue != progressValue) {
      return true;
    }
    return false;
  }
}
