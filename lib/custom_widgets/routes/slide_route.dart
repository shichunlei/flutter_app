import 'package:flutter/material.dart';

class SlideRoute extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;

  SlideRoute({this.page, this.direction = SlideDirection.right})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              Offset begin;
              if (direction == SlideDirection.right) {
                begin = Offset(-1, 0);
              }

              if (direction == SlideDirection.top) {
                begin = Offset(0, 1);
              }

              if (direction == SlideDirection.bottom) {
                begin = Offset(0, -1);
              }

              if (direction == SlideDirection.left) {
                begin = Offset(1, 0);
              }

              return SlideTransition(
                position: Tween<Offset>(
                  begin: begin,
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}

enum SlideDirection { top, left, bottom, right }
