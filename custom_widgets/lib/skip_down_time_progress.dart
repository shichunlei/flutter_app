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
      this.size: const Size(25.0, 25.0),
      this.skipText = "跳过",
      this.onTap,
      this.onFinishCallBack})
      : super(key: key);

  @override
  createState() => _SkipDownTimeProgressState();
}

class _SkipDownTimeProgressState extends State<SkipDownTimeProgress>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    debugPrint('initState----------------------');
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween(begin: 360.0, end: 0.0).animate(_controller)
      ..addListener(() {
        debugPrint('ange == ${_controller.value}');
        if (mounted) setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          widget.onFinishCallBack(true);
        }
      });

    _controller.forward().orCancel;
  }

  @override
  void didUpdateWidget(SkipDownTimeProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget----------------------');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    debugPrint('dispose----------------------');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomPaint(
        painter:
            _DrawProgress(widget.color, widget.radius, angle: _animation.value),
        size: widget.size,
        child: Center(
          child: Text(
            widget.skipText,
            style: TextStyle(
                color: widget.color,
                fontSize: 13.5,
                decoration: TextDecoration.none),
          ),
        ),
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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
