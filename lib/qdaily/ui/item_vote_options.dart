import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';

import '../index.dart';

class ItemVoteOptions extends StatelessWidget {
  final Option option;

  ItemVoteOptions({Key key, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPaint(
                painter: ArcPainter(
                    isCheck: option.selected, rate: option.percent.toDouble()),
                size: Size(50, 50))),
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Text(
                '${option.percent}%',
                style: TextStyles.textDark16,
              ),
              Text(
                '${option.content}',
                style: TextStyles.textGrey14,
              )
            ]))
      ]),
    );
  }
}
