import 'package:flutter/material.dart';

import 'dart:math';

import '../page_index.dart';

class PersonPage extends StatefulWidget {
  final double offsetX;

  PersonPage({Key key, this.offsetX}) : super(key: key);

  @override
  createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  double screenWidth;
  double screenHeight;

  @override
  void initState() {
    super.initState();

    screenWidth = Utils.width;
    screenHeight = Utils.height;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(max(0, widget.offsetX + screenWidth), 0),
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.transparent,
            child: Image.asset(
              "images/right.jpg",
              fit: BoxFit.fill,
              width: screenWidth,
            ),
          ),
        ));
  }
}
