import 'package:flutter/material.dart';

/// 渐变透明路由动画
class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;

  FadeRoute(
      {this.page,
      this.duration: const Duration(milliseconds: 500),
      this.curve: Curves.fastOutSlowIn})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionDuration: duration,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
                  opacity: Tween(begin: 0.1, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: curve)),
                  child: child),
        );
}
