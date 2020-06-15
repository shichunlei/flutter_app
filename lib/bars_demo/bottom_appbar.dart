import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';
import 'package:flutter_app/utils/route_util.dart';

class BottomAppbarSample extends StatefulWidget {
  @override
  _BottomAppbarState createState() => _BottomAppbarState();
}

class _BottomAppbarState extends State<BottomAppbarSample> {
  List<Widget> list = [];

  int index = 0;

  @override
  void initState() {
    super.initState();
    list..add(EachView("Home"))..add(EachView("Airplay"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[index],
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushNewPage(context, EachView("Pages")),
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
