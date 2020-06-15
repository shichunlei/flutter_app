import 'package:flutter/material.dart';

class EachView extends StatelessWidget {
  final String title;

  EachView(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), automaticallyImplyLeading: false),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
