import 'package:flutter/material.dart';
import 'package:flutter_app/bars_demo/keep_alive.dart';

class TabBarHomePage extends StatefulWidget {
  @override
  createState() => TabBarHomeStatePage();
}

// SingleTickerProviderStateMixin is used for animation
class TabBarHomeStatePage extends State<TabBarHomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> titleTabs = <Tab>[
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
  ];

  /*
   *-------------------- Setup Tabs ------------------*
   */
  // Create a tab controller
  TabController controller;

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    controller = TabController(length: titleTabs.length, vsync: this)
      ..addListener(() {
        // 监听滑动/点选位置
        if (controller.index.toDouble() == controller.animation.value) {
          switch (controller.index) {
            case 0:
              print('0');
              break;
            case 1:
              print('1');
              break;
            case 2:
              print('2');
              break;
            default:
              break;
          }
        }
      });
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: titleTabs,
      // setup the controller
      controller: controller,
      isScrollable: true,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          style: BorderStyle.none,
        ),
      ),
    );
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
      // TabBarView 默认支持手势滑动，若要禁止设置 NeverScrollableScrollPhysics
      physics: NeverScrollableScrollPhysics(),
    );
  }

  /*
   *---------- Setup the page by setting up tabs in the body ------------*
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title
        title: Text("Tabs Widget"),
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
