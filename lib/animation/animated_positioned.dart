import 'package:flutter/material.dart';

class AnimatedPositionedDemo extends StatefulWidget {
  AnimatedPositionedDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedPositionedDemoState();
}

class _AnimatedPositionedDemoState extends State<AnimatedPositionedDemo> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedPositioned')),
        body: Stack(children: <Widget>[
          AnimatedPositioned(
              top: status ? 50 : 100,
              height: status ? 50 : 100,
              left: status ? 50 : 100,
              curve: Curves.elasticInOut,
              child: Container(
                  padding: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  color: Colors.deepPurpleAccent,
                  child: Text("AnimatedPositioned动画演示")),
              duration: Duration(milliseconds: 500))
        ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => status = !status);
            },
            child: Icon(Icons.brush)));
  }
}
