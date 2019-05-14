import 'package:flutter/material.dart';
import 'package:flutter_app/ui/sliver_appbar_delegate.dart';
import 'package:flutter_app/xianyu/bottom_gridview.dart';

class XianyuHomePage extends StatefulWidget {
  XianyuHomePage({Key key}) : super(key: key);

  @override
  createState() => _XianyuHomePageState();
}

class _XianyuHomePageState extends State<XianyuHomePage>
    with SingleTickerProviderStateMixin {
  List<String> titleTabs = ['关注', "新鲜", "附近", "手机", "数码", "租房", "服装"];

  List<Tab> tabs = [];
  TabController controller;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();

    tabs = titleTabs.map((title) {
      return Tab(text: "$title");
    }).toList();

    controller = TabController(
        length: titleTabs.length, vsync: this, initialIndex: currentIndex)
      ..addListener(() {
        // 监听滑动/点选位置
        if (controller.index.toDouble() == controller.animation.value) {
          setState(() => currentIndex = controller.index);
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: Colors.yellowAccent,
          elevation: 0,
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(children: <Widget>[
              Icon(Icons.search, color: Colors.grey[300]),
              Text('关键字',
                  style: TextStyle(fontSize: 14, color: Colors.grey[300]))
            ]),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          automaticallyImplyLeading: false,
          leading: Container(
              child: Text('闲鱼',
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.settings_overscan, color: Colors.black),
                onPressed: () {})
          ]),
      body: CustomScrollView(
        slivers: <Widget>[
          /// 上面部分
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                '这里是tabBar上面的部分',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              height: 200.0,
              color: Colors.pinkAccent.withOpacity(0.8),
            ),
          ),

          /// TabBar部分
          SliverPersistentHeader(
              delegate: SliverAppBarDelegate(TabBar(
                  tabs: tabs,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  controller: controller,
                  isScrollable: true,
                  indicatorColor: Colors.yellowAccent)),
              // 悬停到顶部
              pinned: true),

          /// 瀑布流部分
          SliverToBoxAdapter(child: BottomGridView(index: currentIndex)),
        ],
      ),
    );
  }
}
