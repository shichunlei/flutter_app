import 'package:flutter/material.dart';
import 'package:flutter_app/res/styles.dart';

import '../index.dart';

class ItemVoteOptions extends StatelessWidget {
  final Option option;

  ItemVoteOptions({Key key, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomPaint(
              painter:
                  ArcPainter(isCheck: true, rate: option.percent.toDouble()),
              size: Size(70, 70),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  '${option.percent}%',
                  style: TextStyles.textDark16,
                ),
                Text(
                  '${option.content}',
                  style: TextStyles.textGrey14,
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          )
        ],
      ),
    );
  }
}
