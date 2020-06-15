import 'package:flutter/material.dart';

class AnimatedPaddingDemo extends StatefulWidget {
  AnimatedPaddingDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedPaddingDemoState();
}

class _AnimatedPaddingDemoState extends State<AnimatedPaddingDemo> {
  bool forward = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedPadding')),
        body: Center(
            child: Container(
                child: AnimatedPadding(
                    padding: EdgeInsets.all(forward ? 50 : 0),
                    duration: Duration(milliseconds: 500),
                    child: Text('AnimatedPaddingDemo')),
                color: Colors.red)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => forward = !forward);
            },
            child: Icon(Icons.brush)));
  }
}
