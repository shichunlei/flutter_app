import 'package:flutter/material.dart';

import 'package:flutter_app/service/api_url.dart';

import '../index.dart';

class MovieRakingHome extends StatefulWidget {
  final int index;
  final List<Movie> movies;

  MovieRakingHome({Key key, this.index = 0, this.movies}) : super(key: key);

  @override
  createState() => _MovieRakingHomeState();
}

class _MovieRakingHomeState extends State<MovieRakingHome>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();

    controller =
        TabController(length: 3, initialIndex: widget.index, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();

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
              colors: [
                Colors.cyan,
                Colors.blue,
                Colors.blueAccent,
              ],
            ),
          ),
        ),
      ),
      body: _tabBarView(<Widget>[
        MovieRankingSubPage(ApiUrl.WEEKLY_MOVIES_URL),
        MovieRankingSubPage(ApiUrl.NEW_MOVIES_URL),
        MovieRankingSubPage(ApiUrl.US_MOVIES_URL),
      ]),
    );
  }

  TabBar _tabBar() {
    return TabBar(
      isScrollable: true,
      tabs: <Tab>[
        Tab(text: "口碑榜"),
        Tab(text: "新片榜"),
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
