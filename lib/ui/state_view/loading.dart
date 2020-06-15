import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Utils.isAndroid
              ? CircularProgressIndicator(
                  strokeWidth: 3.0, backgroundColor: Colors.greenAccent)
              : CupertinoActivityIndicator(radius: 20.0),
          Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text('加载中', style: TextStyle(fontSize: 16)))
        ]),
      );
}
