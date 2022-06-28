import 'package:flutter/material.dart';

class AnimatedOpacityDemo extends StatefulWidget {
  const AnimatedOpacityDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  bool forward = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('FlutterLogo')),
        body: Center(
            child: AnimatedOpacity(
                child: const FlutterLogo(size: 200.0),
                duration: const Duration(milliseconds: 2000),
                opacity: forward ? 1.0 : 0.0)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => forward = !forward);
            },
            child: const Icon(Icons.brush)));
  }
}
