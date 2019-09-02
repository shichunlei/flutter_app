import 'package:flutter/material.dart';

class AnimatedOpacityDemo extends StatefulWidget {
  AnimatedOpacityDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  bool forward = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FlutterLogo')),
        body: Center(
            child: AnimatedOpacity(
                child: FlutterLogo(size: 200.0),
                duration: const Duration(milliseconds: 2000),
                opacity: forward ? 1.0 : 0.0)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => forward = !forward);
            },
            child: Icon(Icons.brush)));
  }
}
