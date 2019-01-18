import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firstdemo/random_words.dart';
import 'package:flutter_app/movie/list/movie_grid_page.dart';
import 'package:flutter_app/movie/list/movie_list_page.dart';
import 'package:flutter_app/page/about_us_page.dart';
import 'package:flutter_app/page/city_select_page.dart';
import 'package:flutter_app/page/shici_page.dart';
import 'package:flutter_app/question/pages/quiz_page.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_bar.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_widget.dart';
import 'package:flutter_app/tabs_demo/navigation_keep_alive.dart';
import 'package:flutter_app/tabs_demo/tabbar_home_page.dart';
import 'package:flutter_app/weather/city/CityPage.dart';
import 'package:flutter_app/contact/page/contact_page.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/date_time_page.dart';
import 'package:flutter_app/widget/dialog_widget.dart';
import 'package:flutter_app/widget/frosting_widget.dart';
import 'package:flutter_app/widget/image_widget.dart';
import 'package:flutter_app/widget/load_image_widget.dart';
import 'package:flutter_app/widget/qr_image_wiget.dart';
import 'package:flutter_app/widget/stepper_widget.dart';
import 'package:flutter_app/widget/swiper_widget.dart';
import 'package:flutter_app/widget/text_widget.dart';
import 'package:flutter_app/widget/textfield_widget.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeStatePage();
}

class HomeStatePage extends State<HomePage> {
  /// add line
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 上次点击时间
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    /**
     * 实现原理，使用WillPopScope组件，它会检测到子组件的Navigation的pop事件，并拦截下来。
     * 我们需要在它的onWillPop属性中返回一个新的组件（一般是一个Dialog）处理是否真的pop该页面。
     */
    return WillPopScope(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            // Title
            title: Text("Flutter Demo"),
            // Set the background color of the App Bar
            backgroundColor: Colors.pinkAccent,
            elevation: 4.0,
            centerTitle: true,
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
            child: Center(
              child: bulderMenuView(),
            ),
            semanticLabel: "左侧菜单",
          ),
          body: Scrollbar(
              child: SingleChildScrollView(
                  child: Center(
                      child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TextWidget(),
                          ),
                        ),
                    child: Text("Text"),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ButtonWidget();
                      }));
                    },
                    child: Text("Button"),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ImageWidget();
                      }));
                    },
                    child: Text("Image"),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return TextFieldWidget();
                      }));
                    },
                    child: Text("TextField"),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DialogWidget();
                    }));
                  },
                  child: Text("Dialog"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RandomWords();
                      }));
                    },
                    child: Text("RandomWords"),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieGridPage();
                          },
                        ),
                      );
                    },
                    child: Text("Movie Grid"),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieListPage();
                          },
                        ),
                      );
                    },
                    child: Text("Movie List"),
                  ),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 5.0,
              spacing: 10.0,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BottomNavagationBarHomePage())),
                  child: Text("BottomNavagationBar"),
                ),
                RaisedButton(
                  onPressed: () {
                    /// 原理：只要使用了CupertinoPageRoute push进来的页面就都会具有右滑返回的操作
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => TabBarHomePage(),
                      ),
                    );
                  },
                  child: Text("TabBarView"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      ),
                  child: Text("不规则底部导航栏"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationKeepAlive(),
                        ),
                      ),
                  child: Text("NavagationKeepAlive"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => BottomNavigationWidget(),
                        ),
                      ),
                  child: Text("BottomNavigationWidget"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadImageWidget(),
                        ),
                      ),
                  child: Text("LoadImage"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StepperWidget(),
                        ),
                      ),
                  child: Text("Stepper"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SwiperWidget(),
                        ),
                      ),
                  child: Text("Swiper"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FrostingWidget(),
                        ),
                      ),
                  child: Text("毛玻璃"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(),
                        ),
                      ),
                  child: Text("Question"),
                ),
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactPage(),
                        ),
                      ),
                  child: Text("Contact"),
                ),
              ],
            ),
          ]))))),
      onWillPop: onBackPressed,
    );
  }

  Future<bool> onBackPressed() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("再按一次退出！"),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  Widget bulderMenuView() {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          /// 姓名
          accountName: Text("SCL"),

          /// 邮箱
          accountEmail: Text("1558053958@qq.com"),

          /// 用户头像
          currentAccountPicture: InkWell(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://upload.jianshu.io/users/upload_avatars/7700793/dbcf94ba-9e63-4fcf-aa77-361644dd5a87?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (contet) => AboutUsPage()));
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
        ListTile(
          title: Text("日期时间控件"),
          leading: Icon(Icons.date_range),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            /// 左侧菜单收起
            Navigator.pop(context);

            /// 跳转到下一个界面
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DateTimePage();
            }));
          },
        ),
        Divider(),
        ListTile(
          title: Text("天气"),
          leading: Icon(Icons.hdr_weak),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => CityPage())),
        ),
        Divider(),
        ListTile(
          title: Text("城市"),
          leading: Icon(Icons.location_city),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => CitySelectPage())),
        ),
        Divider(),
        ListTile(
          title: Text("诗词"),
          leading: Icon(Icons.book),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShiciPage())),
        ),
        Divider(),
        ListTile(
          title: Text("二维码"),
          leading: Icon(Icons.crop_square),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => QrImageWidget())),
        ),
        Divider(),
      ],
    );
  }
}
