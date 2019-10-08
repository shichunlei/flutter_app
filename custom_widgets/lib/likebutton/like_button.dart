import 'package:flutter/material.dart';

import 'circle_painter.dart';
import 'dot_painter.dart';
import 'model.dart';

export 'circle_painter.dart';
export 'dot_painter.dart';
export 'model.dart';

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
