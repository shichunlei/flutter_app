import 'package:flutter/material.dart';

class BouncingView extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;

  /// 变化因子
  /// 当值大于1时子控件变化：由默认大小先变大然后松开按钮变回原大小
  /// 当值小于1时子控件变化：由默认大小先变小然后松开按钮变回原大小
  /// 当值为1时子控件大小始终无变化
  ///
  final double scaleFactor;

  BouncingView({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.scaleFactor: 0.98,
  }) : super(key: key);

  @override
  createState() => _BouncingViewState();
}

class _BouncingViewState extends State<BouncingView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  GlobalKey _childKey = GlobalKey();

  Widget get child => widget.child;

  VoidCallback get onPressed => widget.onPressed;

  double get scaleFactor => widget.scaleFactor;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _animation = Tween<double>(begin: 1, end: scaleFactor).animate(_controller);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        onTapDown: (details) {
          _controller.forward(); // 点击的时候播放动画
        },
        onTapCancel: () {
          _controller.reverse(); // cancel的时候回弹动画
        },
        child: ScaleTransition(
            key: _childKey,
            scale: _animation, // 定义动画
            child: child));
  }
}
