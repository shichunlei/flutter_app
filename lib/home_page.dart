import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/he_weather.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';

import 'music_player/widgets/song_player_bar.dart';
import 'page_index.dart';

import 'package:flutter/scheduler.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'generated/i18n.dart';

class HomePage extends StatefulWidget {
  @override
  createState() => HomeStatePage();
}

class HomeStatePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Location location;

  /// 上次点击时间
  DateTime _lastPressedAt;

  HeWeather weather;
  String city = '正在定位...';

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
      // 设置EasyRefresh的默认样式
      EasyRefresh.defaultHeader = ClassicalHeader(
          enableInfiniteRefresh: false,
          refreshText: S.of(context).pullToRefresh,
          refreshReadyText: S.of(context).releaseToRefresh,
          refreshingText: S.of(context).refreshing,
          refreshedText: S.of(context).refreshed,
          refreshFailedText: S.of(context).refreshFailed,
          noMoreText: S.of(context).noMore,
          infoText: S.of(context).updateAt);
      EasyRefresh.defaultFooter = ClassicalFooter(
          enableInfiniteLoad: true,
          loadText: S.of(context).pushToLoad,
          loadReadyText: S.of(context).releaseToLoad,
          loadingText: S.of(context).loading,
          loadedText: S.of(context).loaded,
          loadFailedText: S.of(context).loadFailed,
          noMoreText: S.of(context).noMore,
          infoText: S.of(context).updateAt);
    });

    _location();
  }

  @override
  void dispose() {
    AmapLocation.stopLocation();

    super.dispose();
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
            backgroundColor: Colors.grey[200],
            key: _scaffoldKey,
            appBar: AppBar(
                centerTitle: false,
                title: InkWell(
                  onTap: () {
                    if (city != '正在定位...') {
                      SpUtil.setString("current_city", city);
                      pushNewPage(context, WeatherPage(city));
                    }
                  },
                  child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text('$city', style: TextStyle(fontSize: 17.0)),
                          Icon(Icons.keyboard_arrow_down)
                        ], mainAxisSize: MainAxisSize.min),
                        Text(
                            '${weather?.now?.cond_txt ?? ''} ${weather?.now?.tmp ?? ''}',
                            style: TextStyle(fontSize: 13.0))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center),
                ),
                elevation: 4.0,
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.refresh, semanticLabel: "refresh"),
                      onPressed: () => getTestData(),
                      tooltip: "Tune")
                ]),
            body: ListView(
                physics: BouncingScrollPhysics(),
                children: _buildListBody(context)),
            bottomNavigationBar: SongPlayerBar(),
            drawer: Drawer(child: HomeDrawable())));
  }

  List<Widget> _buildListBody(BuildContext context) {
    List<Widget> widgets = [];

    widgets
      ..add(AspectRatio(
          aspectRatio: 108 / 72,
          child: Swiper(
              itemBuilder: (context, index) =>
                  ImageLoadView(bannerImages[index]),
              itemCount: 4,
              pagination: SwiperPagination(
                  builder: SwiperPagination.fraction,
                  alignment: Alignment.bottomRight),
              autoplay: true)))
      ..add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      height: 86,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.purple,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(3, 3),
                                color: Colors.black12,
                                blurRadius: 5),
                            BoxShadow(
                                offset: Offset(-3, -3),
                                color: Colors.black12,
                                blurRadius: 5)
                          ]),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.purple,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(5, 5),
                                                color: Colors.black12,
                                                blurRadius: 5),
                                            BoxShadow(
                                                offset: Offset(-5, -5),
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: Icon(Icons.ac_unit,
                                          size: 28, color: Colors.cyan)),
                                  Text('未完成')
                                ]),
                            Positioned(top: 10, child: Text('100'), right: 0)
                          ])))),
              SizedBox(width: 8),
              Expanded(
                  child: Container(
                      height: 86,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(3, 3),
                              color: Colors.black12,
                              blurRadius: 5),
                          BoxShadow(
                              offset: Offset(-3, -3),
                              color: Colors.black12,
                              blurRadius: 5)
                        ],
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Stack(children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Theme.of(context).primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(5, 5),
                                                color: Colors.black12,
                                                blurRadius: 5),
                                            BoxShadow(
                                                offset: Offset(-5, -5),
                                                color: Colors.black12,
                                                blurRadius: 5)
                                          ]),
                                      child: Icon(Icons.ac_unit,
                                          size: 28, color: Colors.cyan)),
                                  Text('未完成')
                                ]),
                            Positioned(right: 0, top: 10, child: Text('100'))
                          ]))))
            ],
          )))
      ..addAll(ExpandStateBean.expandStateList
          .map((value) => ExpansionTile(
              title: Text('${value.title}'),
              backgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.025),
              children: value.children
                  .map((child) => ListTile(
                      contentPadding: EdgeInsets.only(left: 30, right: 20),
                      title: Text(child.title),
                      onTap: () => pushNewPage(context, child.page),
                      trailing: Icon(Icons.keyboard_arrow_right)))
                  .toList(),
              onExpansionChanged: (bool value) {},
              leading: Icon(value.leading)))
          .toList());
    return widgets;
  }

  /// 监听返回键，点击两下退出程序
  Future<bool> _onBackPressed() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      debugPrint("菜单打开着");
    } else if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      debugPrint("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      Toast.show(context, "再按一次退出");
      return false;
    }
    return true;
  }

  Future<void> _location() async {
    if (await PermissionsUtil.requestMapPermission()) {
      location = await AmapLocation.fetchLocation();
      city = await location.district;
      String province = await location?.province;
      debugPrint("-----------------------------$province");

      if (city == null || city == "") {
        city = "北京";
      }
      if (mounted) setState(() {});
      await getWeatherData(city);
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('权限不足')));
    }
  }

  Future getWeatherData(String city) async {
    weather = await ApiService.getHeWeatherNow(city);
    if (mounted) setState(() {});
  }

  void getTestData() async {}
}
