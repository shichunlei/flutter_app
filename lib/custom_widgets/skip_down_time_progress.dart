import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class SkipDownTimeProgress extends StatefulWidget {
  final Color color;
  final double radius;
  final Duration duration;
  final Size size;
  final String skipText;
  final VoidCallback onTap;
  final onFinishCallBack;

  SkipDownTimeProgress(
      {Key key,
      this.color,
      this.radius,
      this.duration,
      this.size,
      this.skipText = "跳过",
      this.onTap,
      this.onFinishCallBack})
      : super(key: key);

  @override
  _SkipDownTimeProgressState createState() {
    return _SkipDownTimeProgressState();
  }
}

class _SkipDownTimeProgressState extends State<SkipDownTimeProgress>
    with TickerProviderStateMixin {
  AnimationController animationController;
  double curAngle = 360.0;

  @override
  void initState() {
    super.initState();
    debugPrint('initState----------------------');
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    animationController.addListener(() {
      debugPrint('ange == ${animationController.value}');
      double ange =
          double.parse(((animationController.value * 360) ~/ 1).toString());
      setState(() {
        curAngle = (360.0 - ange);
        if (curAngle <= 0) {
          widget.onFinishCallBack(true);
        }
      });
    });
    _doAnimation();
  }

  @override
  void didUpdateWidget(SkipDownTimeProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget----------------------');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('dispose----------------------');
    animationController.dispose();
  }

  void _doAnimation() async {
    Future.delayed(Duration(milliseconds: 50), () {
      if (mounted) {
        animationController.forward().orCancel;
      } else {
        _doAnimation();
      }
    });
  }

  void _change() {
    debugPrint('ange == ${animationController.value}');
    double ange =
        double.parse(((animationController.value * 360) ~/ 1).toString());
    setState(() {
      curAngle = (360.0 - ange);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            painter:
                _DrawProgress(widget.color, widget.radius, angle: curAngle),
            size: widget.size,
          ),
          Text(
            widget.skipText,
            style: TextStyle(
                color: widget.color,
                fontSize: 13.5,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}

class _DrawProgress extends CustomPainter {
  final Color color;
  final double radius;
  double angle;
  final AnimationController animation;

  final Paint circleFillPaint;
  final Paint progressPaint;

  _DrawProgress(this.color, this.radius, {this.angle, this.animation})
      : circleFillPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
        progressPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 4.0 {
    if (animation != null && !animation.isAnimating) {
      animation.forward();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 2;
    double y = size.height / 2;

    Offset center = Offset(x, y);
    canvas.drawCircle(center, radius - 2, circleFillPaint);

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    angle = angle * (-1);
    double startAngle = -math.pi / 2;
    double sweepAngle = math.pi * angle / 180;
    debugPrint("draw paint-------------------= $startAngle, $sweepAngle");
    // canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);

    Path path = Path();
    path.arcTo(rect, startAngle, sweepAngle, true);
    canvas.drawPath(path, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
