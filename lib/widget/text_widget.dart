import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  @override
  createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Widget"),
      ),
      body: Column(
        children: builderTextWidget(),
      ),
    );
  }

  /// 设置所有的列
  /// 其中Text的相关属性：
  /// textAlign 对齐方式
  /// softWrap 自动换行
  /// textDirection
  /// locale
  /// overflow 溢出处理
  /// textScaleFactor
  /// maxLines 最大行数
  /// semanticsLabel
  ///
  /// color 颜色
  /// decoration 装饰线
  /// decorationColor 装饰线颜色
  /// decorationStyle 装饰线样式
  /// fontSize 大小
  /// fontStyle 样式
  /// fontFamily 字体
  /// fontWeight 字体粗细
  /// height 跨度
  /// letterSpacing 字母间隔
  /// shadows 阴影
  /// background 背景
  /// foreground 前置背景
  List<Widget> builderTextWidget() {
    return <Widget>[
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        textAlign: TextAlign.center, // 文本对齐方式
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        softWrap: false, // true时会自动换行处理；false时会判定为有无限的水平空间，不会换行
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        maxLines: 1, //最大行数
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold, // 加粗
        ),
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        overflow: TextOverflow.ellipsis, // 溢出处理，这里ellipsis将多余的内容设置为...
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        style: TextStyle(
          // 文本样式
          color: Colors.red,
          // 文本颜色
          fontSize: 20,
          // 字体大小
          fontWeight: FontWeight.w600,
          // 字体粗细程度
          fontStyle: FontStyle.normal,
          // 字体样式
          letterSpacing: 2,
          // 字母或字间距
          wordSpacing: 5,
          // 单词间距
          height: 2,
          // 行高，值为字体大小的倍数
          fontFamily: 'serif',
          shadows: [
            Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 5)
          ], // 阴影
        ),
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        style: TextStyle(
          decoration: TextDecoration.underline, // 文本装饰，下划线
          decorationColor: Colors.blue, // 文本装饰颜色
          decorationStyle: TextDecorationStyle.dotted, // 文本装饰样式，虚线
        ),
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        style: TextStyle(
          decoration: TextDecoration.lineThrough,
          // 文本装饰，删除线
          decorationColor: Colors.blue,
          // 文本装饰颜色
          decorationStyle: TextDecorationStyle.double,
          // 文本装饰样式，双划线
          fontSize: 25.0,
          // 字号
          color: const Color(0xffff9900), // 文字颜色
        ),
      ),
      Text(
        'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        style: TextStyle(
          decoration: TextDecoration.overline,
          // 文本装饰，上划线
          decorationColor: Colors.red,
          // 文本装饰颜色
          decorationStyle: TextDecorationStyle.solid,
          // 文本装饰样式
          fontSize: 15.0,
          // 字号
          fontStyle: FontStyle.italic,
          // 字体样式，倾斜
          fontFamily: 'serif', // 字体
        ),
      ),
      RichText(
        // RichText
        text: TextSpan(
          text: 'Flutter',
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: ' allows you',
              style: TextStyle(
                color: Colors.green,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
            TextSpan(
                text: ' to build beautiful native apps',
                style: TextStyle(
                  fontSize: 18,
                )),
            TextSpan(
                text: ' on iOS and Android',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: ' from a single codebase.',
                style: TextStyle(
                  shadows: [
                    Shadow(color: Colors.black38, offset: Offset(3, 3))
                  ],
                )),
          ],
        ),
      )
    ];
  }
}
