import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';

import 'item_bottom_view.dart';

class ItemFeedTypeTwo extends StatelessWidget {
  final VoidCallback onTap;
  final FeedsBean feedsBean;
  final double width;

  ItemFeedTypeTwo({Key key, this.onTap, @required this.feedsBean, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = width;
    if (_width == null || _width == 0) {
      _width = Utils.width;
    }

    return InkWell(
        child: Container(
          width: _width,
          child: Column(children: <Widget>[
            ImageLoadView('${feedsBean?.image}',
                height: _width * 14 / 25, width: _width),
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
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 5),
                    ItemBottomView(post: feedsBean?.post)
                  ]),
            )
          ]),
        ),
        onTap: onTap);
  }
}
