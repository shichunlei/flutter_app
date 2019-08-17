import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemFeedTypeZero extends StatelessWidget {
  final VoidCallback onTap;
  final FeedsBean feedsBean;
  final bool isNew;
  final String tag;

  ItemFeedTypeZero(
      {Key key,
      this.onTap,
      @required this.feedsBean,
      this.isNew = false,
      this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Utils.width;

    return InkWell(
        child: Container(
          child: Column(children: <Widget>[
            ItemTopView(
                icon: feedsBean.post.column.icon,
                title: feedsBean.post.column.name,
                onPressed: () {}),
            Stack(children: <Widget>[
              Hero(
                  tag: tag,
                  child: ImageLoadView('${feedsBean?.image}',
                      height: width * 43 / 103, width: width)),
              Container(
                  height: width * 43 / 103,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.bottomLeft,
                  child: ImageLoadView('${feedsBean?.post?.category?.imageLab}',
                      height: 50, width: 50)),
              Container(
                  height: width * 43 / 103,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.topRight,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Image.asset(
                          isNew
                              ? 'images/qdaily/icon_lab_vot_new.png'
                              : 'images/qdaily/icon_lab_vot_join.png',
                          height: 47.5,
                          width: 57),
                      isNew
                          ? SizedBox()
                          : Container(
                              child: Text(
                                '${feedsBean?.post?.recordCount}',
                                style: TextStyle(
                                    color: Color(0xFFFFD003),
                                    fontWeight: FontWeight.bold),
                              ),
                              margin: EdgeInsets.only(top: 3))
                    ],
                  )),
            ]),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${feedsBean?.post?.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text('${feedsBean?.post?.description}',
                        style: TextStyle(color: Colors.grey, fontSize: 12))
                  ]),
            )
          ]),
        ),
        onTap: onTap);
  }
}
