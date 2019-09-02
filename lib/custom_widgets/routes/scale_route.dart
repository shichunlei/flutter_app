import 'package:flutter/material.dart';

/// 缩放路由动画
class ScaleRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;

  ScaleRoute(
      {this.page,
      this.duration: const Duration(milliseconds: 500),
      this.curve: Curves.fastOutSlowIn})
      : super(
            pageBuilder: (_, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                page,
            transitionDuration: duration,
            transitionsBuilder: (_, Animation<double> animation,
                    Animation<double> secondaryAnimation, Widget child) =>
                ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(parent: animation, curve: curve)),
                    child: child));
}
