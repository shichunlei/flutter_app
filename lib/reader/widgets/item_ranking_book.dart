import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemRankingBook extends StatelessWidget {
  final Books book;
  final VoidCallback onPressed;
  final int index;

  ItemRankingBook({Key key, @required this.book, this.onPressed, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ImageLoadView('${book?.cover}',
                  height: 99, width: 77),
              Gaps.hGap5,
              Expanded(
                child: Column(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text('${book?.title}',
                              maxLines: 1,
                              style: TextStyles.textBoldDark16,
                              overflow: TextOverflow.ellipsis)),
                      Text(
                        index < 3 ? 'top${index + 1}' : '${index + 1}',
                        style: TextStyle(
                            fontSize: 20,
                            color: index == 0
                                ? Colors.redAccent
                                : index == 1
                                    ? Colors.deepOrange
                                    : index == 2
                                        ? Colors.orange
                                        : Colors.blueGrey,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  Gaps.vGap5,
                  Text('${book?.shortIntro}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.textGrey14),
                  Gaps.vGap5,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                          Icon(Icons.person, size: 13, color: Colors.grey),
                          Gaps.hGap5,
                          Text('${book?.author}', style: TextStyles.textGreyC14)
                        ]),
                        TagView(tag: '${book?.majorCate}')
                      ])
                ]),
              )
            ]),
          ),
          onTap: onPressed),
    );
  }
}
