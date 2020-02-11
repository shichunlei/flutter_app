import 'package:flutter/material.dart';

import 'first.dart';
import 'second.dart';

class DemoHomePage extends StatefulWidget {
  DemoHomePage({Key key}) : super(key: key);

  @override
  createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  int curIndex = 0;

  List<Widget> listPage = [];

  @override
  void initState() {
    super.initState();

    listPage..add(SecondPage())..add(FirstPage());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: IndexedStack(
        children: listPage,
        index: curIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey[200],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            title: Text('异常单证'),
          ),
        ],
        currentIndex: curIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            curIndex = index;
          });
        },
      ),
    );
  }
}
