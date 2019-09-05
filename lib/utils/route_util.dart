import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../page_index.dart';

void pushAndRemovePage(BuildContext context, Widget routePage) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => routePage),
    (route) => route == null,
  );
}

void pushNewPage(BuildContext context, Widget routePage, {Function callBack}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage))
      .then((value) {
    if (value != null) {
      callBack(value);
    }
  });
}

void pushNewPageBack(BuildContext context, Widget routePage,
    {Function callBack}) {
  Navigator.of(context)
      .push(CupertinoPageRoute(builder: (context) => routePage))
      .then((data) {
    if (data != null) {
      callBack(data);
    }
  });
}

void popAndPushNewPage(BuildContext context, String routeName) {
  Navigator.popAndPushNamed(context, routeName);
}

void pushReplacement(BuildContext context, Widget routePage) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => routePage));
}

void pushReplacementName(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}

class EnterExitRoute<T> extends PageRouteBuilder<T> {
  final Widget enterPage;
  final Widget exitPage;
  final Duration duration;

  EnterExitRoute(
      {this.exitPage,
      this.enterPage,
      this.duration: const Duration(milliseconds: 500)})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                enterPage,
            transitionDuration: duration,
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                Stack(children: <Widget>[
                  SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(0.0, 0.0),
                        end: const Offset(-1.0, 0.0),
                      ).animate(animation),
                      child: exitPage),
                  SlideTransition(
                      position: new Tween<Offset>(
                              begin: const Offset(1.0, 0.0), end: Offset.zero)
                          .animate(animation),
                      child: enterPage)
                ]));
}

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

class RotationRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;
  final Curve curve;

  RotationRoute(
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
              RotationTransition(
                  turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: curve)),
                  child: child),
        );
}

class ScaleRotateRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  ScaleRotateRoute({this.page})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.fastOutSlowIn)),
                  child: RotationTransition(
                      turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animation, curve: Curves.fastOutSlowIn)),
                      child: child)),
        );
}

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

class SizeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final Duration duration;

  SizeRoute({this.page, this.duration: const Duration(milliseconds: 500)})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              page,
          transitionDuration: duration,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              Align(child: SizeTransition(sizeFactor: animation, child: child)),
        );
}

class SlideRoute<T> extends PageRouteBuilder<T> {
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
