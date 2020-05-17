import 'package:flutter/material.dart';
import 'package:flutter_app/bean/image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';

class SliverPage extends StatefulWidget {
  SliverPage({Key key}) : super(key: key);

  @override
  createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage>
    with SingleTickerProviderStateMixin {
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
  double bannerHeight = 200;
  double viewHeight = 100;

  Brightness brightness = Brightness.dark;
  Color barIconColor = Colors.white;

  @override
  void initState() {
    super.initState();

    headerHeight = viewHeight + bannerHeight;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset <= headerHeight && offset >= 0) {
        setState(() {
          navAlpha = 1 - (headerHeight - offset) / headerHeight;
          if (navAlpha > 0.5) {
            brightness = Brightness.light;
          } else {
            brightness = Brightness.dark;
          }
          barIconColor = Color.fromARGB(255, (255 - 255 * navAlpha).toInt(),
              (255 - 255 * navAlpha).toInt(), (255 - 255 * navAlpha).toInt());
        });
      }
    });

    tabs = titleTabs.map((title) => Tab(text: "$title")).toList();

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
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: NestedScrollView(
            controller: scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                        brightness: brightness,
                        automaticallyImplyLeading: false,
                        elevation: 0.0,
                        pinned: true,
                        backgroundColor: Colors.white,
                        forceElevated: innerBoxIsScrolled,
                        expandedHeight: headerHeight - Utils.topSafeHeight,
                        centerTitle: true,
                        title: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: barIconColor),
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Row(children: <Widget>[
                              Icon(Icons.search, color: Colors.grey[300]),
                              Text('关键字',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey[300]))
                            ])),
                        leading: Container(
                            child: Icon(CustomIcon.xianyu,
                                color: barIconColor, size: 45),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20)),
                        actions: <Widget>[
                          IconButton(
                              icon: Icon(CustomIcon.scan, color: barIconColor),
                              onPressed: () {})
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(children: <Widget>[
                            /// 顶部banner部分
                            Container(
                                height: bannerHeight,
                                child: Swiper(
                                    itemBuilder: (context, index) =>
                                        ImageLoadView(bannerImages[index]),
                                    itemCount: 4,
                                    pagination: SwiperPagination(
                                        builder: SwiperPagination.fraction,
                                        alignment: Alignment.bottomRight),
                                    autoplay: true)),

                            /// TabBar上面部分，（如果TabBar上面纵向有多个控件应尽可能多的将控件放到此处）
                            Container(
                                padding: EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: Text('这里是tabBar上面的部分',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24.0)),
                                height: 100.0,
                                color: Colors.pinkAccent.withOpacity(0.8))
                          ]),
                        ))),

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
                    pinned: true)
              ];
            },
            body: TabBarView(
                controller: controller,
                children: titleTabs.map((view) {
                  return BottomGridView(title: titleTabs[currentIndex]);
                }).toList())));
  }
}

class BottomGridView extends StatefulWidget {
  final int index;
  final String title;

  BottomGridView({Key key, this.index, this.title}) : super(key: key);

  @override
  createState() => BottomGridViewState();
}

class BottomGridViewState extends State<BottomGridView>
    with AutomaticKeepAliveClientMixin {
  List<ImageModal> images = [];

  @override
  void initState() {
    super.initState();
    getListData(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double itemWidth = Utils.width / 2 - 4;

    return images.isEmpty
        ? Center()
        : StaggeredGridView.countBuilder(
            padding: EdgeInsets.only(top: Utils.navigationBarHeight),
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) => ImageLoadView(
                  images[index].thumb,
                  width: itemWidth,
                  height:
                      itemWidth * images[index].height / images[index].width,
                ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            itemCount: images.length);
  }

  void getListData(String key) async {
    images = [];
    images = await ApiService.getImagesData(key);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;
}
