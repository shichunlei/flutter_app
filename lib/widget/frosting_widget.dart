import 'package:flutter/material.dart';
import 'dart:ui';

class FrostingWidget extends StatefulWidget {
  @override
  _FrostingWidgetState createState() => _FrostingWidgetState();
}

class _FrostingWidgetState extends State<FrostingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("毛玻璃效果"),
      ),
      body: Stack(
        children: <Widget>[
          /// 约束性盒子,添加额外的约束条件
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Image.network(
              "https://img-blog.csdnimg.cn/20181116224221945.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hhb19tNTgy,size_16,color_FFFFFF,t_70",
            ),
          ),
          Center(
            /// 可裁切的矩形
            child: ClipRect(
              /// 背景过滤器
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 6.0,
                ),

                ///
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    width: 500.0,
                    height: 700.0,

                    /// 盒子修饰器
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(
                        "毛玻璃效果",
                        style: Theme.of(context).textTheme.display3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
