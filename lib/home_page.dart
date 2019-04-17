import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home_drawable.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeStatePage();
}

class HomeStatePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 上次点击时间
  DateTime _lastPressedAt;

  @override
  void initState() {
    super.initState();
  }

  void _setCurrentIndex(int index, bool isExpand) {
    setState(() {
      expandStateList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !isExpand;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 实现原理，使用WillPopScope组件，它会检测到子组件的Navigation的pop事件，并拦截下来。
     * 我们需要在它的onWillPop属性中返回一个新的组件（一般是一个Dialog）处理是否真的pop该页面。
     */
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          // Title
          title: Text("Flutter Demo"),
          // Set the background color of the App Bar
          backgroundColor: Colors.pinkAccent,
          elevation: 4.0,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, semanticLabel: "search"),
                onPressed: () {},
                tooltip: "Search"),
            IconButton(
                icon: Icon(Icons.tune, semanticLabel: "tune"),
                onPressed: () {},
                tooltip: "Tune")
          ],
        ),
        drawer: HomeDrawable(),
        body: ListView(
          children: <Widget>[
            Container(
              height: 230.0,
              child: Swiper(
                /// 初始的时候下标位置
                index: 0,

                /// 无限轮播模式开关
                loop: true,

                ///
                itemBuilder: (context, index) {
                  return Image.network(
                    banner_images[index],
                    fit: BoxFit.fill,
                  );
                },

                ///
                itemCount: banner_images.length,

                /// 设置 new SwiperPagination() 展示默认分页指示器
                pagination: SwiperPagination(),

                /// 设置 new SwiperControl() 展示默认分页按钮
                // control: SwiperControl(),

                /// 自动播放开关.
                autoplay: true,

                /// 动画时间，单位是毫秒
                duration: 300,

                /// 当用户点击某个轮播的时候调用
                onTap: (index) {
                  LogUtil.v("你点击了第$index个");
                },

                /// 滚动方向，设置为Axis.vertical如果需要垂直滚动
                scrollDirection: Axis.horizontal,
              ),
            ),
            ExpansionPanelList(
              children: expandStateList
                  .map((expand) => ExpansionPanel(
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            title: Text(expand.title),
                          );
                        },
                        body: ListBody(
                          /// 排列的主轴方向
                          mainAxis: Axis.vertical,

                          /// 是否反向
                          reverse: false,
                          children: _buildListBody(expand),
                        ),
                        isExpanded: expand.isOpen,
                      ))
                  .toList(),
              expansionCallback: (index, isExpand) =>
                  _setCurrentIndex(index, isExpand),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildListBody(ExpandStateBean bean) {
    List<Widget> widgets = [];
    for (int i = 0; i < bean.subExpand.length; i++) {
      widgets
        ..add(ListTile(
          title: Text(bean.subExpand[i].title),
          onTap: () {
            pushNewPage(context, bean.subExpand[i].widget);
          },
        ))
        ..add(Divider());
    }
    return widgets;
  }

  /// 监听返回键，点击两下退出程序
  Future<bool> _onBackPressed() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      LogUtil.v("菜单打开着");
    } else if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      LogUtil.v("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      Toast.show("再按一次退出", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      return false;
    }
    return true;
  }
}
