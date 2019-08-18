import 'package:flutter/material.dart';

import '../page_index.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset("images/splash.jpg", fit: BoxFit.fitWidth),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    child: CloseButton(),
                    margin: EdgeInsets.only(top: 30)),
                Container(
                    child: Column(children: <Widget>[
                      ColorizeAnimatedTextKit(
                        text: ['摘 ~ 抄'],
                        textStyle: TextStyle(fontSize: 20.0),
                        colors: <Color>[
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red
                        ],
                      ),
                      Gaps.vGap20,
                      TyperAnimatedTextKit(
                          text: ['你喜欢的每一句'],
                          textStyle: TextStyle(fontSize: 20.0))
                    ]),
                    margin: EdgeInsets.only(top: 100))
              ]),
              Container(
                  child: FlatButton(
                      onPressed: () {
                        /// TODO 句子迷因技术升级，暂时停止访问。
                        /// pushReplacement(context, JuzimiHomePage());
                        Toast.show(context, '句子迷因技术升级，暂时停止访问');
                      },
                      child: Text('进入',
                          style:
                              TextStyle(fontSize: 30.0, color: Colors.grey))),
                  margin: EdgeInsets.only(bottom: 50.0))
            ])
      ]),
    );
  }
}
