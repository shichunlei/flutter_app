import 'package:flutter/material.dart';

class AnimatedBuilderDemo extends StatefulWidget {
  AnimatedBuilderDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedBuilder')),
        body: Center(
          child: AnimatedBuilder(
              animation: controller,
              child:
                  Container(width: 200.0, height: 200.0, color: Colors.green),
              builder: (BuildContext context, Widget child) {
                debugPrint('${controller.value}');
                return Transform.scale(scale: controller.value, child: child);
              }),
        ));
  }
}
