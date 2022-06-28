import 'package:flutter/material.dart';

class ScrollNotificationDemo extends StatefulWidget {
  const ScrollNotificationDemo({Key key}) : super(key: key);

  @override
  createState() => _ScrollNotificationDemoState();
}

class _ScrollNotificationDemoState extends State<ScrollNotificationDemo> {
  int _progress = 0;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('ScrollNotificationDemo')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          ScrollMetrics metrics = notification.metrics;
          debugPrint("${metrics.pixels}"); // 当前位置
          debugPrint("${metrics.atEdge}"); //是否在顶部或底部
          debugPrint("${metrics.axis}"); //垂直或水平滚动
          debugPrint("${metrics.axisDirection}"); // 滚动方向是down还是up
          debugPrint("${metrics.extentAfter}"); //视口底部距离列表底部有多大
          debugPrint("${metrics.extentBefore}"); //视口顶部距离列表顶部有多大
          debugPrint("${metrics.extentInside}"); //视口范围内的列表长度
          debugPrint("${metrics.maxScrollExtent}"); //最大滚动距离，列表长度-视口长度
          debugPrint("${metrics.minScrollExtent}"); //最小滚动距离
          debugPrint("${metrics.viewportDimension}"); //视口长度
          debugPrint("${metrics.outOfRange}"); //是否越过边界
          debugPrint('------------------------');

          // 1.判断监听事件的类型
          if (notification is ScrollStartNotification) {
            debugPrint("开始滚动.....");
            setState(() {
              visible = true;
            });
          } else if (notification is ScrollUpdateNotification) {
            // 当前滚动的位置和总长度
            final currentPixel = notification.metrics.pixels;
            final totalPixel = notification.metrics.maxScrollExtent;
            double progress = currentPixel / totalPixel;
            setState(() {
              _progress = (progress * 100).toInt();
            });
            debugPrint(
                "正在滚动：${notification.metrics.pixels} - ${notification.metrics.maxScrollExtent}");
          } else if (notification is ScrollEndNotification) {
            debugPrint("结束滚动....");
            setState(() {
              visible = false;
            });
          }
          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView.builder(
              itemCount: 100,
              itemExtent: 60,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text("item$index"),
              ),
            ),
            Visibility(
              visible: visible,
              child: CircleAvatar(
                radius: 30,
                child: Text("$_progress%"),
                backgroundColor: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
