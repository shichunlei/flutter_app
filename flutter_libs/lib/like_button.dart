import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'utils.dart';

typedef LikeCallback = void Function(bool isLike);

class LikeButton extends StatefulWidget {
  final double size;
  final LikeIcon icon;
  final Duration duration;
  final DotColor dotColor;
  final Color circleStartColor;
  final Color circleEndColor;
  final LikeCallback onClicked;
  final bool isLiked;
  final Color normalColor;

  const LikeButton({
    Key key,
    @required this.size,
    this.icon = const LikeIcon(
      Icons.favorite,
      iconColor: Colors.pinkAccent,
    ),
    this.duration = const Duration(milliseconds: 1000),
    this.dotColor = const DotColor(
      dotPrimaryColor: const Color(0xFFFFC107),
      dotSecondaryColor: const Color(0xFFFF9800),
      dotThirdColor: const Color(0xFFFF5722),
      dotLastColor: const Color(0xFFF44336),
    ),
    this.circleStartColor = const Color(0xFFFF5722),
    this.circleEndColor = const Color(0xFFFFC107),
    this.onClicked,
    this.isLiked: false,
    this.normalColor: Colors.grey,
  }) : super(key: key);

  @override
  createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> outerCircle;
  Animation<double> innerCircle;
  Animation<double> scale;
  Animation<double> dots;

  bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.isLiked;

    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        setState(() {});
      });
    _initAllAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        CustomPaint(
          size: Size(widget.size, widget.size),
          painter: DotPainter(
            currentProgress: dots.value,
            color1: widget.dotColor.dotPrimaryColor,
            color2: widget.dotColor.dotSecondaryColor,
            color3: widget.dotColor.dotThirdColorReal,
            color4: widget.dotColor.dotLastColorReal,
          ),
        ),
        CustomPaint(
          size: Size(widget.size * 0.35, widget.size * 0.35),
          painter: CirclePainter(
              innerCircleRadiusProgress: innerCircle.value,
              outerCircleRadiusProgress: outerCircle.value,
              startColor: widget.circleStartColor,
              endColor: widget.circleEndColor),
        ),
        Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: _isLiked ? scale.value : 1.0,
            child: IconButton(
              icon: Icon(
                widget.icon.icon,
                color: _isLiked ? widget.icon.color : widget.normalColor,
                size: widget.size * 0.4,
              ),
              onPressed: _onTap,
            ),
          ),
        ),
      ],
    );
  }

  void _onTap() {
    if (_controller.isAnimating) return;
    _isLiked = !_isLiked;
    if (_isLiked) {
      _controller.reset();
      _controller.forward();
    } else {
      setState(() {});
    }
    if (widget.onClicked != null) widget.onClicked(_isLiked);
  }

  void _initAllAnimations() {
    outerCircle = Tween<double>(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.3,
          curve: Curves.ease,
        ),
      ),
    );
    innerCircle = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.2,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );
    scale = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.35,
          0.7,
          curve: OvershootCurve(),
        ),
      ),
    );
    dots = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          1.0,
          curve: Curves.decelerate,
        ),
      ),
    );
  }
}

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
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DotPainter extends CustomPainter {
  final int dotCount;
  double outerDotsPositionAngle = 51.42;

  final Color color1;
  final Color color2;
  final Color color3;
  final Color color4;

  double centerX = 0.0;
  double centerY = 0.0;

  final List<Paint> circlePaints = List(4);

  double maxOuterDotsRadius = 0.0;
  double maxInnerDotsRadius = 0.0;
  double maxDotSize;

  final currentProgress;

  double currentRadius1 = 0.0;
  double currentDotSize1 = 0.0;
  double currentDotSize2 = 0.0;
  double currentRadius2 = 0.0;

  bool isFirst = true;

  DotPainter({
    @required this.currentProgress,
    this.dotCount = 7,
    this.color1 = const Color(0xFFFFC107),
    this.color2 = const Color(0xFFFF9800),
    this.color3 = const Color(0xFFFF5722),
    this.color4 = const Color(0xFFF44336),
  }) {
    outerDotsPositionAngle = 360.0 / dotCount;
    for (int i = 0; i < circlePaints.length; i++) {
      circlePaints[i] = Paint()..style = PaintingStyle.fill;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (isFirst) {
      centerX = size.width * 0.5;
      centerY = size.height * 0.5;
      maxDotSize = size.width * 0.05;
      maxOuterDotsRadius = size.width * 0.5 - maxDotSize * 2;
      maxInnerDotsRadius = 0.8 * maxOuterDotsRadius;
      isFirst = false;
    }
    _updateOuterDotsPosition();
    _updateInnerDotsPosition();
    _updateDotsPaints();
    _drawOuterDotsFrame(canvas);
    _drawInnerDotsFrame(canvas);
  }

  void _drawOuterDotsFrame(Canvas canvas) {
    for (int i = 0; i < dotCount; i++) {
      double cX = centerX +
          currentRadius1 * math.cos(i * degToRad(outerDotsPositionAngle));
      double cY = centerY +
          currentRadius1 * math.sin(i * degToRad(outerDotsPositionAngle));
      canvas.drawCircle(Offset(cX, cY), currentDotSize1,
          circlePaints[i % circlePaints.length]);
    }
  }

  void _drawInnerDotsFrame(Canvas canvas) {
    for (int i = 0; i < dotCount; i++) {
      double cX = centerX +
          currentRadius2 *
              math.cos((i * degToRad(outerDotsPositionAngle - 10)));
      double cY = centerY +
          currentRadius2 *
              math.sin((i * degToRad(outerDotsPositionAngle - 10)));
      canvas.drawCircle(Offset(cX, cY), currentDotSize2,
          circlePaints[(i + 1) % circlePaints.length]);
    }
  }

  void _updateOuterDotsPosition() {
    if (currentProgress < 0.3) {
      currentRadius1 = mapValueFromRangeToRange(
          currentProgress, 0.0, 0.3, 0.0, maxOuterDotsRadius * 0.8);
    } else {
      currentRadius1 = mapValueFromRangeToRange(currentProgress, 0.3, 1.0,
          0.8 * maxOuterDotsRadius, maxOuterDotsRadius);
    }
    if (currentProgress == 0) {
      currentDotSize1 = 0;
    } else if (currentProgress < 0.7) {
      currentDotSize1 = maxDotSize;
    } else {
      currentDotSize1 =
          mapValueFromRangeToRange(currentProgress, 0.7, 1.0, maxDotSize, 0.0);
    }
  }

  void _updateInnerDotsPosition() {
    if (currentProgress < 0.3) {
      currentRadius2 = mapValueFromRangeToRange(
          currentProgress, 0.0, 0.3, 0.0, maxInnerDotsRadius);
    } else {
      currentRadius2 = maxInnerDotsRadius;
    }
    if (currentProgress == 0) {
      currentDotSize2 = 0;
    } else if (currentProgress < 0.2) {
      currentDotSize2 = maxDotSize;
    } else if (currentProgress < 0.5) {
      currentDotSize2 = mapValueFromRangeToRange(
          currentProgress, 0.2, 0.5, maxDotSize, 0.3 * maxDotSize);
    } else {
      currentDotSize2 = mapValueFromRangeToRange(
          currentProgress, 0.5, 1.0, maxDotSize * 0.3, 0.0);
    }
  }

  void _updateDotsPaints() {
    double progress = clamp(currentProgress, 0.6, 1.0);
    int alpha =
    mapValueFromRangeToRange(progress, 0.6, 1.0, 255.0, 0.0).toInt();
    if (currentProgress < 0.5) {
      double progress =
      mapValueFromRangeToRange(currentProgress, 0.0, 0.5, 0.0, 1.0);
      circlePaints[0]
        ..color = Color.lerp(color1, color2, progress).withAlpha(alpha);
      circlePaints[1]
        ..color = Color.lerp(color2, color3, progress).withAlpha(alpha);
      circlePaints[2]
        ..color = Color.lerp(color3, color4, progress).withAlpha(alpha);
      circlePaints[3]
        ..color = Color.lerp(color4, color1, progress).withAlpha(alpha);
    } else {
      double progress =
      mapValueFromRangeToRange(currentProgress, 0.5, 1.0, 0.0, 1.0);
      circlePaints[0]
        ..color = Color.lerp(color2, color3, progress).withAlpha(alpha);
      circlePaints[1]
        ..color = Color.lerp(color3, color4, progress).withAlpha(alpha);
      circlePaints[2]
        ..color = Color.lerp(color4, color1, progress).withAlpha(alpha);
      circlePaints[3]
        ..color = Color.lerp(color1, color2, progress).withAlpha(alpha);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DotColor {
  final Color dotPrimaryColor;
  final Color dotSecondaryColor;
  final Color dotThirdColor;
  final Color dotLastColor;

  const DotColor({
    @required this.dotPrimaryColor,
    @required this.dotSecondaryColor,
    this.dotThirdColor,
    this.dotLastColor,
  });

  Color get dotThirdColorReal =>
      dotThirdColor == null ? dotPrimaryColor : dotThirdColor;

  Color get dotLastColorReal =>
      dotLastColor == null ? dotSecondaryColor : dotLastColor;
}

class LikeIcon extends Icon {
  final Color iconColor;

  const LikeIcon(
      IconData icon, {
        this.iconColor,
      }) : super(icon);

  @override
  Color get color => this.iconColor;
}

class OvershootCurve extends Curve {
  const OvershootCurve([this.period = 2.5]);

  final double period;

  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    t -= 1.0;
    return t * t * ((period + 1) * t + period) + 1.0;
  }

  @override
  String toString() {
    return '$runtimeType($period)';
  }
}
