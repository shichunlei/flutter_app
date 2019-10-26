import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          CircularProgressIndicator(strokeWidth: 3.0),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('加载中', style: TextStyle(fontSize: 16)))
        ]),
      );
}
