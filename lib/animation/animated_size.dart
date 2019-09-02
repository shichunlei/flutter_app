import 'package:flutter/material.dart';

class AnimatedSizeDemo extends StatefulWidget {
  AnimatedSizeDemo({Key key}) : super(key: key);

  @override
  createState() => _AnimatedSizeDemoState();
}

class _AnimatedSizeDemoState extends State<AnimatedSizeDemo>
    with TickerProviderStateMixin {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('AnimatedSize')),
        body: Center(
            child: AnimatedSize(
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.deepPurpleAccent,
                    // 对高度进行了演示。
                    height: status ? 60 : 150,
                    child: Text("AnimatedSize动画演示")),
                duration: Duration(milliseconds: 500),
                //注意这个，要在state里width TickerProviderStateMixin
                vsync: this)),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() => status = !status);
            },
            child: Icon(Icons.brush)));
  }
}
