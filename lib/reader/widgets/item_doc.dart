import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemDoc extends StatelessWidget {
  final DocsBean doc;

  ItemDoc({Key key, @required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// 作者
                Row(children: <Widget>[
                  ImageLoadView('${doc?.author?.avatar}',
                      height: 25, width: 25, shape: BoxShape.circle),
                  Gaps.hGap5,
                  Text('${doc?.author?.nickname}',
                      style: TextStyles.textGrey14),
                  Gaps.hGap5,
                  TagView(
                      tag: 'Lv${doc?.author?.lv}',
                      textColor: doc.author.lv > 5 ? Colors.blueAccent : null,
                      borderColor: doc.author.lv > 5 ? Colors.blueAccent : null)
                ]),
                Gaps.vGap5,

                /// 评分
                Row(children: <Widget>[
                  SmoothStarRating(
                      rating: doc?.rating?.toDouble(),
                      size: 15,
                      allowHalfRating: false,
                      color: starColor,
                      borderColor: Colors.grey),
                  Text('${doc?.ratingDesc}', style: TextStyles.textGrey12)
                ]),
                Gaps.vGap5,

                /// content
                Text('${doc?.content}',
                    style: TextStyles.textDark14,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                Gaps.vGap5,

                /// 时间/回复/赞
                Row(children: <Widget>[
                  Text('${friendlyDateTime(doc?.created)}',
                      style: TextStyles.textGrey12),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(Feather.thumbs_up, size: 15, color: Colors.grey),
                    Gaps.hGap5,
                    Text('${doc?.likeCount}', style: TextStyles.textGrey12)
                  ])
                ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
              ],
            ),
          ),
          onTap: () {}),
    );
  }
}
