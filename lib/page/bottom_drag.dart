import 'package:flutter/material.dart';

import '../page_index.dart';

class BottomDragWidgetDemo extends StatelessWidget {
  BottomDragWidgetDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('BottomDrag')),
      body: BottomDragWidget(
        body: Container(),
        dragContainer: DragContainer(
            drawer: Container(
                child: OverscrollNotificationWidget(child: BottomDragView()),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 244, 248),
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0)))),
            defaultShowHeight: Utils.height * 0.1,
            height: Utils.height * 0.6),
      ),
    );
  }
}

class BottomDragView extends StatelessWidget {
  BottomDragView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Container(
            child: Text('title'),
            height: Utils.height * 0.1,
            alignment: Alignment.center),
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('item$index'),
                  leading: Icon(Icons.color_lens),
                );
              },
              itemCount: 50),
        )
      ]),
    );
  }
}
