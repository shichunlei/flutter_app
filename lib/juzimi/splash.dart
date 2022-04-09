import 'package:flutter/material.dart';
import 'package:flutter_app/animation/utils/animations.dart';

import '../page_index.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'home.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(height: double.infinity),
            Image.asset("images/splash.jpg", fit: BoxFit.fitHeight),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                      alignment: Alignment.topLeft,
                      child: CloseButton(),
                      margin: EdgeInsets.only(top: Utils.topSafeHeight, left: 10)),
                  Container(
                      child: Column(children: <Widget>[
                        AnimatedTextKit(animatedTexts: [
                          ColorizeAnimatedText('摘 ~ 抄',
                              textStyle: TextStyle(fontSize: 20.0),
                              colors: [Colors.purple, Colors.blue, Colors.yellow, Colors.red])
                        ]),
                        Gaps.vGap20,
                        AnimatedTextKit(
                            animatedTexts: [TyperAnimatedText('你喜欢的每一句', textStyle: TextStyle(fontSize: 20.0))])
                      ]),
                      margin: EdgeInsets.only(top: 100))
                ]),
                Container(
                  child: BounceInAnimation(
                    delay: const Duration(milliseconds: 400),
                    child: Button(
                      onPressed: () => pushReplacement(context, JuZiMiHomePage()),
                      child: Text('进入', style: TextStyle(fontSize: 20)),
                      textColor: Colors.white,
                      borderRadius: 20,
                      width: Utils.width / 3,
                      height: 40,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 50.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
