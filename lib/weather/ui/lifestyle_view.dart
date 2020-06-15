import 'package:flutter/material.dart';
import 'package:flutter_app/bean/index.dart';
import 'package:flutter_app/ui/line.dart';

class LifestyleView extends StatelessWidget {
  final List<Lifestyle> lifestyle;

  LifestyleView(this.lifestyle, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      color: Color(0x2a000000),
      padding: EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('生活指数', style: TextStyle(color: Colors.white)),
            Line(),
            ListView.builder(
                padding: EdgeInsets.only(top: 0),
                itemBuilder: (context, index) => Card(
                    color: Color(0x02000000),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(children: <Widget>[
                        Row(children: <Widget>[
                          Text(lifestyle[index].type,
                              style: TextStyle(color: Colors.white)),
                          Text(lifestyle[index].brf,
                              style: TextStyle(color: Colors.white))
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Container(
                            height: 0.2,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 5.0)),
                        Text(lifestyle[index].txt,
                            style: TextStyle(color: Colors.white))
                      ]),
                    )),
                itemCount: lifestyle.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false)
          ]),
    );
  }
}
