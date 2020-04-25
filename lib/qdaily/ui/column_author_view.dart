import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ColumnAuthorView extends StatelessWidget {
  final AuthorBean author;

  ColumnAuthorView({Key key, @required this.author}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Card(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(children: <Widget>[
                ImageLoadView('${author.avatar}',
                    shape: BoxShape.circle,
                    width: 50,
                    height: 50),
                Gaps.hGap5,
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text('${author.name}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Text('${author.description}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey))
                    ]))
              ])),
        ));
  }
}
