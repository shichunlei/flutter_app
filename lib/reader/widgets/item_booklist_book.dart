import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemBookListBook extends StatelessWidget {
  final Books book;
  final VoidCallback onPressed;

  ItemBookListBook({Key key, this.onPressed, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            onTap: onPressed,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        ImageLoadView('${book?.book?.cover}',
                            height: 80, width: 60),
                        Gaps.hGap5,
                        Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                              Row(
                                  children: <Widget>[
                                    Text('${book?.book?.title}'),
                                    TagView(tag: '追更新')
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween),
                              Gaps.vGap5,
                              Row(children: <Widget>[
                                Icon(Icons.person,
                                    size: 13, color: Colors.grey),
                                Gaps.hGap5,
                                Text('${book?.book?.author}',
                                    style: TextStyles.textGrey12)
                              ]),
                              Gaps.vGap10,
                              Text(
                                  '${book?.book?.minorCate}\t\t${book?.book?.wordCount}',
                                  style: TextStyles.textGrey12)
                            ]))
                      ]),
                      Offstage(
                          offstage: book?.comment == null,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Line(margin: EdgeInsets.symmetric(vertical: 5),color: Colors.grey),
                                Text('${book?.comment}',
                                    style: TextStyles.textGrey14)
                              ]))
                    ]))));
  }
}
