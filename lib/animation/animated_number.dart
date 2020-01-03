import 'package:flutter/material.dart';

import 'utils/animations.dart';

class AnimatedNumberDemo extends StatelessWidget {
  AnimatedNumberDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('AnimatedNumberDemo')),
      body: Center(
        child: AnimatedNumber(
          number: 1000,
        ),
      ),
    );
  }
}
