import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class LabInfoHeaderView extends StatelessWidget {
  final PostBean post;
  final String tag;

  LabInfoHeaderView({Key key, this.post, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        AspectRatio(
          child: Stack(fit: StackFit.expand, children: <Widget>[
            Hero(
                tag: tag,
                child: ImageLoadView('${post?.image}', fit: BoxFit.cover)),
            Stack(children: <Widget>[
              Positioned(
                top: 10 + Utils.topSafeHeight,
                right: 10,
                child: Image.asset('images/qdaily/icon_lab_vot_join.png',
                    height: 47.5, width: 57),
              ),
              Positioned(
                top: 10 + Utils.topSafeHeight,
                right: 10,
                child: Container(
                    alignment: Alignment.center,
                    width: 57,
                    child: Text(
                      '${post?.recordCount}',
                      style: TextStyle(
                          color: qdailyMajorColor, fontWeight: FontWeight.bold),
                    ),
                    margin: EdgeInsets.only(top: 3)),
              )
            ]),
          ]),
          aspectRatio: 3 / 2,
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${post?.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('${post?.description}',
                    style: TextStyle(color: Colors.grey))
              ]),
        )
      ]),
    );
  }
}
