import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ChoiceGenderPage extends StatefulWidget {
  ChoiceGenderPage({Key key}) : super(key: key);

  @override
  createState() => _ChoiceGenderPageState();
}

class _ChoiceGenderPageState extends State<ChoiceGenderPage> {
  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Stack(
              children: <Widget>[
                AppBar(automaticallyImplyLeading: false),
                Positioned(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('请选择您的性别',
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 30)),
                          Gaps.vGap10,
                          Text('根据性别为您推荐最合适的书籍',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18))
                        ]),
                    top: Utils.navigationBarHeight,
                    left: 0),
                Center(
                  child: Row(children: <Widget>[
                    IconButton(
                        icon: Icon(CustomIcon.man, color: Colors.blueAccent),
                        iconSize: 80,
                        onPressed: () => pushNewPage(context, ChoiceTagPage())),
                    IconButton(
                        icon: Icon(CustomIcon.women, color: Colors.redAccent),
                        iconSize: 80,
                        onPressed: () => pushNewPage(context, ChoiceTagPage())),
                  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                )
              ],
            ),
          )),
    );
  }
}
