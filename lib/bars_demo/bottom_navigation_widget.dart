import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget>
    with SingleTickerProviderStateMixin {
  final _bottomNavigationColor = Colors.white;
  int _currentIndex = 0;
  List<Widget> list = List();

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
            icon: Icon(
              Icons.home,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'HOME',
              style: TextStyle(color: _bottomNavigationColor),
            ),
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'Email',
              style: TextStyle(color: _bottomNavigationColor),
            ),
            backgroundColor: Colors.orange,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'PAGES',
              style: TextStyle(color: _bottomNavigationColor),
            ),
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'AIRPLAY',
              style: TextStyle(color: _bottomNavigationColor),
            ),
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
