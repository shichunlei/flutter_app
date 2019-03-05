import 'package:flutter/material.dart';
import 'package:flutter_app/movie/page/sub_page/new_movie_raking.dart';
import 'package:flutter_app/movie/page/sub_page/us_movie_raking.dart';
import 'package:flutter_app/movie/page/sub_page/weekly_movie_raking.dart';

class MovieRakingHome extends StatefulWidget {
  @override
  _MovieRakingHomeState createState() => _MovieRakingHomeState();
}

class _MovieRakingHomeState extends State<MovieRakingHome>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('电影排行榜'),
          bottom: _tabBar(),

          /// 可以用这种方式设置渐变的AppBar
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.cyan, Colors.blue, Colors.blueAccent])))),
      body: _tabBarView(<Widget>[
        NewMovieRakingPage(),
        WeeklyMovieRakingPage(),
        UsMovieRakingPage(),
      ]),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      tabs: <Tab>[
        Tab(text: "新片榜"),
        Tab(text: "口碑榜"),
        Tab(text: "北美票房榜"),
      ],
      // setup the controller
      controller: controller,
    );
  }

  TabBarView _tabBarView(var tabs) {
    return TabBarView(
      // add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }
}
