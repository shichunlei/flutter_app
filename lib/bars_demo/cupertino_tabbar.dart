import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/res/colors.dart';

import 'each_view.dart';

class CupertinoTabBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: Colors.grey[200],
      tabBuilder: (_, int index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return EachView('书架');
                break;
              case 1:
                return EachView('书城');
                break;
              case 2:
                return EachView('我的');
                break;
              default:
                return null;
                break;
            }
          },
        );
      },
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('images/reader/icon_tab_bookshelf_n.png'),
              activeIcon: Image.asset('images/reader/icon_tab_bookshelf_p.png'),
              title: Text('书架', style: TextStyle(fontSize: 14))),
          BottomNavigationBarItem(
              icon: Image.asset('images/reader/icon_tab_home_n.png'),
              activeIcon: Image.asset('images/reader/icon_tab_home_p.png'),
              title: Text('书城', style: TextStyle(fontSize: 14))),
          BottomNavigationBarItem(
              icon: Image.asset('images/reader/icon_tab_me_n.png'),
              activeIcon: Image.asset('images/reader/icon_tab_me_p.png'),
              title: Text('我的', style: TextStyle(fontSize: 14)))
        ],
        backgroundColor: Colors.white,
        inactiveColor: grey3Color,
      ),
    );
  }
}
