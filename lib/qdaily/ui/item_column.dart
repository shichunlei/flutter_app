import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class ItemColumn extends StatelessWidget {
  final VoidCallback onTap;
  final ColumnBean column;

  ItemColumn({Key key, this.onTap, @required this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Hero(
                  tag: 'cloumn-image-${column.id}',
                  child: ImageLoadView('${column.image}',
                      width: 80, height: 80, fit: BoxFit.cover)),
              Gaps.hGap10,
              Expanded(
                child: Container(
                  height: 85,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${column.name}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${column.description}',
                            overflow: TextOverflow.ellipsis, maxLines: 2),
                        Text(
                            '${column.subscriberNum}人已订阅，更新至${column.postCount}篇',
                            style: TextStyle(fontSize: 13, color: Colors.grey))
                      ]),
                ),
              ),
              Gaps.hGap5,
              Image.asset('images/qdaily/all_column_unsub.png',
                  width: 40, height: 40),
            ]),
          )),
    );
  }
}
