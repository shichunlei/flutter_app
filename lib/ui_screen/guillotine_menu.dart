import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

enum _GuillotineAnimationStatus { closed, open, animating }

class GuillotineMenuPage extends StatefulWidget {
  GuillotineMenuPage({Key key}) : super(key: key);

  @override
  createState() => _GuillotineMenuPageState();
}

class _GuillotineMenuPageState extends State<GuillotineMenuPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animationMenu;
  Animation<double> animationTitleFadeInOut;

  _GuillotineAnimationStatus menuAnimationStatus =
      _GuillotineAnimationStatus.closed;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              menuAnimationStatus = _GuillotineAnimationStatus.open;
            } else if (status == AnimationStatus.dismissed) {
              menuAnimationStatus = _GuillotineAnimationStatus.closed;
            } else {
              menuAnimationStatus = _GuillotineAnimationStatus.animating;
            }
          });

    animationMenu = Tween(begin: -pi / 2.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn,
      ),
    );

    animationTitleFadeInOut = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(.0, .5, curve: Curves.ease),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          _buildContentView(),
          _buildMenuView(),
        ],
      ),
    );
  }

  Widget _buildMenuView() {
    final List<Map> _menus = <Map>[
      {
        "icon": Icons.person,
        "title": "profile",
        "color": Colors.white,
      },
      {
        "icon": Icons.view_agenda,
        "title": "feed",
        "color": Colors.white,
      },
      {
        "icon": Icons.swap_calls,
        "title": "activity",
        "color": Colors.cyan,
      },
      {
        "icon": Icons.settings,
        "title": "settings",
        "color": Colors.white,
      },
    ];

    return Transform.rotate(
      angle: animationMenu.value,
      origin: Offset(
          (Utils.navigationBarHeight - Utils.topSafeHeight) / 2.0,
          (Utils.navigationBarHeight - Utils.topSafeHeight) / 2.0 +
              Utils.topSafeHeight),
      alignment: Alignment.topLeft,
      child: Material(
        color: grey3Color,
        child: Stack(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: 64.0, top: Utils.navigationBarHeight),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _menus.map((menuItem) {
                    return ListTile(
                      leading: Icon(
                        menuItem["icon"],
                        color: menuItem["color"],
                      ),
                      title: Text(
                        menuItem["title"],
                        style:
                            TextStyle(color: menuItem["color"], fontSize: 24.0),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (menuAnimationStatus ==
                      _GuillotineAnimationStatus.closed) {
                    _controller.forward().orCancel;
                  } else if (menuAnimationStatus ==
                      _GuillotineAnimationStatus.open) {
                    _controller.reverse().orCancel;
                  }
                },
              ),
              top: Utils.topSafeHeight,
              left: 0.0,
            ),
            Positioned(
              top: Utils.topSafeHeight,
              left: 0.0,
              width: Utils.width,
              height: Utils.navigationBarHeight - Utils.topSafeHeight,
              child: Transform.rotate(
                angle: pi / 2.0,
                alignment: Alignment.topLeft,
                origin: Offset(
                    (Utils.navigationBarHeight - Utils.topSafeHeight) / 2.0,
                    (Utils.navigationBarHeight - Utils.topSafeHeight) / 2.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Opacity(
                    child: Text(
                      'Title',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    opacity: animationTitleFadeInOut.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return Container(
      padding: EdgeInsets.only(top: Utils.navigationBarHeight),
      child: Center(
        child: Text('这是内容页'),
      ),
    );
  }
}
