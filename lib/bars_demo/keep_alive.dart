import 'package:flutter/material.dart';

class KeepAliveWidget extends StatefulWidget {
  @override
  createState() => KeepAliveWidgetState();
}

class KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("点一次增加一个数字"),
              Text('$_counter', style: Theme.of(context).textTheme.headline1)
            ])),
        floatingActionButton: FloatingActionButton(
            onPressed: () => setState(() => _counter++),
            tooltip: "Increment",
            child: Icon(Icons.add)));
  }
}
