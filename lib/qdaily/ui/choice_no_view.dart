import 'package:flutter/material.dart';

import '../../page_index.dart';

class ChoiceNoView extends StatelessWidget {
  final int index;
  final int total;

  ChoiceNoView({Key key, @required this.index, @required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: Utils.topSafeHeight + 10, bottom: 20),
        child: LineViewLine(
            horizontalPadding: 30,
            child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.yellow,
                child: Text('$index / $total'))));
  }
}
