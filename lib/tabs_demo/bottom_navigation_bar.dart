import 'package:flutter/material.dart';
import 'package:flutter_app/tabs_demo/each_view.dart';

class BottomNavagationBarHomePage extends StatefulWidget {
  @override
  createState() => BottomNavagationBarHomesTatePage();
}

class BottomNavagationBarHomesTatePage
    extends State<BottomNavagationBarHomePage>
    with SingleTickerProviderStateMixin {
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispost() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        child: new TabBar(
          tabs: <Tab>[
            new Tab(
              // set icon to the tab
              icon: new Icon(Icons.home),
              text: "home",
            ),
            new Tab(
              icon: new Icon(Icons.email),
              text: "email",
            ),
            new Tab(
              icon: new Icon(Icons.pages),
              text: "pages",
            ),
            new Tab(
              icon: new Icon(Icons.airplay),
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
