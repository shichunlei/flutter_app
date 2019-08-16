import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

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
