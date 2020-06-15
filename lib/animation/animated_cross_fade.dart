import 'dart:async';

import 'package:flutter/material.dart';

/// AnimatedCrossFade让俩个子widget 交替淡入淡出。

class AnimatedCrossFadeDemo extends StatefulWidget {
  AnimatedCrossFadeDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedCrossFadeDemoState();
}

class _AnimatedCrossFadeDemoState extends State<AnimatedCrossFadeDemo> {
  var _first = false;

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _first = !_first;
      });
    });

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedCrossFade')),
        body: Center(
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const FlutterLogo(
                style: FlutterLogoStyle.horizontal, size: 100.0),
            secondChild:
                const FlutterLogo(style: FlutterLogoStyle.stacked, size: 100.0),
            crossFadeState:
                _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          ),
        ));
  }
}
