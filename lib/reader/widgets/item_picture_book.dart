import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemPictureBook extends StatelessWidget {
  final Books book;
  final VoidCallback onPressed;
  final double width;

  ItemPictureBook(
      {Key key, @required this.book, this.onPressed, @required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            child: Container(
              child: Column(children: <Widget>[
                ImageLoadView('${book?.cover}',
                    height: width * 57 / 43, width: width),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('${book?.title}',
                        style: TextStyles.textDark14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis))
              ], crossAxisAlignment: CrossAxisAlignment.start),
            ),
            onTap: onPressed));
  }
}
