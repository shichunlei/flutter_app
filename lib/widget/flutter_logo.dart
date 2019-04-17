import 'package:flutter/material.dart';

class FlutterLogoWidget extends StatefulWidget {
  FlutterLogoWidget({Key key}) : super(key: key);

  @override
  _FlutterLogoWidgetState createState() => _FlutterLogoWidgetState();
}

class _FlutterLogoWidgetState extends State<FlutterLogoWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlutterLogo')),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: _animation,
            child: FlutterLogo(
              size: 100.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.forward(),
        child: Icon(
          Icons.brush,
        ),
        tooltip: 'Fade',
      ),
    );
  }
}
