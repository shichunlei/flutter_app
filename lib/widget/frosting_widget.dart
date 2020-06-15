import 'package:flutter/material.dart';
import 'dart:ui';

import '../page_index.dart';

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
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 可裁切的矩形
                ClipRect(
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
                        width: 100.0,
                        height: 100.0,

                        /// 盒子修饰器
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                        child: Center(
                          child: Text("毛玻璃效果"),
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.hGap8,
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  /// 背景过滤器
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5.0,
                      sigmaY: 6.0,
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      color: Colors.white10,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'BackdropFilter class',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'A widget that applies a filter to the existing painted content and then paints child.'
                              'The filter will be applied to all the area within its parent or ancestor widget\'s clip. If there\'s no clip, the filter will be applied to the full screen.',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.hGap8,
                ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      color: Colors.white10,
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                        iconSize: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
