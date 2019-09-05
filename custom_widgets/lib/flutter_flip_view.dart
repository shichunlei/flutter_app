import 'dart:math';

import 'package:flutter/material.dart';

typedef FlipWidgetBuilder = Widget Function(
    BuildContext context, bool isBackground);

/// https://github.com/WosLovesLife/flutter_flip_view
class FlipView extends StatefulWidget {
  final Widget front;
  final Widget back;
  final Animation<double> animationController;
  final AxisDirection goBackDirection;
  final AxisDirection goFrontDirection;

  const FlipView({
    Key key,
    @required this.front,
    @required this.back,
    @required this.animationController,
    AxisDirection goBackDirection,
    AxisDirection goFrontDirection,
  })  : this.goBackDirection = goBackDirection ?? AxisDirection.left,
        this.goFrontDirection = goFrontDirection ?? AxisDirection.left,
        super(key: key);

  @override
  createState() => FlipViewState();
}

class FlipViewState extends State<FlipView>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationStatus _lastStatus;

  @override
  void initState() {
    super.initState();
    _animation = _calculateTweenSequence(widget.goBackDirection);

    widget.animationController.addStatusListener((AnimationStatus status) {
      if (_lastStatus == status) return;
      _lastStatus = status;

      if (!this.mounted) return;

      if (status == AnimationStatus.completed ||
          status == AnimationStatus.reverse) {
        _animation = _calculateTweenSequence(widget.goFrontDirection);
      } else if (status == AnimationStatus.dismissed ||
          status == AnimationStatus.forward) {
        _animation = _calculateTweenSequence(widget.goBackDirection);
      }
    });
  }

  Animation<double> _calculateTweenSequence(AxisDirection direction) {
    final reverse =
        (direction == AxisDirection.right || direction == AxisDirection.down);
    final frontTween = Tween(
      begin: 0.0,
      end: reverse ? -pi / 2.0 : pi / 2.0,
    );
    final backTween = Tween(
      begin: reverse ? pi / 2.0 : -pi / 2.0,
      end: 0.0,
    );
    return TweenSequence([
      TweenSequenceItem(tween: frontTween, weight: 0.5),
      TweenSequenceItem(tween: backTween, weight: 0.5),
    ]).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    final front = widget.front;
    final back = widget.back;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child) {
        final direction = (_animation.status == AnimationStatus.forward ||
                _animation.status == AnimationStatus.completed)
            ? widget.goBackDirection
            : widget.goFrontDirection;
        return Transform(
          transform: _buildTransform(direction),
          alignment: Alignment.center,
          child: IndexedStack(
            alignment: Alignment.center,
            children: <Widget>[
              front,
              back,
            ],
            index: widget.animationController.value < 0.5 ? 0 : 1,
          ),
        );
      },
    );
  }

  Matrix4 _buildTransform(AxisDirection direction) {
    final matrix = Matrix4.identity()..setEntry(3, 2, 0.001);
    switch (direction) {
      case AxisDirection.left:
      case AxisDirection.right:
        matrix.rotateY(_animation.value);
        break;
      case AxisDirection.up:
      case AxisDirection.down:
        matrix.rotateX(_animation.value);
        break;
    }
    return matrix;
  }
}
