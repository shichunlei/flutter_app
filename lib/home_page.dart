import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firstdemo/random_words.dart';
import 'package:flutter_app/movie/list/movie_grid_page.dart';
import 'package:flutter_app/movie/list/movie_list_page.dart';
import 'package:flutter_app/page/login_page.dart';
import 'package:flutter_app/page/shici_page.dart';
import 'package:flutter_app/question/pages/quiz_page.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_bar.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_widget.dart';
import 'package:flutter_app/tabs_demo/navigation_keep_alive.dart';
import 'package:flutter_app/tabs_demo/tabbar_home_page.dart';
import 'package:flutter_app/utils/toast_util.dart';
import 'package:flutter_app/weather/city/city_page.dart';
import 'package:flutter_app/contact/page/contact_page.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/chip_widget.dart';
import 'package:flutter_app/widget/dialog_widget.dart';
import 'package:flutter_app/widget/frosting_widget.dart';
import 'package:flutter_app/widget/image_widget.dart';
import 'package:flutter_app/widget/load_image_widget.dart';
import 'package:flutter_app/widget/qr_image_wiget.dart';
import 'package:flutter_app/widget/slider_widget.dart';
import 'package:flutter_app/widget/stepper_widget.dart';
import 'package:flutter_app/widget/swiper_widget.dart';
import 'package:flutter_app/widget/text_widget.dart';
import 'package:flutter_app/widget/textfield_widget.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/event_bus_util.dart';

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
      print('${event.key}');
      print('${event.value}');

      if (event.key == "is_login") {
        isLogin = event.value as bool;
        setState(() {
          print("接收到信息");
          initUser(isLogin);
        });
      }
    });
  }

  void initUser(bool isLogin) {
    print(avatar);
    setState(() {
      userName = isLogin ? "SCL" : "未登录";
      email = isLogin ? "1558053958@qq.com" : "";
      avatar = isLogin
          ? "http://b-ssl.duitang.com/uploads/item/201511/11/20151111120052_y38xC.thumb.700_0.jpeg"
          : "";
      print(avatar);
    });
  }

  void getLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isLogin = sp.getBool("isLogin");

    initUser(isLogin);
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
                  onPressed: () {
                    print("点击了菜单");
                    _scaffoldKey.currentState.openDrawer();
                  }),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    semanticLabel: "search",
                  ),
                  onPressed: () {},
                  tooltip: "Search",
                ),
                IconButton(
                  icon: Icon(
                    Icons.tune,
                    semanticLabel: "tune",
                  ),
                  onPressed: () {},
                  tooltip: "Tune",
                )
              ],
            ),
            drawer: Drawer(
                elevation: 10.0,
                child: _bulderMenuView(),
                semanticLabel: "左侧菜单"),
            body: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10.0,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => pushNewPage(
                          context,
                          TextWidget(),
                        ),
                    child: Text("Text"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, ButtonWidget());
                    },
                    child: Text("Button"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, ImageWidget());
                    },
                    child: Text("Image"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, TextFieldWidget());
                    },
                    child: Text("TextField"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, DialogWidget());
                    },
                    child: Text("Dialog"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, RandomWords());
                    },
                    child: Text("RandomWords"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, MovieGridPage());
                    },
                    child: Text("Movie Grid"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, MovieListPage());
                    },
                    child: Text("Movie List"),
                  ),
                  RaisedButton(
                    onPressed: () =>
                        pushNewPage(context, BottomNavagationBarHomePage()),
                    child: Text("BottomNavagationBar"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      pushNewPage(context, TabBarHomePage());
                    },
                    child: Text("TabBarView"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, BottomNavigation()),
                    child: Text("不规则底部导航栏"),
                  ),
                  RaisedButton(
                    onPressed: () =>
                        pushNewPage(context, NavigationKeepAlive()),
                    child: Text("NavagationKeepAlive"),
                  ),
                  RaisedButton(
                    onPressed: () =>
                        pushNewPage(context, BottomNavigationWidget()),
                    child: Text("BottomNavigationWidget"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, LoadImageWidget()),
                    child: Text("LoadImage"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, StepperWidget()),
                    child: Text("Stepper"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, SwiperWidget()),
                    child: Text("Swiper"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, FrostingWidget()),
                    child: Text("毛玻璃"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, QuizPage()),
                    child: Text("Question"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, SliderWidget()),
                    child: Text("SliderWidget"),
                  ),
                  RaisedButton(
                    onPressed: () => pushNewPage(context, ChipWidget()),
                    child: Text("ChipWidget"),
                  )
                ])));
  }

  /// 监听返回键，点击两下退出程序
  Future<bool> _onBackPressed() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      print("菜单打开着");
    } else if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      print("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      ToastUtil.show("再按一次退出", context,
          duration: ToastUtil.LENGTH_SHORT, gravity: ToastUtil.BOTTOM);
      return false;
    }
    return true;
  }

  Widget _bulderMenuView() {
    return Column(
      children: <Widget>[
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
                pushNewPageBack(context, ContactPage());
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
              pushNewPageBack(context, ShiciPage());
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
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "再想想",
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        Divider(),
      ],
    );
  }
}
