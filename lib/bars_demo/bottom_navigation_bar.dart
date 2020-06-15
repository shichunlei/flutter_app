import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/each_view.dart';

class BottomNavigationBarHomePage extends StatefulWidget {
  @override
  createState() => BottomNavigationBarHomesTatePage();
}

class BottomNavigationBarHomesTatePage
    extends State<BottomNavigationBarHomePage>
    with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          EachView('home'),
          EachView('email'),
          EachView('pages'),
          EachView('airplay')
        ],
        controller: controller,
      ),
      bottomNavigationBar: Material(
        // set the color of the bottom navigation bar
        color: Colors.blue,
        // set the tab bar as the child of bottom navigation bar
        child: TabBar(
          tabs: <Tab>[
            Tab(
              // set icon to the tab
              icon: Icon(Icons.home),
              text: "home",
            ),
            Tab(
              icon: Icon(Icons.email),
              text: "email",
            ),
            Tab(
              icon: Icon(Icons.pages),
              text: "pages",
            ),
            Tab(
              icon: Icon(Icons.airplay),
              text: "airplay",
            ),
          ],
          // setup the controller
          controller: controller,
        ),
      ),
    );
  }
}
