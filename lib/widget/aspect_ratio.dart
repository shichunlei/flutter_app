import 'package:flutter/material.dart';

/// 尝试将子项调整为特定宽高比的 widget。
/// widget 首先尝试布局约束所允许的最大宽度。通过给定的宽高比来确定小部件的高度，表示为宽度与高度的比率。

class AspectRatioSample extends StatelessWidget {
  AspectRatioSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('AspectRatio')),
        body: Column(
          children: [
            Container(
              width: 300, // 限定一下宽度
              child: AspectRatio(
                aspectRatio: 16.0 / 9.0, // 设置宽高比为16:9
                child: Image.asset(
                  'images/right.jpg',
                  fit: BoxFit.fill, //需设置一下裁剪模式来查看效果
                ),
              ),
            ),
            Container(
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0, // 设置宽高比为16:9
                child: Image.asset(
                  'images/right.jpg',
                  fit: BoxFit.cover, //需设置一下裁剪模式来查看效果
                ),
              ),
            ),
          ],
        ));
  }
}
