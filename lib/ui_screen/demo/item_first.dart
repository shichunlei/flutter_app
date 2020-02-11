import 'package:flutter/material.dart';

class ItemFirst extends StatelessWidget {
  ItemFirst({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Text('台账编号：13132131313'),
                  OutlineButton(
                    onPressed: () {},
                    child: Text('外场接单'),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Text('报关单号：2342244343423424243'),
              Text('台账类型：null'),
              Text('登记时间：2020-11-22 12:23:22'),
              Text('登记人：李四'),
              Row(
                children: <Widget>[
                  OutlineButton(
                    onPressed: () {},
                    child: Text('详情'),
                  ),
                  OutlineButton(
                    onPressed: () {},
                    child: Text('异常接入'),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('去完成'),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ],
          ),
        ),
      ),
    );
  }
}
