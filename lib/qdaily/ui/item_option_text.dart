import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

import '../index.dart';

class ItemOptionText extends StatelessWidget {
  final Option option;

  ItemOptionText({Key key, @required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Utils.randomRGB(),
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            ViewOptionAuthor(
                avatar: '${option?.author?.avatar}',
                name: '${option?.author?.name}'),
            ConstrainedBox(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('${option.content}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: option.content.length > 8 ? 14 : 18)),
                    alignment: Alignment.center),
                constraints: BoxConstraints(minHeight: 80)),
            ViewOptionBottom(praiseCount: option.praiseCount)
          ])),
    );
  }
}
