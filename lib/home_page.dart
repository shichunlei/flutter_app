import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firstdemo/random_words.dart';
import 'package:flutter_app/movie/list/movie_grid_page.dart';
import 'package:flutter_app/movie/list/movie_list_page.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_bar.dart';
import 'package:flutter_app/tabs_demo/bottom_navigation_widget.dart';
import 'package:flutter_app/tabs_demo/navigation_keep_alive.dart';
import 'package:flutter_app/tabs_demo/tabbar_home_page.dart';
import 'package:flutter_app/weather/city/CityPage.dart';
import 'package:flutter_app/widget/button_widget.dart';
import 'package:flutter_app/widget/date_time_page.dart';
import 'package:flutter_app/widget/dialog_widget.dart';
import 'package:flutter_app/widget/frosting_widget.dart';
import 'package:flutter_app/widget/image_widget.dart';
import 'package:flutter_app/widget/load_image_widget.dart';
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
            leading: IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  semanticLabel: "search",
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.tune,
                  semanticLabel: "tune",
                ),
                onPressed: () {},
              )
            ],
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DateTimePage();
                      }));
                    },
                    child: Text("日期时间控件"),
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
                        return CityPage();
                      }));
                    },
                    child: Text("Weather"),
                  ),
                ),
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
            Row(children: <Widget>[
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
              Expanded(
                  child: RaisedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavagationBarHomePage())),
                child: Text("BottomNavagationBar"),
              ))
            ]),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationKeepAlive(),
                          ),
                        ),
                    child: Text("NavagationKeepAlive"),
                  ),
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
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigation(),
                        ),
                      ),
                  child: Text("不规则底部导航栏"),
                ),
              ],
            ),
            Row(children: <Widget>[
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
              )
            ])
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
}
