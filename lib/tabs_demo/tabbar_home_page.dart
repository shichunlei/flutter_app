import 'package:flutter/material.dart';
import 'package:flutter_app/tabs_demo/keep_alive.dart';

class TabBarHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabBarHomeStatePage();
  }
}

// SingleTickerProviderStateMixin is used for animation
class TabBarHomeStatePage extends State<TabBarHomePage>
    with SingleTickerProviderStateMixin {
  /*
   *-------------------- Setup Tabs ------------------*
   */
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispost() {
    // Dispost of the Tab Controller
    controller.dispose();

    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(Icons.map), Text("map")],
            ),
          ),
        ),
        Tab(
          child: Text("add"),
          icon: Icon(Icons.add),
        ),
        Tab(
          text: "refresh",
        )
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  /*
   *---------- Setup the page by setting up tabs in the body ------------*
   */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Title
        title: new Text("Tabs Widget"),
        // Set the background color of the App Bar
        backgroundColor: Colors.blue,
        // Set the bottom property of the Appbar to include a Tab Bar
        bottom: getTabBar(),
      ),
      // Set the TabBar view as the body of the Scaffold
      body: getTabBarView(
          <Widget>[KeepAliveWidget(), KeepAliveWidget(), KeepAliveWidget()]),
    );
  }
}
