import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemReview extends StatelessWidget {
  final BookReviews review;

  ItemReview({Key key, @required this.review}) : super(key: key);

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
                  ImageLoadView('${review?.author?.avatar}',
                      height: 25, width: 25, shape: BoxShape.circle),
                  Gaps.hGap5,
                  Text('${review?.author?.nickname}',
                      style: TextStyles.textGrey14),
                  Gaps.hGap5,
                  TagView(
                      tag: 'Lv${review?.author?.lv}',
                      textColor:
                          review.author.lv > 5 ? Colors.blueAccent : null,
                      borderColor:
                          review.author.lv > 5 ? Colors.blueAccent : null)
                ]),
                Gaps.vGap5,

                /// 评分
                Row(children: <Widget>[
                  SmoothStarRating(
                      rating: review?.rating?.toDouble(),
                      size: 15,
                      allowHalfRating: false,
                      color: starColor,
                      borderColor: Colors.grey),
                  Text('${review?.ratingDesc}', style: TextStyles.textGrey12)
                ]),
                Gaps.vGap5,

                /// title
                Text('${review?.title}',
                    style: TextStyles.textBoldDark16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                Gaps.vGap5,

                /// content
                Text('${review?.content}',
                    style: TextStyles.textGrey14,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                Gaps.vGap5,

                /// 时间/回复/赞
                Row(children: <Widget>[
                  Text('${friendlyDateTime(review?.created)}',
                      style: TextStyles.textGrey12),
                  Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Icon(Feather.message_square, size: 15, color: Colors.grey),
                    Gaps.hGap5,
                    Text('${review?.commentCount}',
                        style: TextStyles.textGrey12),
                    Gaps.hGap10,
                    Icon(Feather.thumbs_up, size: 15, color: Colors.grey),
                    Gaps.hGap5,
                    Text('${review?.helpful?.yes}',
                        style: TextStyles.textGrey12)
                  ])
                ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
              ],
            ),
          ),
          onTap: () {}),
    );
  }
}
