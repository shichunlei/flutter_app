import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class AnimatedCDView extends AnimatedWidget {
  final Animation<double> animation;

  final String imageUrl;

  AnimatedCDView({Key key, this.animation, this.imageUrl})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Align(
        child: Transform.rotate(
            angle: animation.value * 2 * pi,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: Color.fromRGBO(192, 193, 193, 0.2)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(192, 193, 193, 0.35),
                          blurRadius: 15.0,
                          spreadRadius: 4.0,
                          offset: Offset(0.0, 0.0))
                    ]),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 100.0,
                    child: Stack(children: <Widget>[
                      ImageLoadView(imageUrl,
                          height: 190, width: 190, shape: BoxShape.circle),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 27.5,
                          child: CircleAvatar(
                              backgroundColor:
                                  Color.fromRGBO(192, 193, 193, 0.35),
                              radius: 23.0))
                    ], alignment: Alignment.center)))));
  }
}
