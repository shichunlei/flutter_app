import 'package:flutter/material.dart';

import '../page_index.dart';

class AppBarWidget extends StatefulWidget {
  AppBarWidget({Key key}) : super(key: key);

  @override
  createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = [
    Tab(text: '关注'),
    Tab(text: '推按'),
    Tab(text: '视频'),
    Tab(text: '游戏'),
    Tab(text: '音乐'),
    Tab(text: '体育'),
    Tab(text: '生活'),
    Tab(text: '图片'),
  ];

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            /// AppBar是否显示在任务栏顶部
            primary: true,

            /// 标题
            title: Text('渐变颜色的appBar'),

            /// 可以用这种方式设置渐变的AppBar
            flexibleSpace: GradualChangeView(
                rotation: Rotation.LR,
                colors: [Colors.cyan, Colors.blue, Colors.blueAccent]),

            /// 应用程序栏的工具栏部分是多么不透明。值1.0是完全不透明的，值0.0是完全透明的。
            toolbarOpacity: 1,

            /// AppBar底部透明度，设置方式同toolbarOpacity
            bottomOpacity: 0.5,

            /// bottom 一般就是TabBar，也可以是别的
            bottom: TabBar(
                tabs: tabs, isScrollable: true, controller: _controller)),
        body: ListView(children: <Widget>[
          /// App bar with background color
          Container(
              child: AppBar(
                title: Text("Title"),

                /// 导航栏的颜色 默认是 ThemeData 的颜色
                backgroundColor: Colors.orange,

                /// Z轴高度，也就是阴影 默认是4.0 默认就是有高度 阴影的
                elevation: 4.0,

                /// 应用栏材质的亮度。
                brightness: Brightness.dark,
              ),
              margin: EdgeInsets.only(top: 16.0, bottom: 16.0)),

          /// App bar with Action items
          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: AppBar(title: Text("Appbar actions"),

                  /// 右边的icon， 一般的是icon 或者是文字
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.search), onPressed: () {}),
                    IconButton(icon: Icon(Icons.settings), onPressed: () {})
                  ])),

          /// Center text
          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: AppBar(
                  title: Text("Center"),

                  /// title是否居中
                  centerTitle: true)),

          /// IconTheme for the app bar
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
                title: Text("Appbar Icon and Text Theme"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
                iconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme(headline6: TextStyle(color: Colors.black))),
          ),

          /// App bar with the title and subtitle
          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: AppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Title", style: TextStyle(fontSize: 18.0)),
                      Text("subtitle", style: TextStyle(fontSize: 14.0))
                    ]),
              )),

          /// App bar with the title and and icon/image at start
          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: AppBar(
                /// 是否显示返回按钮
                automaticallyImplyLeading: false,
                backgroundColor: Colors.orangeAccent,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FlutterLogo(),
                      Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text("Title with image")),
                    ]),
              )),

          /// App Bar with transparent background
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text("Transparent AppBar"),
                actions: <Widget>[
                  IconButton(icon: Icon(Icons.search), onPressed: () {})
                ],
                iconTheme: IconThemeData(color: Colors.black),
                textTheme: TextTheme(headline6: TextStyle(color: Colors.black))),
          ),

          Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: AppBar(
                  title: Text('AppBar leading'),
                  elevation: 0.0,
                  leading: IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () => Navigator.of(context).pop()))),
        ]));
  }
}
