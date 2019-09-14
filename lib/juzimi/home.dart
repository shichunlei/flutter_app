import 'package:flutter/material.dart';

import '../page_index.dart';
import 'list.dart';

class JuZiMiHomePage extends StatefulWidget {
  JuZiMiHomePage({Key key}) : super(key: key);

  @override
  createState() => _JuZiMiHomePageState();
}

class _JuZiMiHomePageState extends State<JuZiMiHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = [
    Tab(text: '爱情'),
    Tab(text: '励志'),
    Tab(text: '伤感'),
    Tab(text: '正能量')
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: ImageLoadView(
                'http://www.cnjxn.com/storage/2019/08/26/pEDsWrvnNU01QVuBQqIqQqc3TaZ8gQZjEFoopOpD.jpeg'),
            centerTitle: true,
            bottom: TabBar(
                tabs: tabs,
                controller: _controller,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 16))),
        body: TabBarView(
          controller: _controller,
          children: [
            JuZiMiListPage(type: 'aiqing'),
            JuZiMiListPage(type: 'lizhi'),
            JuZiMiListPage(type: 'shanggan'),
            JuZiMiListPage(type: 'zhengnl')
          ],
        ),
      ),
    );
  }
}
