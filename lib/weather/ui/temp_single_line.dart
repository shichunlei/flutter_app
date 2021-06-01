import 'package:flutter/material.dart';

import '../../page_index.dart';

class TempSingleLine extends StatelessWidget {
  final double width;
  final List<Hourly> tempList;

  TempSingleLine({Key key, this.width, this.tempList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(width, 130), painter: TemperatureSingleLinePainter(tempList));
  }
}

class TemperatureSingleLinePainter extends CustomPainter {
  final List<Hourly> tempList;

  Paint linePaint, dotPaint;

  Gradient gradient;

  TemperatureSingleLinePainter(this.tempList) {
    linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white38
      ..strokeWidth = 1;

    dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    canvas.translate(0, 40);

    double distance = width / tempList.length;

    double maxTemp = -double.infinity;
    double minTemp = double.infinity;
    tempList.forEach((temp) {
      if (temp.tmp > maxTemp) {
        maxTemp = temp.tmp;
      }
      if (temp.tmp < minTemp) {
        minTemp = temp.tmp;
      }
    });
    double centerLine = (maxTemp + minTemp) / 2;
    double cell = 80 / (maxTemp - minTemp) * 4 / 5;

    List<Hourly> drawList = [];
    tempList.forEach((temp) {
      drawList.add(Hourly(tmp: (centerLine - temp.tmp) * cell, time: temp.time));
    });

    // 画线
    drawLine(drawList, distance, canvas, linePaint);

    // 画点和文字
    drawDotText(drawList, distance, canvas, dotPaint);

    drawXLine(drawList, distance, canvas, linePaint, height / 2, width);
  }

  void drawLine(List<Hourly> dots, double distance, Canvas canvas, Paint linePaint) {
    for (int i = 0; i < dots.length - 1; i++) {
      double x = distance * i + distance / 2;

      canvas.drawLine(Offset(x, dots.elementAt(i).tmp), Offset(x + distance, dots.elementAt(i + 1).tmp), linePaint);

      if (i == 0) {
        canvas.drawLine(Offset(0, dots.elementAt(i).tmp), Offset(x, dots.elementAt(i).tmp), linePaint);
      } else if (i == dots.length - 2) {
        canvas.drawLine(Offset(x + distance, dots.elementAt(i + 1).tmp),
            Offset(x + distance + distance / 2, dots.elementAt(i + 1).tmp), linePaint);
      }
    }
  }

  /// 画X轴
  void drawXLine(List<Hourly> dots, double distance, Canvas canvas, Paint linePaint, double y, double width) {
    canvas.drawLine(Offset(0, y), Offset(width, y), linePaint..color = Colors.white);

    for (int i = 0; i < dots.length; i++) {
      double x = distance * i + distance / 2;

      canvas.drawLine(Offset(x, y - 4), Offset(x, y), linePaint..color = Colors.white);

      // 画文字
      TextPainter tpMax = getTextPainter(tempList.elementAt(i).time, fontSize: 14, color: Colors.white);
      tpMax.paint(canvas, Offset(x - tpMax.width / 2, y + 4));
    }
  }

  void drawDotText(List<Hourly> dots, double distance, Canvas canvas, Paint dotPaint) {
    for (int i = 0; i < dots.length; i++) {
      double x = distance * i + distance / 2;

      // 画点
      canvas.drawCircle(Offset(x, dots.elementAt(i).tmp), 2, dotPaint);

      // 画文字
      TextPainter tpMax = getTextPainter('${(tempList.elementAt(i).tmp + 0.5).toInt()}' + '°');
      tpMax.paint(canvas, Offset(x - tpMax.width / 2, dots.elementAt(i).tmp - 15));
    }
  }

  // 画文字
  TextPainter getTextPainter(String text, {double fontSize: 10, Color color: Colors.white54}) {
    return TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: text, style: TextStyle(color: color, fontSize: fontSize)))
      ..layout();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
