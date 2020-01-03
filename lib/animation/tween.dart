import 'package:flutter/material.dart';

import '../page_index.dart';

class TweenDemo extends StatefulWidget {
  TweenDemo({Key key}) : super(key: key);

  @override
  createState() => _TweenDemoState();
}

class _TweenDemoState extends State<TweenDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  //doubler类型动画
  Animation<double> doubleAnimation;

  //颜色动画
  Animation<Color> colorAnimation;

  //位置动画
  Animation<Offset> offsetAnimation;

  //圆角动画
  Animation<BorderRadius> radiusAnimation;

  //装饰动画
  Animation<Decoration> decorationAnimation;

  //字体动画
  Animation<TextStyle> textStyleAnimation;

  @override
  void initState() {
    super.initState();
    //创建AnimationController
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    //animation第一种创建方式：
    doubleAnimation = Tween<double>(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        //执行完成后反向执行
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //反向执行完成，正向执行
          controller.forward();
        }
      });

    //animation第二种创建方式：
    offsetAnimation = controller
        .drive(Tween<Offset>(begin: Offset.zero, end: Offset(400.0, 200.0)));

    colorAnimation =
        ColorTween(begin: Colors.yellow, end: Colors.red).animate(controller);

    radiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(0), end: BorderRadius.circular(50))
        .animate(controller);

    decorationAnimation = DecorationTween(
            begin: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(0)),
            end: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(40)))
        .animate(controller);

    textStyleAnimation = TextStyleTween(
            begin: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w100),
            end: TextStyle(
                color: Colors.purple,
                fontSize: 30,
                fontWeight: FontWeight.w700))
        .animate(controller);

    //启动动画
    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('TweenDemo')),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Container(
                    height: doubleAnimation.value,
                    width: doubleAnimation.value,
                    child: FlutterLogo(),
                  ),
                ),
                Gaps.vGap10,
                Container(
                  margin: EdgeInsets.only(left: offsetAnimation.value.dx),
                  width: 50,
                  height: 50,
                  color: Colors.green,
                ),
                Gaps.vGap10,
                Container(
                  height: 100,
                  width: 100,
                  color: colorAnimation.value,
                ),
                Gaps.vGap10,
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: radiusAnimation.value, color: Colors.blue),
                ),
                Gaps.vGap10,
                Container(
                  height: 60,
                  width: 200,
                  decoration: decorationAnimation.value,
                ),
                Gaps.vGap10,
                Container(
                  height: 100,
                  child: Text(
                    "TestStyleTween",
                    style: textStyleAnimation.value,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
