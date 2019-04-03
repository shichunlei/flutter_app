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
              "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1554280920&di=f596f493385c55a20fe45440e5cb14a6&src=http://pic18.nipic.com/20120205/3145425_101322096000_2.jpg",
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
