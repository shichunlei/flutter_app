import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';

class ItemBottomView extends StatelessWidget {
  final PostBean post;

  ItemBottomView({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        Text('${post?.category?.title}',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(width: 5),
        Image.asset('images/qdaily/icon_toolbar_comment.png',
            width: 15, height: 15, color: Colors.grey),
        Text('${post?.commentCount}',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        SizedBox(width: 5),
        Image.asset('images/qdaily/icon_toolbar_like_unpressed.png',
            width: 15, height: 15, color: Colors.grey),
        Text('${post?.praiseCount}',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
        Spacer(),
        Text("${post?.publishTime}",
            style: TextStyle(color: Colors.grey, fontSize: 12))
      ]),
    );
  }
}
