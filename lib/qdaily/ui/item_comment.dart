import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';

import '../../page_index.dart';

class ItemComment extends StatelessWidget {
  final QDailyComment comment;

  ItemComment({Key key, @required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Toast.show(context, '@${comment?.author?.name}');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _buildTopView(comment?.author, comment?.publishTime),
                      Container(
                          padding: EdgeInsets.only(left: 28, top: 8, bottom: 8),
                          alignment: Alignment.centerLeft,
                          child: Text('${comment?.content}'))
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: comment.childComments.length,
                    padding: EdgeInsets.only(left: 28, top: 0),
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Toast.show(context,
                                '@${comment?.childComments[index]?.author?.name}');
                          },
                          child: Container(
                            child: Column(children: <Widget>[
                              _buildTopView(
                                  comment?.childComments[index]?.author,
                                  comment?.childComments[index]?.publishTime),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 28, top: 8, bottom: 8),
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: ':',
                                            style: TextStyles.textDark14),
                                        TextSpan(
                                            text:
                                                '${comment?.childComments[index]?.content}',
                                            style: TextStyles.textDark14),
                                      ],
                                      text:
                                          '@${comment?.childComments[index]?.parentUser?.name}',
                                      style: TextStyles.textBlue14),
                                ),
                              )
                            ]),
                          ),
                        ))
              ])),
    );
  }

  Widget _buildTopView(AuthorBean author, int publishTime) {
    return Row(children: <Widget>[
      ImageLoadView('${author?.avatar}',
          width: 25, height: 25, shape: BoxShape.circle),
      Gaps.hGap8,
      Text('${author?.name}'),
      Gaps.hGap8,
      Text(
          "${formatDateByMs(publishTime * 1000, formats: [mm, '月', dd, '日'])}"),
      Spacer(),
      Icon(Feather.thumbs_up, size: 20)
    ]);
  }
}
