import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';

class ItemLore extends StatelessWidget {
  final WikiListBean wiki;

  ItemLore({Key key, this.wiki}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 116,
          child: Row(children: <Widget>[
            Visibility(
                visible: wiki.imgUrl != "",
                child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ImageLoadView('${wiki.imgUrl}', width: 100))),
            Expanded(
              child: Column(children: [
                Text('${wiki.title}',
                    style: TextStyle(color: Colors.black, fontSize: 17)),
                Text('${wiki.description}',
                    style: TextStyle(color: Colors.black45, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Spacer(),
                Container(
                    width: double.infinity,
                    child: Text('查看详情',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Colors.blue, fontSize: 14)))
              ], crossAxisAlignment: CrossAxisAlignment.start),
            )
          ]),
        ));
  }
}
