import 'package:flutter/material.dart';
import 'package:flutter_app/tabs_demo/each_view.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    {
  List<Widget> list;

  int index = 0;

  @override
  void initState() {
    super.initState();
    list = new List();
    list..add(EachView("Home"))..add(EachView("Airplay"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return EachView("Pages");
            },
          ));
        },
        tooltip: "new page",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              tooltip: "home",
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.airplay,
                color: Colors.white,
              ),
              tooltip: "airplay",
              onPressed: () {
                setState(() {
                  index = 1;
                });
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
        ),
      ),
    );
  }
}
