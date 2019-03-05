import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/contact/page/contact_list_page.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:flutter_app/custom_widgets/toast/toast.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/poetry/page/random_poetry_page.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/weather/page/city_page.dart';
import 'package:flutter_app/widget/qr_image_wiget.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/event_bus_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeStatePage();
}

class HomeStatePage extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 上次点击时间
  DateTime _lastPressedAt;

  String userName = "";
  String email = "";
  String avatar = "";
  bool isLogin = false;

  @override
  void initState() {
    super.initState();

    getLoginInfo();

    eventBus.on<TestEvent>().listen((event) {
      LogUtil.v('${event.key}');
      LogUtil.v('${event.value}');

      if (event.key == "is_login") {
        isLogin = event.value as bool;
        setState(() {
          LogUtil.v("接收到信息");
          initUser(isLogin);
        });
      }
    });
  }

  void initUser(bool isLogin) {
    LogUtil.v(avatar);
    setState(() {
      userName = isLogin ? "SCL" : "未登录";
      email = isLogin ? "1558053958@qq.com" : "";
      avatar = isLogin
          ? "http://b-ssl.duitang.com/uploads/item/201511/11/20151111120052_y38xC.thumb.700_0.jpeg"
          : "";
      LogUtil.v(avatar);
    });
  }

  void getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isLogin = sp.getBool("isLogin");

    initUser(isLogin);
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
        drawer: Drawer(
            elevation: 10.0, child: _bulderMenuView(), semanticLabel: "左侧菜单"),
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
              children: _buildExpansionPanelView(),
              expansionCallback: (index, isExpand) =>
                  _setCurrentIndex(index, isExpand),
            )
          ],
        ),
      ),
    );
  }

  List<ExpansionPanel> _buildExpansionPanelView() {
    List<ExpansionPanel> widgets = [];
    for (var i = 0; i < expandStateList.length; i++) {
      widgets.add(
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return ListTile(
              title: Text(expandStateList[i].title),
            );
          },
          body: ListBody(
            /// 排列的主轴方向
            mainAxis: Axis.vertical,

            /// 是否反向
            reverse: false,
            children: _buildListBody(expandStateList[i]),
          ),
          isExpanded: expandStateList[i].isOpen,
        ),
      );
    }

    return widgets;
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

  Widget _bulderMenuView() {
    return Column(children: <Widget>[
      UserAccountsDrawerHeader(
        /// 姓名
        accountName: Text(userName),

        /// 邮箱
        accountEmail: Text(email),

        /// 用户头像
        currentAccountPicture: InkWell(
          child: CircleAvatar(
            backgroundImage: isLogin
                ? NetworkImage(avatar)
                : AssetImage("images/flutter_logo.png"),
          ),
          onTap: () {
            if (isLogin) {
              Navigator.pop(context);
              pushNewPageBack(context, ContactListPage());
            } else {
              pushAndRemovePage(context, LoginPage());
            }
          },
        ),
        otherAccountsPictures: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
            ),
            onTap: () {},
          ),
          GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
            ),
            onTap: () {},
          ),
        ],

        /// 装饰器
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
            image: NetworkImage(
                "http://pic33.photophoto.cn/20141028/0038038006886895_b.jpg"),
            //image: ExactAssetImage("images/flutter.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      Divider(),
      ListTile(
        title: Text("城市"),
        leading: Icon(Icons.location_city),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).pop();
          pushNewPageBack(context, CityPage());
        },
      ),
      Divider(),
      ListTile(
          title: Text("诗词"),
          leading: Icon(Icons.book),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            pushNewPageBack(context, RandomPoetryPage());
          }),
      Divider(),
      ListTile(
        title: Text("二维码"),
        leading: Icon(Icons.crop_square),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).pop();
          pushNewPageBack(context, QrImageWidget());
        },
      ),
      Divider(),
      ListTile(
          title: Text("退出账号"),
          leading: Icon(Icons.exit_to_app),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                      title: Text("退出账号"),
                      content: Text("您确定要退出账号吗？"),
                      actions: <Widget>[
                        FlatButton(
                            child: Text("退出"),
                            onPressed: () {
                              eventBus.fire(TestEvent("is_login", false));
                              pushAndRemovePage(context, LoginPage());
                            }),
                        FlatButton(
                            child: Text("再想想",
                                style: Theme.of(context).textTheme.button),
                            onPressed: () => Navigator.of(context).pop())
                      ]);
                });
          }),
      Divider(),
    ]);
  }
}
