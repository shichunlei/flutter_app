import 'package:flutter/material.dart';
import '../index.dart';
import '../../page_index.dart';

class ItemGoodCourse extends StatelessWidget {
  final DiscoverBean discover;
  final VoidCallback onPressed;

  ItemGoodCourse({Key key, this.discover, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Utils.width * 87 / 180,
        width: Utils.width,
        child: Stack(children: <Widget>[
          ImageLoadView(discover.image, width: Utils.width),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${discover.title}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        maxLines: 2),
                    Button(
                        color: Colors.deepOrange,
                        width: 60,
                        height: 26,
                        onPressed: onPressed,
                        text: '查看详情',
                        borderRadius: 24,
                        textSize: 14)
                  ]))
        ]));
  }
}
