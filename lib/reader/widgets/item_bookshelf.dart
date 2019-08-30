import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemBookShelf extends StatelessWidget {
  final Books book;
  final VoidCallback onPressed;
  final double progress;
  final bool showAddBookshelfItem;
  final VoidCallback onLongPress;

  ItemBookShelf(
      {Key key,
      @required this.book,
      this.onPressed,
      this.progress: 0.0,
      this.showAddBookshelfItem: false,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (Utils.width - 20) / 3;
    return Material(
        color: Colors.white,
        child: InkWell(
          child: showAddBookshelfItem && book == null
              ? Container(
                  child: Icon(Icons.add, size: 40),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)))
              : Column(children: <Widget>[
                  ImageLoadView('${book?.cover}',
                      height: width * 57 / 43, width: width),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('${book?.title}',
                          style: TextStyles.textDark14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                          progress == 0.0
                              ? '未读'
                              : "已读${progress.toStringAsFixed(2)}%",
                          style: TextStyles.textGrey12)),
                ], crossAxisAlignment: CrossAxisAlignment.start),
          onTap: onPressed,
          onLongPress: onLongPress,
        ));
  }
}
