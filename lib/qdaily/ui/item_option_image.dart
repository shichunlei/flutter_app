import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemOptionImage extends StatelessWidget {
  final Option option;

  ItemOptionImage({Key key, @required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Utils.width;

    return Container(
        color: Utils.randomRGB(),
        child: Column(children: <Widget>[
          Stack(children: <Widget>[
            ImageLoadView('${option?.image}',
                width: (width - 14) / 2, height: (width - 14) / 2),
            Padding(
                padding: EdgeInsets.all(10),
                child: ViewOptionAuthor(
                    avatar: '${option?.author?.avatar}',
                    name: '${option?.author?.name}'))
          ]),
          Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
              child: Column(children: <Widget>[
                Text('${option.content}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: option.content.length > 8 ? 14 : 18)),
                SizedBox(height: 5),
                ViewOptionBottom(praiseCount: option.praiseCount)
              ]))
        ]));
  }
}
