import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

num degToRad(num deg) => deg * (math.pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / math.pi);

double mapValueFromRangeToRange(double value, double fromLow, double fromHigh,
        double toLow, double toHigh) =>
    toLow + ((value - fromLow) / (fromHigh - fromLow) * (toHigh - toLow));

double clamp(double value, double low, double high) =>
    math.min(math.max(value, low), high);

/// 绘制文字
drawText(Canvas canvas, String text, Offset offset,
    {Color color = Colors.black,
    double width = 40,
    double fontSize,
    String fontFamily,
    TextAlign textAlign = TextAlign.center,
    FontWeight fontWeight = FontWeight.bold}) {
  /// 新建一个段落建造器，然后将文字基本信息填入;
  var paragraphBuilder = ui.ParagraphBuilder(
    ui.ParagraphStyle(
      fontFamily: fontFamily,
      textAlign: textAlign,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
  paragraphBuilder
    ..pushStyle(
        ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic))
    ..addText(text);

  /// 这里需要先layout,将宽度约束填入，否则无法绘制
  var paragraph = paragraphBuilder.build()..layout(

      /// 设置文本的宽度约束
      ui.ParagraphConstraints(width: width));
  canvas.drawParagraph(paragraph, Offset(offset.dx, offset.dy));
}
