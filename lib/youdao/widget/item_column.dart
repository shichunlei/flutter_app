import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemColumn extends StatelessWidget {
  final ColumnsBean columnBean;

  ItemColumn({Key key, this.columnBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5),
        child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(children: <Widget>[
                ImageLoadView('${columnBean.img}',
                    height: Utils.width * 362 / 1125),
                Text('${columnBean.title}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25))
              ], alignment: Alignment.center),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => ItemCourse(
                      course: columnBean.courseCards[index],
                      onPressed: () => pushNewPage(
                          context,
                          WebViewPage(
                              url: "${columnBean.courseCards[index].url}",
                              title:
                                  '${columnBean.courseCards[index].courseTitle}'))),
                  itemCount: columnBean.courseCards.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false)
            ],
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false));
  }
}
