import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_app/bars_demo/each_view.dart';

class FancyBottomNavigationBar extends StatefulWidget {
  FancyBottomNavigationBar({Key key}) : super(key: key);

  @override
  createState() => _FancyBottomNavigationBarState();
}

class _FancyBottomNavigationBarState extends State<FancyBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;

  List<Widget> list = List();

  @override
  void initState() {
    super.initState();
    list
      ..add(EachView('Home'))
      ..add(EachView('Search'))
      ..add(EachView('Basket'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[currentPage],
      bottomNavigationBar: FancyBottomNavigation(
        onTabChangedListener: (int position) {
          setState(() {
            currentPage = position;
          });
        },
        circleColor: Colors.teal,
        initialSelection: 1,
        tabs: <TabData>[
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.search, title: "Search"),
          TabData(iconData: Icons.shopping_cart, title: "Basket")
        ],
      ),
    );
  }
}
