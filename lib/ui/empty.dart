import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String text;
  final String imageAsset;

  EmptyPage({Key key, this.text, this.imageAsset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Text('$text'),
        SizedBox(height: 20),
        Image.asset('$imageAsset', width: 150, height: 150, fit: BoxFit.contain)
      ]),
    );
  }
}
