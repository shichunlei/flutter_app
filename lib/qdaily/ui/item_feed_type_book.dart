import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class ItemFeedTypeBook extends StatelessWidget {
  final VoidCallback onTap;
  final FeedsBean feed;
  final double width;

  ItemFeedTypeBook({Key key, this.onTap, @required this.feed, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          color: Colors.white,
          child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
            ImageLoadView('${feed?.image}',
                fit: BoxFit.cover, height: width * 250 / 171, width: width),
            Container(
              padding: EdgeInsets.all(5),
              color: Color(0xAAFFFFFF),
              width: width,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Text('${feed?.post?.title}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 5),
                Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset('images/qdaily/icon_toolbar_comment.png',
                      width: 15, height: 15),
                  Text('${feed?.post?.commentCount}',
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                  SizedBox(width: 5),
                  Image.asset('images/qdaily/icon_toolbar_like_unpressed.png',
                      width: 15, height: 15),
                  Text('${feed?.post?.praiseCount}',
                      style: TextStyle(color: Colors.black, fontSize: 12))
                ])
              ]),
            )
          ]),
        ),
        onTap: onTap);
  }
}
