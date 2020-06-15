import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Text Widget")),
        body: Column(children: builderTextWidget(context)));
  }

  /// 其中Text的相关属性：
  /// textAlign 文本对齐方式（center居中，left左对齐，right右对齐，justfy两端对齐）
  /// softWrap 是否自动换行（true自动换行，false单行显示，超出屏幕部分默认截断处理）
  /// textDirection 文本方向（ltr从左至右，rtl从右至左）
  /// locale
  /// overflow 文字超出屏幕之后的处理方式（clip裁剪，fade渐隐，ellipsis省略号）
  /// textScaleFactor 字体显示倍率
  /// maxLines 文字显示最大行数
  /// semanticsLabel
  /// style 样式

  /// style 的相关属性：
  /// color 颜色
  /// decoration 文字装饰线（none没有线，lineThrough删除线，overline上划线，underline下划线）
  /// decorationColor 装饰线颜色
  /// decorationStyle 装饰线样式
  /// fontSize 大小
  /// fontStyle 文字样式（italic斜体，normal正常体）
  /// fontFamily 字体
  /// fontWeight 字体粗细（bold粗体，normal正常体）
  /// height 跨度
  /// letterSpacing 字母间隙（如果是负值，会让字母变得更紧凑）
  /// wordSpacing 单词间隙（如果是负值，会让单词变得更紧凑）
  /// shadows 阴影
  /// background 背景
  /// foreground 前置背景
  List<Widget> builderTextWidget(BuildContext context) {
    return <Widget>[
      Text(
          '默认 Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.'),
      Text(
        '文本对齐方式 Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        textAlign: TextAlign.right, // 文本对齐方式
      ),
      Text(
        '自动换行 Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        softWrap: false, // true时会自动换行处理；false时会判定为有无限的水平空间，不会换行
      ),
      Text('文本加粗 Flutter',
          maxLines: 1, //最大行数
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold, // 加粗
          )),
      Text(
        '文本溢出处理 Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
        overflow: TextOverflow.ellipsis, // 溢出处理，这里ellipsis将多余的内容设置为...
      ),
      Text(
          'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.',
          //TextDirection.ltr从左至右，TextDirection.rtl从右至左
          textDirection: TextDirection.rtl),
      Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
              'Flutter allows you to build beautiful native apps on iOS and Android from a single codebase.')),
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
              fontStyle: FontStyle.italic,
              // 字体样式
              letterSpacing: 2,
              // 字母或字间距
              wordSpacing: 5,
              // 单词间距
              height: 2,
              // 行高，值为字体大小的倍数
              fontFamily: 'serif')),
      Text('带阴影文本',
          style: TextStyle(

              /// 阴影
              shadows: [
                Shadow(color: Colors.red, offset: Offset(1, 1), blurRadius: 5)
              ])),
      Text('文本虚下划线',
          style: TextStyle(
            decoration: TextDecoration.underline, // 文本装饰，下划线
            decorationColor: Colors.blue, // 文本装饰颜色
            decorationStyle: TextDecorationStyle.dotted, // 文本装饰样式，虚线
          )),
      Text('文本双删除线',
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
          )),
      Text('文本上划线',
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
              fontFamily: 'serif')),
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
                    decorationStyle: TextDecorationStyle.solid)),
            TextSpan(
                text: ' to build beautiful native apps',
                style: TextStyle(fontSize: 18)),
            TextSpan(
                text: ' on iOS and Android',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: ' from a single codebase.',
                style: TextStyle(shadows: [
                  Shadow(color: Colors.black38, offset: Offset(3, 3))
                ])),
            TextSpan(
                text: '点击试试',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Toast.show(context, '你点击了“点击试试”');
                  }),
          ])),
      Wrap(children: <Widget>[
        Baseline(
            baseline: 30.0,
            baselineType: TextBaseline.alphabetic,
            child: Text('AAAAA汉字',
                style: TextStyle(
                    fontSize: 12.0, textBaseline: TextBaseline.alphabetic))),
        Baseline(
            baseline: 30.0,
            baselineType: TextBaseline.alphabetic,
            child: Text('BBB',
                style: TextStyle(
                    fontSize: 32.0, textBaseline: TextBaseline.alphabetic)))
      ])
    ];
  }
}
