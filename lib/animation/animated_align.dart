import 'package:flutter/material.dart';

class AnimatedAlignDemo extends StatefulWidget {
  AnimatedAlignDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<AnimatedAlignDemo> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedAlign')),
        body: AnimatedAlign(
            alignment: status ? Alignment.bottomLeft : Alignment.topRight,
            duration: Duration(milliseconds: 1500),
            child: FlutterLogo()),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => status = !status);
            },
            child: Icon(Icons.brush)));
  }
}
