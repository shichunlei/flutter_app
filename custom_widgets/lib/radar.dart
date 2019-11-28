import 'dart:math';

import 'package:flutter/material.dart';

import 'utils.dart';

class RadarWidget extends StatelessWidget {
  /// 几层多边形
  final int layerNum;
  final Map<String, double> data;
  final PaintingStyle pointStyle;
  final Color layerColor;
  final Color pointColor;

  RadarWidget({
    Key key,
    this.data,
    this.layerNum: 6,
    this.pointStyle: PaintingStyle.fill,
    this.layerColor: const Color(0x3aFF00FF),
    this.pointColor: Colors.white,
  })  : assert(data.length > 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: RadarView(layerNum, data, pointStyle, layerColor, pointColor),
    );
  }
}

class RadarView extends CustomPainter {
  /// 雷达图顶点数
  int sideNum;

  final int layerNum;

  final Map<String, double> data;

  final PaintingStyle pointStyle;

  final Color layerColor;
  final Color pointColor;

  /// view 的中心点
  double viewCenterX;
  double viewCenterY;

  /// 半径，最大的半径
  double maxRadius;

  Paint mPaint;
  Path mPath;

  final double CIRCLE_ANGLE = 360;

  Paint mLayerPaint;

  Paint mPointPaint;

  /// 顶点数是否为奇数个
  bool isOdd;

  RadarView(this.layerNum, this.data, this.pointStyle, this.layerColor,
      this.pointColor)
      : mPaint = Paint()
          ..color = Colors.blueAccent
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..filterQuality = FilterQuality.high
          ..style = PaintingStyle.stroke,
        mLayerPaint = Paint()
          ..color = layerColor
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..filterQuality = FilterQuality.high
          ..style = PaintingStyle.fill,
        mPointPaint = Paint()
          ..color = pointColor
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.0
          ..filterQuality = FilterQuality.high
          ..style = pointStyle,
        mPath = Path(),
        sideNum = data.length,
        isOdd = data.length % 2 == 1;

  @override
  void paint(Canvas canvas, Size size) {
    viewCenterX = size.width / 2;
    viewCenterY = size.height / 2;
    maxRadius = min(size.width / 2, size.height / 2) - 20;
    canvas.save(); // 新建图层
    _drawPolygon(canvas);
    _drawMaskLayer(canvas);
    _drawText(canvas);
    canvas.restore(); // 释放图层
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;

  double eachRadius;
  double eachAngle;

  void _drawPolygon(Canvas canvas) {
    /// 每个角的度数
    eachAngle = CIRCLE_ANGLE / sideNum;

    /// 找好所有的顶点，连接起来即可
    for (int i = 0; i < layerNum; i++) {
      mPath.reset();
      eachRadius = maxRadius / layerNum * (i + 1);

      for (int j = 0; j < sideNum + 1; j++) {
        if (isOdd) {
          if (j == 0) {
            mPath.moveTo(viewCenterX, viewCenterY - eachRadius);
          } else {
            double x = viewCenterX - eachRadius * sin(degToRad(eachAngle * j));
            double y = viewCenterY - eachRadius * cos(degToRad(eachAngle * j));
            mPath.lineTo(x, y);
          }
        } else {
          if (j == 0) {
            mPath.moveTo(viewCenterX + eachRadius * cos(degToRad(eachAngle)),
                viewCenterY + eachRadius * sin(degToRad(eachAngle)));
          } else {
            double x = viewCenterX + eachRadius * cos(degToRad(eachAngle * j));
            double y = viewCenterY + eachRadius * sin(degToRad(eachAngle * j));
            mPath.lineTo(x, y);
          }
        }
      }

      mPath.close();
      canvas.drawPath(mPath, mPaint);
    }
    _drawLineLinkPoint(canvas, eachAngle, eachRadius);
  }

  void _drawLineLinkPoint(Canvas canvas, double eachAngle, double eachRadius) {
    mPath.reset();
    for (int i = 0; i < sideNum; i++) {
      mPath.moveTo(viewCenterX, viewCenterY);
      double x, y;
      if (isOdd) {
        x = viewCenterX - eachRadius * sin(degToRad(eachAngle * i));
        y = viewCenterY - eachRadius * cos(degToRad(eachAngle * i));
      } else {
        x = viewCenterX + eachRadius * cos(degToRad(eachAngle * i));
        y = viewCenterY + eachRadius * sin(degToRad(eachAngle * i));
      }
      mPath.lineTo(x, y);
      mPath.close();
      canvas.drawPath(mPath, mPaint);
    }
  }

  void _drawMaskLayer(Canvas canvas) {
    mPath.reset();

    for (int i = 0; i < sideNum; i++) {
      double value = data.values.toList()[i];
      double x, y;
      if (isOdd) {
        x = viewCenterX - maxRadius * sin(degToRad(eachAngle * i)) * value;
        y = viewCenterY - maxRadius * cos(degToRad(eachAngle * i)) * value;
      } else {
        x = viewCenterX + maxRadius * cos(degToRad(eachAngle * i)) * value;
        y = viewCenterY + maxRadius * sin(degToRad(eachAngle * i)) * value;
      }

      canvas.drawCircle(Offset(x, y), 2.0, mPointPaint);

      if (i == 0) {
        mPath.moveTo(x, y);
      } else {
        mPath.lineTo(x, y);
      }
    }
    mPath.close();
    canvas.drawPath(mPath, mLayerPaint);
  }

  void _drawText(Canvas canvas) {
    for (int i = 0; i < sideNum; i++) {
      double x, y;

      canvas.save();

      if (isOdd) {
        x = viewCenterX - (maxRadius + 10) * sin(degToRad(eachAngle * i));
        y = viewCenterY - (maxRadius + 10) * cos(degToRad(eachAngle * i));
      } else {
        x = viewCenterX + (maxRadius + 10) * cos(degToRad(eachAngle * i));
        y = viewCenterY + (maxRadius + 10) * sin(degToRad(eachAngle * i));
      }

      drawText(canvas, data.keys.toList()[i],
          Offset(x - (data.keys.toList()[i].length * 10.0), y - 8.0),
          fontSize: 12.0);

      canvas.restore();
    }
  }
}
