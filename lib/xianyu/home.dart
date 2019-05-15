import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/ui/sliver_appbar_delegate.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/xianyu/bottom_gridview.dart';
import 'package:flutter_app/xianyu/ui/appbar.dart';

class XianyuHomePage extends StatefulWidget {
  XianyuHomePage({Key key}) : super(key: key);

  @override
  createState() => _XianyuHomePageState();
}

class _XianyuHomePageState extends State<XianyuHomePage>
    with TickerProviderStateMixin {
  List<String> titleTabs = ['关注', "新鲜", "附近", "手机", "数码", "租房", "服装"];

  List<Tab> tabs = [];
  TabController controller;
  int currentIndex = 1;

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;
  double headerHeight;

  // 标记是否显示渐变的AppBar
  bool showDeepBar = false;

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
            showDeepBar = false;
          });
        }
      } else if (offset < headerHeight) {
        if (headerHeight - offset <= Utils.navigationBarHeight) {
          setState(() {
            ///
            showDeepBar = true;
          });
        } else {
          ///
          showDeepBar = false;
        }
        setState(() => navAlpha = 1 - (headerHeight - offset) / headerHeight);
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
          showDeepBar = true;
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
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
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
              SliverToBoxAdapter(child: BottomGridView(index: currentIndex)),
            ],
          ),
          showDeepBar
              ? MyAppBar(
                  colors: [Colors.cyan, Colors.blue, Colors.blueAccent],
                  searchViewColor: Colors.white,
                  iconColor: Colors.black,
                  backgroundColor: Colors.blue)
              : MyAppBar(
                  backgroundColor: Colors.transparent,
                  searchViewColor: Colors.transparent,
                  iconColor: Colors.white54,
                  searchViewBoderColor: Colors.white54)
        ],
      ),
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
