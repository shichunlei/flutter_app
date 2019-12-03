import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class NBAHomePage extends StatefulWidget {
  NBAHomePage({Key key}) : super(key: key);

  @override
  createState() => _NBAHomePageState();
}

class _NBAHomePageState extends State<NBAHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<String> titleTabs = ['赛程', "排行", "球员榜", "球队榜"];

  int customIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
        vsync: this, length: titleTabs.length, initialIndex: customIndex)
      ..addListener(() {
        setState(() {
          customIndex = _controller.index;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('NBA'),
          bottom: PreferredSize(
            child: TabBar(
              tabs: titleTabs.map((title) => Tab(text: "$title")).toList(),
              controller: _controller,
              indicatorColor: Colors.blueAccent,
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelStyle: TextStyle(fontSize: 14),
            ),
            preferredSize: Size.fromHeight(38),
          ),
          actions: customIndex == 0
              ? [IconButton(icon: Icon(Icons.event), onPressed: () {})]
              : [],
        ),
        body: SafeArea(
          top: false,
          child: TabBarView(controller: _controller, children: [
            SchedulePage(),
            RankPage(),
            PlayerRankPage(),
            TeamDataRankPage(),
          ]),
        ),
      ),
    );
  }
}
