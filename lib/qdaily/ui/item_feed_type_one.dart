import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemFeedTypeOne extends StatelessWidget {
  final FeedsBean feedsBean;
  final VoidCallback onTap;

  ItemFeedTypeOne({Key key, @required this.feedsBean, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Utils.width;

    return Material(
      color: Colors.white,
      child: InkWell(
          child: Container(
            child: Row(children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      height: width * 0.4 * 185 / 245,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${feedsBean?.post?.title}',
                                maxLines: 3,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                            ItemBottomView(post: feedsBean?.post)
                          ]))),
              Expanded(
                  flex: 2,
                  child: ImageLoadView('${feedsBean?.image}',
                      height: width * 0.4 * 185 / 245, width: width * 0.4))
            ]),
          ),
          onTap: onTap),
    );
  }
}
