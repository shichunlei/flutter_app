import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';

class NavigationBarFixed extends StatefulWidget {
  @override
  createState() => _NavigationBarFixedState();
}

class _NavigationBarFixedState extends State<NavigationBarFixed>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  PageController _controller;
  PageView _pageView;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);

    _pageView = PageView(
      controller: _controller,
      children: <Widget>[
        EachView('home'),
        EachView('email'),
        EachView('pages'),
        EachView('airplay')
      ],
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      //physics: NeverScrollableScrollPhysics() // 禁止滑动
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageView,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.animateToPage(index,
                curve: Curves.linear, duration: Duration(milliseconds: 100));
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.black),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('HOME')),
            BottomNavigationBarItem(
                icon: Icon(Icons.email), title: Text('Email')),
            BottomNavigationBarItem(
                icon: Icon(Icons.pages), title: Text('PAGES')),
            BottomNavigationBarItem(
                icon: Icon(Icons.airplay), title: Text('AIRPLAY'))
          ],
          backgroundColor: Colors.grey),
    );
  }
}
