import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String text;
  final String imageAsset;
  final Function onPressed;

  ErrorPage({Key key, this.imageAsset, this.text: '网络加载失败', this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text('$text'), Image.asset('$imageAsset')]),
            onTap: onPressed));
  }
}
