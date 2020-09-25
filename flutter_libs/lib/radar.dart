import 'dart:math';

import 'package:flutter/material.dart';

import 'utils.dart';

enum SideStyle { polygon, circle }

class RadarWidget extends StatefulWidget {
  /// 几层多边形
  final int layerNum;
  final Map<String, double> data;
  final List<Color> pointColors;
  final PaintingStyle pointStyle;
  final Color layerColor;
  final double fallbackHeight;
  final double fallbackWidth;
  final SideStyle sideStyle;
  final double maxValue;

  RadarWidget({
    Key key,
    @required this.data,
    this.layerNum: 6,
    this.pointStyle: PaintingStyle.fill,
    this.layerColor: const Color(0x3aFF00FF),
    @required this.pointColors,
    this.fallbackHeight: 200,
    this.fallbackWidth: 200,
    this.sideStyle: SideStyle.polygon,
    @required this.maxValue,
  })  : assert(data.length > 2),
        assert(data.length == pointColors.length,
            'Length of data and color lists must be equal'),
        super(key: key);

  @override
  createState() => _RadarWidgetState();
}

class _RadarWidgetState extends State<RadarWidget>
    with SingleTickerProviderStateMixin {
  double fraction = 0.0;
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      parent: animationController,
    ))
      ..addListener(() {
        setState(() {
          fraction = animation.value;
        });
      });

    animationController.forward();
  }

  @override
  void didUpdateWidget(RadarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    animationController.reset();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: widget.fallbackWidth,
      maxHeight: widget.fallbackHeight,
      child: CustomPaint(
        size: Size.infinite,
        painter: RadarViewPainter(
          widget.layerNum,
          widget.data,
          widget.pointStyle,
          widget.layerColor,
          widget.pointColors,
          widget.sideStyle,
          widget.maxValue,
          this.fraction,
        ),
      ),
    );
  }
}

class RadarViewPainter extends CustomPainter {
  /// 雷达图顶点数
  int sideNum;

  final int layerNum;

  final Map<String, double> data;
  final double maxValue;

  final PaintingStyle pointStyle;

  final Color layerColor;
  final List<Color> pointColors;

  /// 边的样式：圆形或正多边形
  final SideStyle sideStyle;

  final double fraction;

  /// view 的中心点
  double viewCenterX;
  double viewCenterY;

  /// 半径，最大的半径
  double maxRadius;

  Paint mPaint;
  Path mPath;

  static const double CIRCLE_ANGLE = 360;

  Paint mLayerPaint;

  Paint mPointPaint;

  /// 顶点数是否为奇数个
  bool isOdd;

  RadarViewPainter(this.layerNum, this.data, this.pointStyle, this.layerColor,
      this.pointColors, this.sideStyle, this.maxValue, this.fraction)
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
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..filterQuality = FilterQuality.high
          ..style = pointStyle,
        mPath = Path(),
        sideNum = data.length,
        isOdd = data.length.isOdd;

  @override
  void paint(Canvas canvas, Size size) {
    viewCenterX = size.width / 2;
    viewCenterY = size.height / 2;
    maxRadius = min(size.width / 2, size.height / 2) - 20;
    canvas.save(); // 新建图层
    if (sideStyle == SideStyle.circle) {
      _drawCircle(canvas);
    } else {
      _drawPolygon(canvas);
    }
    _drawMaskLayer(canvas);
    _drawText(canvas);
    canvas.restore(); // 释放图层
  }

  double eachRadius;
  double eachAngle;

  void _drawCircle(Canvas canvas) {
    /// 每个角的度数
    eachAngle = CIRCLE_ANGLE / sideNum;

    /// 找好所有的顶点，连接起来即可
    for (int i = 0; i < layerNum; i++) {
      eachRadius = maxRadius / layerNum * (i + 1);

      if (i == layerNum - 1) {
        canvas.drawCircle(Offset(viewCenterX, viewCenterY), eachRadius,
            mPaint..strokeWidth = 2.0);
      } else {
        canvas.drawCircle(Offset(viewCenterX, viewCenterY), eachRadius,
            mPaint..strokeWidth = 1.0);
      }
    }
    _drawLineLinkPoint(canvas, eachAngle, eachRadius);
  }

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
      if (i == layerNum - 1) {
        canvas.drawPath(mPath, mPaint..strokeWidth = 2.0);
      } else {
        canvas.drawPath(mPath, mPaint..strokeWidth = 1.0);
      }
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
      canvas.drawPath(mPath, mPaint..strokeWidth = 1.0);
    }
  }

  void _drawMaskLayer(Canvas canvas) {
    mPath.reset();

    for (int i = 0; i < sideNum; i++) {
      double value = data.values.toList()[i];
      double x, y;
      if (isOdd) {
        x = viewCenterX -
            maxRadius *
                sin(degToRad(eachAngle * i)) *
                value /
                maxValue *
                fraction;
        y = viewCenterY -
            maxRadius *
                cos(degToRad(eachAngle * i)) *
                value /
                maxValue *
                fraction;
      } else {
        x = viewCenterX +
            maxRadius *
                cos(degToRad(eachAngle * i)) *
                value /
                maxValue *
                fraction;
        y = viewCenterY +
            maxRadius *
                sin(degToRad(eachAngle * i)) *
                value /
                maxValue *
                fraction;
      }

      canvas.drawCircle(Offset(x, y), 2.0, mPointPaint..color = pointColors[i]);

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

  @override
  bool shouldRepaint(RadarViewPainter oldDelegate) =>
      oldDelegate.fraction != fraction;
}
