import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class BookDetailsHeaderView extends StatelessWidget {
  const BookDetailsHeaderView({
    Key key,
    @required this.pageTopColorStart,
    @required this.pageTopColorEnd,
    @required this.book,
  }) : super(key: key);

  final Color pageTopColorStart;
  final Color pageTopColorEnd;
  final Books book;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: Utils.navigationBarHeight),
        height: 250,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [pageTopColorStart, pageTopColorEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15),
                child: ImageLoadView('${book?.cover}',
                    height: 99, width: 77, fit: BoxFit.cover)),
            Gaps.hGap5,
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap15,
                    Row(children: <Widget>[
                      Text(
                        '${book?.title}',
                        style: TextStyles.textWhite16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.hGap5,
                      TagView(
                          tag: book.isSerial ? '连载' : '完结',
                          textColor: book.isSerial
                              ? Colors.redAccent
                              : readerMainColor,
                          borderColor: book.isSerial
                              ? Colors.redAccent
                              : readerMainColor),
                    ]),
                    Gaps.vGap10,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Icon(Icons.person,
                                size: 16, color: readerMainColor),
                            Text(
                              '${book?.author ?? ""}',
                              style: TextStyles.textReader16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ], mainAxisSize: MainAxisSize.min),
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: 1,
                              color: Colors.white,
                              height: 10),
                          Text('${book?.cat ?? ""}',
                              style: TextStyles.textWhite14)
                        ]),
                    Gaps.vGap10,
                    Text('${book?.wordCount ?? ""}',
                        style: TextStyles.textWhite12)
                  ]),
            )
          ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                            book == null
                                ? '0'
                                : '${book.rating.score.toStringAsFixed(1)}',
                            style:
                                TextStyle(fontSize: 22.0, color: Colors.white)),
                        Gaps.hGap5,
                        SmoothStarRating(
                            rating:
                                (book == null ? 0.0 : book.rating.score / 2.0),
                            size: 15,
                            allowHalfRating: false,
                            color: starColor,
                            borderColor: Colors.grey)
                      ]),
                      Gaps.vGap10,
                      Text('${book?.rating?.count}人评分',
                          style: TextStyles.textWhite14)
                    ]),
                Column(children: <Widget>[
                  Text(
                      book?.retentionRatio == 0
                          ? "暂无统计"
                          : '${book?.retentionRatio}%',
                      style: TextStyle(fontSize: 22.0, color: Colors.white)),
                  Gaps.vGap10,
                  Text('读者留存', style: TextStyles.textWhite14)
                ]),
                Column(children: <Widget>[
                  Text('${book?.latelyFollower}',
                      style: TextStyle(fontSize: 22.0, color: Colors.white)),
                  Gaps.vGap10,
                  Text('7日人气', style: TextStyles.textWhite14)
                ])
              ])
        ]));
  }
}
