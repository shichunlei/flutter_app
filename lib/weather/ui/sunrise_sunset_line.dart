import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';

/// 日出日落
class SunriseSunsetLine extends StatelessWidget {
  final SunriseSunset sunriseSunset;

  SunriseSunsetLine(this.sunriseSunset);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(0, 80), painter: SunriseSunsetPainter(sunriseSunset));
  }
}

class SunriseSunsetPainter extends CustomPainter {
  final SunriseSunset sunriseSunset;

  final padding = 2;

  Paint timeLinePaint, dotPaint;

  SunriseSunsetPainter(this.sunriseSunset) {
    timeLinePaint = new Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.white38
      ..strokeWidth = 1.5;
    dotPaint = new Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double width = size.width;
    double height = size.height;

    canvas.drawLine(
        Offset(0, height / 2), Offset(width, height / 2), timeLinePaint);

    // ----------------------------    日出    ----------------------------
    DateTime sunriseTime =
        DateTime.parse(sunriseSunset.date + ' ' + sunriseSunset.sr);
    double sunriseOfDay = ((sunriseTime.hour * 60 + sunriseTime.minute) * 60 +
            sunriseTime.second) /
        (24 * 60 * 60);
    canvas.drawCircle(Offset(width * sunriseOfDay, height / 2), 2, dotPaint);
    TextPainter sunriseDescTp = getTextPainter('日出');
    sunriseDescTp.paint(
        canvas,
        Offset(width * sunriseOfDay - sunriseDescTp.width / 2,
            height / 2 - sunriseDescTp.height - padding));
    TextPainter sunriseTimeTp = getTextPainter('${sunriseSunset.sr}');
    sunriseTimeTp.paint(
        canvas,
        Offset(width * sunriseOfDay - sunriseTimeTp.width / 2,
            height / 2 + padding));

    // ----------------------------    日落    ----------------------------
    DateTime sunsetTime =
        DateTime.parse(sunriseSunset.date + ' ' + sunriseSunset.ss);
    double sunsetOfDay =
        ((sunsetTime.hour * 60 + sunsetTime.minute) * 60 + sunsetTime.second) /
            (24 * 60 * 60);
    canvas.drawCircle(Offset(width * sunsetOfDay, height / 2), 2, dotPaint);
    TextPainter sunsetDescTp = getTextPainter('日落');
    sunsetDescTp.paint(
        canvas,
        Offset(width * sunsetOfDay - sunsetDescTp.width / 2,
            height / 2 - sunsetDescTp.height - padding));
    TextPainter sunsetTp = getTextPainter('${sunriseSunset.ss}');
    sunsetTp.paint(canvas,
        Offset(width * sunsetOfDay - sunsetTp.width / 2, height / 2 + padding));

    // ----------------------------    当前    ----------------------------
    DateTime currentTime = DateTime.now();
    double currentOfDay = ((currentTime.hour * 60 + currentTime.minute) * 60 +
            currentTime.second) /
        (24 * 60 * 60);
    canvas.drawCircle(Offset(width * currentOfDay, height / 2), 2, dotPaint);
    TextPainter currentDescTp = getTextPainter('当前');
    currentDescTp.paint(
        canvas,
        Offset(width * currentOfDay - currentDescTp.width / 2,
            height / 2 - currentDescTp.height - padding));
    TextPainter currentTp =
        getTextPainter(' ${currentTime.hour}:${currentTime.minute}');
    currentTp.paint(
        canvas,
        Offset(
            width * currentOfDay - currentTp.width / 2, height / 2 + padding));
  }

  // 画文字
  TextPainter getTextPainter(String text) {
    return TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 10,
        ),
      ),
    )..layout();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
