import 'package:flutter/material.dart';

class ScaleTapView extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback onPressed;

  ScaleTapView(
      {Key key, @required this.child, this.duration, @required this.onPressed})
      : super(key: key);

  @override
  createState() => _ScaleTapViewState();
}

class _ScaleTapViewState extends State<ScaleTapView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: widget.duration ?? Duration(milliseconds: 200));

    _animation =
        Tween<double>(begin: 1, end: 0.98).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        onPanDown: (details) {
          _animationController.forward(); // 点击的时候播放动画
        },
        onPanCancel: () {
          _animationController.reverse(); // cancel的时候回弹动画
        },
        child: ScaleTransition(
            scale: _animation, // 定义动画
            child: widget.child));
  }
}
