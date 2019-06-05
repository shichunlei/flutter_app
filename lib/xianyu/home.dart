import 'package:flutter/material.dart';
import 'package:flutter_app/xianyu/bottom_gridview.dart';

import '../page_index.dart';

class XianyuHomePage extends StatefulWidget {
  XianyuHomePage({Key key}) : super(key: key);

  @override
  createState() => _XianyuHomePageState();
}

class _XianyuHomePageState extends State<XianyuHomePage>
    with TickerProviderStateMixin {
  List<String> titleTabs = [
    '性感美女',
    "制服",
    "清新美女",
    "校园",
    "古装",
    "动漫",
    "壁纸",
    "苍老师"
  ];

  List<Tab> tabs = [];
  TabController controller;
  int currentIndex = 1;

  ScrollController scrollController = ScrollController();

  /// 透明度 取值范围[0,1]
  double navAlpha = 0;
  double headerHeight;

  GlobalKey<BottomGridViewState> bottomKey = GlobalKey<BottomGridViewState>();

  @override
  void initState() {
    super.initState();

    /// 当tab滑动到标题栏下时切换appBar为渐变的，此处的高度应根据实际项目中tab上面的控件总高度，应根据实际项目中tab上面的控件动态计算高度（即此处的400）
    headerHeight = 400 + Utils.navigationBarHeight - Utils.topSafeHeight;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < headerHeight) {
        setState(() {
          navAlpha = 1 - (headerHeight - offset) / headerHeight;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });

    tabs = titleTabs.map((title) {
      return Tab(text: "$title");
    }).toList();

    controller = TabController(
        length: titleTabs.length, vsync: this, initialIndex: currentIndex)
      ..addListener(() {
        // 监听滑动/点选位置
        if (controller.index.toDouble() == controller.animation.value) {
          setState(() => currentIndex = controller.index);
          bottomKey.currentState.getListData(titleTabs[currentIndex]);
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
      body: Stack(children: <Widget>[
        CustomScrollView(controller: scrollController, slivers: <Widget>[
          /// 顶部部分
          _bildTopView(),

          /// TabBar上面部分，（如果TabBar上面纵向有多个控件应尽可能多的将控件放到此处）
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
          SliverToBoxAdapter(
              child: BottomGridView(
                  key: bottomKey, title: titleTabs[currentIndex])),
        ]),
        Container(
          height: Utils.navigationBarHeight,
          child: AppBar(

              /// AppBar背景随着页面向上滑动逐渐由透明色变为白色，即透明度由0->255
              backgroundColor:
                  Color.fromARGB((navAlpha * 255).toInt(), 255, 255, 255),
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
                      border: Border.all(
                          color: Color.fromARGB(
                              255,
                              (255 - 255 * navAlpha).toInt(),
                              (255 - 255 * navAlpha).toInt(),
                              (255 - 255 * navAlpha).toInt())),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
              automaticallyImplyLeading: false,
              leading: Container(
                  child: Image.asset('images/xianyu.png',

                      /// 左侧图标颜色由白色变为黑色即色值的R G B 均随着滑动变化由255 -> 0
                      color: Color.fromARGB(
                          255,
                          (255 - 255 * navAlpha).toInt(),
                          (255 - 255 * navAlpha).toInt(),
                          (255 - 255 * navAlpha).toInt())),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20)),
              actions: <Widget>[
                IconButton(
                    icon: Icon(CustomIcon.scan,

                        /// 右侧图标颜色由白色变为黑色即色值的R G B 均随着滑动变化由255 -> 0
                        color: Color.fromARGB(
                            255,
                            (255 - 255 * navAlpha).toInt(),
                            (255 - 255 * navAlpha).toInt(),
                            (255 - 255 * navAlpha).toInt())),
                    onPressed: () {})
              ]),
        )
      ]),
    );
  }

  Widget _bildTopView() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      floating: false,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            child: ImageLoadView(backgroundImage,
                fit: BoxFit.cover, height: 200, width: Utils.width)),
      ),
    );
  }
}
