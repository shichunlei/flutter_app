import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';
import 'index.dart';

class BookReaderHomePage extends StatefulWidget {
  BookReaderHomePage({Key key}) : super(key: key);

  @override
  createState() => _BookReaderHomePageState();
}

class _BookReaderHomePageState extends State<BookReaderHomePage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: IndexedStack(
            children: <Widget>[BookShelfPage(), BookStorePage(), MySelfPage()],
            index: _tabIndex),
        bottomNavigationBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image.asset('images/reader/icon_tab_bookshelf_n.png'),
                  activeIcon:
                      Image.asset('images/reader/icon_tab_bookshelf_p.png'),
                  label: '书架'),
              BottomNavigationBarItem(
                  icon: Image.asset('images/reader/icon_tab_home_n.png'),
                  activeIcon: Image.asset('images/reader/icon_tab_home_p.png'),
                  label: '书城'),
              BottomNavigationBarItem(
                  icon: Image.asset('images/reader/icon_tab_me_n.png'),
                  activeIcon: Image.asset('images/reader/icon_tab_me_p.png'),
                  label: '我的')
            ],
            backgroundColor: Colors.white,
            inactiveColor: grey3Color,
            activeColor: readerMainColor,
            currentIndex: _tabIndex,
            onTap: (index) => setState(() => _tabIndex = index)));
  }
}
