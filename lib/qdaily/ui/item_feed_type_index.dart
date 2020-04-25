import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemFeedTypeIndex extends StatelessWidget {
  final VoidCallback onTap;
  final FeedsBean feedsBean;

  ItemFeedTypeIndex({Key key, @required this.feedsBean, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  ImageLoadView('${feedsBean?.post?.column?.icon}',
                      shape: BoxShape.circle, width: 30, height: 30),
                  Gaps.hGap8,
                  Text('${feedsBean?.post?.column?.name}')
                ]),
                Gaps.vGap8,
                Row(children: <Widget>[
                  Container(
                      child: Image.asset('images/qdaily/yellowDot.png',
                          fit: BoxFit.fitWidth, width: 30, height: 30)),
                  Expanded(child: Text('${feedsBean.post.title}', maxLines: 3)),
                  ImageLoadView('${feedsBean.image}', width: 96, height: 57)
                ]),
                Gaps.vGap8,
                Row(children: <Widget>[
                  Container(
                      child: Image.asset('images/qdaily/yellowDot.png',
                          fit: BoxFit.fitWidth, width: 30, height: 30)),
                  Expanded(child: Text('${feedsBean.newsList[0].description}')),
                ]),
                Divider(),
                Row(children: <Widget>[
                  Container(
                      child: Image.asset('images/qdaily/yellowDot.png',
                          fit: BoxFit.fitWidth, width: 30, height: 30)),
                  Expanded(child: Text('${feedsBean.newsList[1].description}')),
                ]),
                Gaps.vGap8,
                ItemBottomView(post: feedsBean?.post)
              ],
            )));
  }
}
