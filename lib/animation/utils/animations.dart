import 'package:flutter/material.dart';

import '../../page_index.dart';

/// A simple animation that "bounces in" its child.
///
/// 一个简单地弹出动画
///
/// https://github.com/robertodoering/harpy/blob/master/lib/components/widgets/shared/animations.dart
///
class BounceInAnimation extends StatefulWidget {
  const BounceInAnimation({
    @required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  createState() => _BounceInAnimationState();
}

class _BounceInAnimationState extends State<BounceInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = CurveTween(curve: Curves.elasticOut).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: widget.child,
    );
  }
}

/// 参考自：https://juejin.im/post/5d646c9e6fb9a06b084d037e
class AnimatedArrow extends StatefulWidget {
  final Widget child;
  final Direction direction;
  final Duration duration;

  AnimatedArrow(
      {Key key,
      @required this.child,
      this.direction: Direction.DOWN,
      this.duration: const Duration(milliseconds: 800)})
      : super(key: key);

  @override
  createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacityAnimation;
  Animation<double> _marginAnimation;

  CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(_animation);

    _marginAnimation = Tween(begin: 80.0, end: 0.0).animate(_animation);

    _animation.addStatusListener((value) {
      if (value == AnimationStatus.completed) {
        Future.delayed(Duration(milliseconds: 500), () {
          _controller.reset();
        });
      } else if (value == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    if (mounted) _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            child: widget.child,
            margin: EdgeInsets.only(
                top: widget.direction == Direction.UP
                    ? _marginAnimation.value
                    : 0,
                left: widget.direction == Direction.LEFT
                    ? _marginAnimation.value
                    : 0,
                right: widget.direction == Direction.RIGHT
                    ? _marginAnimation.value
                    : 0,
                bottom: widget.direction == Direction.DOWN
                    ? _marginAnimation.value
                    : 0),
          ),
        );
      },
    );
  }
}

/// Slides its [child] into position upon creation.
class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    @required this.child,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.offset = Offset.zero,
    this.curve = Curves.fastOutSlowIn,
  });

  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay until the animation starts.
  final Duration delay;

  /// The offset that the child will have before it slides into position.
  final Offset offset;

  final Curve curve;

  @override
  createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  bool _hidden = true;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = CurveTween(curve: widget.curve).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) {
        _controller.forward();
        _hidden = false;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hidden) {
      return Container();
    } else {
      return Transform.translate(
        offset: Offset(
          (1 - _animation.value) * widget.offset.dx,
          (1 - _animation.value) * widget.offset.dy,
        ),
        child: widget.child,
      );
    }
  }
}

/// Slides and fades its child into position upon creation.
class SlideFadeInAnimation extends StatefulWidget {
  const SlideFadeInAnimation({
    @required this.child,
    Key key,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.offset = Offset.zero,
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key);

  /// The child to animate.
  final Widget child;

  /// The duration of the animation.
  final Duration duration;

  /// The delay until the animation starts.
  final Duration delay;

  /// The offset that the child will have before it slides into position.
  final Offset offset;

  /// The curve used by the animation.
  final Curve curve;

  @override
  createState() => _SlideFadeInAnimationState();
}

class _SlideFadeInAnimationState extends State<SlideFadeInAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = CurveTween(curve: widget.curve).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) _controller.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(
              (1 - _animation.value) * widget.offset.dx,
              (1 - _animation.value) * widget.offset.dy,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Fades out its [child] upon creation.
class FadeOutWidget extends StatefulWidget {
  const FadeOutWidget({
    Key key,
    this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  createState() => _FadeOutWidgetState();
}

class _FadeOutWidgetState extends State<FadeOutWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..forward();
  }

  @override
  void deactivate() {
    _controller.stop();
    super.deactivate();
  }

  @override
  void didUpdateWidget(FadeOutWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.isAnimating
        ? Opacity(
            opacity: 1.0 - _controller.value,
            child: widget.child,
          )
        : SizedBox();
  }
}

/// An implicitly animated widget that will animate a change to [scale].
class AnimatedScale extends ImplicitlyAnimatedWidget {
  const AnimatedScale({
    @required this.scale,
    @required this.child,
    Curve curve = Curves.easeInCubic,
    Duration duration = const Duration(milliseconds: 100),
  }) : super(curve: curve, duration: duration);

  final double scale;
  final Widget child;

  @override
  createState() => _AnimatedScaleState();
}

class _AnimatedScaleState extends AnimatedWidgetBaseState<AnimatedScale> {
  Tween<double> _scaleTween;

  @override
  void forEachTween(visitor) {
    _scaleTween = visitor(
      _scaleTween,
      widget.scale,
      (value) => Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scaleTween.evaluate(animation),
      child: widget.child,
    );
  }
}

/// A widget that can be used to "slide away" its child by calling a method.
class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    @required this.child,
    @required this.endPosition,
    Key key,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  final Widget child;
  final Offset endPosition;
  final Duration duration;

  @override
  createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (mounted) setState(() {});
      });

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.endPosition,
    ).animate(CurveTween(curve: Curves.easeInCubic).animate(_controller));

    super.initState();
  }

  Future<void> forward() {
    return _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _animation.value,
      child: widget.child,
    );
  }
}

/// 计数动画
///
class AnimatedNumber extends StatefulWidget {
  final double number;
  final Duration duration;
  final TextStyle style;
  final double start;
  final int decimal;
  final Duration delay;

  AnimatedNumber({
    Key key,
    @required this.number,
    this.start: 0.0,
    this.decimal: 0,
    this.duration: const Duration(milliseconds: 1000),
    this.style,
    this.delay = Duration.zero,
  })  : assert(number != null),
        super(key: key);

  @override
  createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  double end = 0.0;

  @override
  void initState() {
    super.initState();

    end = widget.number;

    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        setState(() {});
      });

    _animation = Tween(begin: widget.start, end: end).animate(_controller);

    Future.delayed(widget.delay).then((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_animation.value.toStringAsFixed(widget.decimal)}',
      style: widget.style ?? TextStyles.textBoldDark26,
    );
  }
}
