import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void pushAndRemovePage(BuildContext context, Widget routePage) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => routePage),
      (route) => route == null);
}

void pushNewPage(BuildContext context, Widget routePage,
    {Function callBack, fullscreenDialog: false}) {
  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => routePage,
              fullscreenDialog: fullscreenDialog))
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

void pushNewPageAnimation(
  BuildContext context,
  Widget toPage, {
  @required TransitionType type,
  Widget fromPage,
  Duration duration: const Duration(milliseconds: 500),
  Curve curve: Curves.fastOutSlowIn,
  SlideDirection direction: SlideDirection.right2left,
  Axis axis: Axis.vertical,
  Function callBack,
}) {
  Navigator.push(
      context,
      PageTransition(
        type: type,
        toPage: toPage,
        fromPage: fromPage,
        duration: duration,
        curve: curve,
        direction: direction,
        axis: axis,
      )).then(callBack?.call);
}

enum TransitionType {
  fade,
  scale,
  rotate,
  transform,
  size,
  scale_rotate,
  slide_left,
  slide_top,
  slide_right,
  slide_bottom,
  enter_exit
}

enum SlideDirection { bottom2top, right2left, top2bottom, left2right }

class PageTransition extends PageRouteBuilder {
  final Widget fromPage;
  final Widget toPage;
  final Duration duration;
  final Curve curve;
  final TransitionType type;
  final SlideDirection direction;
  final Axis axis;

  PageTransition(
      {@required this.toPage,
      this.fromPage,
      this.direction,
      this.curve,
      this.duration,
      this.type,
      this.axis})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                toPage,
            transitionDuration: duration,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              switch (type) {
                case TransitionType.fade: // 渐变透明路由动画
                  return FadeTransition(
                      opacity: Tween(begin: 0.1, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.rotate: // 旋转动画
                  return RotationTransition(
                      turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.scale: // 缩放路由动画
                  return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.size: //
                  return Center(
                      child: SizeTransition(
                          sizeFactor: Tween<double>(begin: 0.0, end: 1.0)
                              .animate(CurvedAnimation(
                                  parent: animation, curve: curve)),
                          axis: axis,
                          child: child));
                  break;
                case TransitionType.scale_rotate: //
                  return ScaleTransition(
                      scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: curve)),
                      child: RotationTransition(
                          turns: Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(parent: animation, curve: curve)),
                          child: child));
                  break;
                case TransitionType.transform:
                  return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0001)
                        ..rotateX(animation.value * pi * 2)
                        ..rotateY(animation.value * pi * 2),
                      alignment: FractionalOffset.center,
                      child: child);
                  break;
                case TransitionType.enter_exit:
                  Offset begin, end;

                  switch (direction) {
                    case SlideDirection.left2right:
                      begin = Offset(-1.0, 0.0);
                      end = Offset(1.0, 0.0);
                      break;
                    case SlideDirection.right2left:
                      begin = Offset(1.0, 0.0);
                      end = Offset(-1.0, 0.0);
                      break;
                    case SlideDirection.bottom2top:
                      begin = Offset(0.0, 1.0);
                      end = Offset(0.0, -1.0);
                      break;
                    case SlideDirection.top2bottom:
                      begin = Offset(0.0, -1.0);
                      end = Offset(0.0, 1.0);
                      break;
                    default:
                      break;
                  }

                  return Stack(children: <Widget>[
                    SlideTransition(
                        position: Tween<Offset>(begin: Offset.zero, end: end)
                            .animate(CurvedAnimation(
                                parent: animation, curve: curve)),
                        child: fromPage),
                    SlideTransition(
                        position: Tween<Offset>(begin: begin, end: Offset.zero)
                            .animate(CurvedAnimation(
                                parent: animation, curve: curve)),
                        child: toPage)
                  ]);
                  break;
                case TransitionType.slide_left:
                  return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(1.0, 0.0), end: Offset.zero)
                          .animate(
                              CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.slide_top:
                  return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, 1.0), end: Offset.zero)
                          .animate(
                              CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.slide_right:
                  return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(-1.0, 0.0), end: Offset.zero)
                          .animate(
                              CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                case TransitionType.slide_bottom:
                  return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, -1.0), end: Offset.zero)
                          .animate(
                              CurvedAnimation(parent: animation, curve: curve)),
                      child: child);
                  break;
                default:
                  return child;
              }
            });
}
