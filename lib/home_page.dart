import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'generated/l10n.dart';
import 'music_player/widgets/song_player_bar.dart';
import 'page_index.dart';
import 'store/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  createState() => HomeStatePage();
}

class HomeStatePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription<Map<String, Object>> _locationListener;

  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();

  /// 上次点击时间
  DateTime _lastPressedAt;

  ScrollController controller;

  double offset = 0.0;
  double navAlpha = 0;

  @override
  void initState() {
    super.initState();

    controller = ScrollController()
      ..addListener(() {
        offset = controller.offset;

        if (offset <= 200 && offset >= 0) {
          setState(() {
            navAlpha = 1 - (200 - offset) / 200;
          });
        }
      });

    SchedulerBinding.instance.addPostFrameCallback((callback) {
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

    /// 设置是否已经包含高德隐私政策并弹窗展示显示用户查看，如果未包含或者没有弹窗展示，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    /// <b>必须保证在调用定位功能之前调用， 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// [hasContains] 隐私声明中是否包含高德隐私政策说明
    ///
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// 设置是否已经取得用户同意，如果未取得用户同意，高德定位SDK将不会工作
    ///
    /// 高德SDK合规使用方案请参考官网地址：https://lbs.amap.com/news/sdkhgsy
    ///
    /// <b>必须保证在调用定位功能之前调用, 建议首次启动App时弹出《隐私政策》并取得用户同意</b>
    ///
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    _location();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Store.value<WeatherModel>(context);

    /**
     * 实现原理，使用WillPopScope组件，它会检测到子组件的Navigation的pop事件，并拦截下来。
     * 我们需要在它的onWillPop属性中返回一个新的组件（一般是一个Dialog）处理是否真的pop该页面。
     */
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            key: _scaffoldKey,
            body: Stack(children: [
              ListView(
                  controller: controller,
                  padding: EdgeInsets.only(bottom: 60.0 + Utils.bottomSafeHeight),
                  physics: const BouncingScrollPhysics(),
                  children: _buildListBody(context)),
              SizedBox(
                  child: AppBar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(navAlpha),
                      centerTitle: false,
                      title: InkWell(
                          onTap: () {
                            if (provider.defaultCity != '' && provider.defaultCity != '正在定位...')
                              pushNewPage(context, WeatherPage(provider.defaultCity));
                            else {
                              _startLocation();
                            }
                          },
                          child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text('${provider.defaultCity}', style: const TextStyle(fontSize: 17.0)),
                                  const Icon(Icons.keyboard_arrow_down)
                                ], mainAxisSize: MainAxisSize.min),
                                Text(
                                    '${provider.defaultWeather?.now?.condTxt ?? ''} ${provider.defaultWeather?.now?.tmp ?? ''}',
                                    style: const TextStyle(fontSize: 13.0))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center)),
                      elevation: .0,
                      leading: IconButton(
                          icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState.openDrawer()),
                      actions: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.refresh, semanticLabel: "refresh"),
                            onPressed: () {},
                            tooltip: "Tune")
                      ]),
                  height: Utils.navigationBarHeight),
              Positioned(child: SongPlayerBar(), bottom: 0)
            ]),
            drawer: Drawer(child: HomeDrawable())));
  }

  List<Widget> _buildListBody(BuildContext context) {
    List<Widget> widgets = [];

    widgets
      ..add(AspectRatio(
          aspectRatio: 16 / 9,
          child: Swiper(
              itemBuilder: (context, index) => ImageLoadView(bannerImages[index]),
              itemCount: 4,
              pagination: const SwiperPagination(builder: SwiperPagination.fraction, alignment: Alignment.bottomRight),
              autoplay: true)))
      ..addAll(ExpandStateBean.expandStateList
          .map((value) => ExpansionTile(
              title: Text('${value.title}'),
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.025),
              children: value.children
                  .map((child) => ListTile(
                      contentPadding: const EdgeInsets.only(left: 30, right: 20),
                      title: Text(child.title),
                      onTap: () => pushNewPage(context, child.page),
                      trailing: const Icon(Icons.keyboard_arrow_right)))
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
    } else if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > const Duration(seconds: 2)) {
      debugPrint("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      Toast.show(context, "再按一次退出");
      return false;
    }
    return true;
  }

  Future<void> _location() async {
    await requestPermission();

    ///设置Android和iOS的apiKey<br>
    ///key的申请请参考高德开放平台官网说明<br>
    ///Android: https://lbs.amap.com/api/android-location-sdk/guide/create-project/get-key
    ///iOS: https://lbs.amap.com/api/ios-location-sdk/guide/create-project/get-key
    AMapFlutterLocation.setApiKey(Config.AMAP_KEY_ANDROID, Config.AMAP_KEY_IOS);

    /// iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    /// 注册定位结果监听
    _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, dynamic> result) {
      Log.d("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+$result}");
      // {locTime: 2022-06-28 12:28:49, province: 北京市, callbackTime: 2022-06-28 12:29:09, district: 丰台区, country: 中国, street: 南三环西路辅路, speed: -1.0, latitude: 39.855544, city: 北京市, streetNumber: 24号, bearing: -1.0, accuracy: 65.0, adCode: 110106, altitude: 42.8427791595459, locationType: 1, longitude: 116.368163, cityCode: 010, address: 北京市丰台区南三环西路辅路靠近搜宝商务中心, description: 北京市丰台区南三环西路辅路靠近搜宝商务中心}}

      String city = result["district"];
      String province = result["province"];
      debugPrint("-----------------------------$province");
      city ??= SpUtil.getString('current_city', defValue: '北京');
      Store.value<WeatherModel>(_scaffoldKey.currentContext, listen: false).getDefaultCityWeather(city);
    });

    _startLocation();
  }

  /// 设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = AMapLocationOption();

      /// 是否单次定位
      locationOption.onceLocation = true;

      /// 是否需要返回逆地理信息
      locationOption.needAddress = true;

      /// 逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      /// 设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      /// 设置Android端的定位模式<br>
      /// 可选值：<br>
      /// <li>[AMapLocationMode.Battery_Saving]</li>
      /// <li>[AMapLocationMode.Device_Sensors]</li>
      /// <li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      /// 设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      /// 设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      /// 设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      /// 将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }

  /// 开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  /// 停止定位
  void _stopLocation() {
    if (null != _locationPlugin) _locationPlugin.stopLocation();
  }

  /// 获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization = await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization == AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      Log.d("精确定位类型");
    } else if (currentAccuracyAuthorization == AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      Log.d("模糊定位类型");
    } else {
      Log.d("未知定位类型");
    }
  }

  /// 动态申请定位权限
  Future requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      Log.d("定位权限申请通过");
    } else {
      Log.d("定位权限申请不通过");
      Store.value<WeatherModel>(_scaffoldKey.currentContext, listen: false).getDefaultCityWeather("北京");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {
    /// 移除定位监听
    if (null != _locationListener) _locationListener.cancel();

    /// 销毁定位
    if (null != _locationPlugin) _locationPlugin.destroy();

    controller?.dispose();
    super.dispose();
  }
}
