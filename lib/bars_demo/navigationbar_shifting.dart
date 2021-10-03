import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';

class NavigationBarShifting extends StatefulWidget {
  @override
  createState() => _NavigationBarShiftingState();
}

class _NavigationBarShiftingState extends State<NavigationBarShifting> {
  int _currentIndex = 0;
  List<Widget> list = [];

  @override
  void initState() {
    list
      ..add(EachView('Home'))
      ..add(EachView('Email'))
      ..add(EachView('PAGES'))
      ..add(EachView('AIRPLAY'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'HOME',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email),
                  label: 'Email',
                  backgroundColor: Colors.orange),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pages),
                  label: 'PAGES',
                  backgroundColor: Colors.red),
              BottomNavigationBarItem(
                  icon: Icon(Icons.airplay),
                  label: 'AIRPLAY',
                  backgroundColor: Colors.purple)
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.shifting));
  }
}
