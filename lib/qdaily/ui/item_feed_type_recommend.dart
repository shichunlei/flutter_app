import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';

class ItemFeedTypeRecommend extends StatelessWidget {
  final VoidCallback onTap;
  final PostBean post;

  ItemFeedTypeRecommend({Key key, this.onTap, @required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          height: Utils.width * 2 / 3.5,
          margin: EdgeInsets.only(top: 5),
          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            ImageLoadView('${post.image}',
                height: Utils.width * 2 / 3, width: Utils.width),
            Container(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 3),
                        child: Text('${post.categoryTile}',
                            style: TextStyle(
                                color: Color(0xFFFFC81F), fontSize: 12)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Color.fromRGBO(0, 0, 0, 0.4)),
                    Text('${post.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    Row(children: <Widget>[
                      Image.asset('images/qdaily/icon_toolbar_comment.png',
                          width: 15, height: 15, color: Colors.white),
                      Text('${post?.commentCount}',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      SizedBox(width: 5),
                      Image.asset(
                          'images/qdaily/icon_toolbar_like_unpressed.png',
                          width: 15,
                          height: 15,
                          color: Colors.white),
                      Text('${post?.praiseCount}',
                          style: TextStyle(color: Colors.white, fontSize: 12))
                    ])
                  ]),
              padding: EdgeInsets.all(8),
            )
          ]),
        ),
        onTap: onTap);
  }
}
