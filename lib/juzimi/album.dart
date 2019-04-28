import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';

class AlbumPage extends StatefulWidget {
  final List<MingjuClassify> classify;

  AlbumPage(this.classify, {Key key}) : super(key: key);

  @override
   createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> titleTabs = [];

  TabController controller;

  @override
  void initState() {
    super.initState();
    widget.classify.forEach((type) {
      titleTabs.add(Tab(text: type.title));
    });

    controller = TabController(length: widget.classify.length, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('名言'),
          bottom: TabBar(
              tabs: titleTabs, controller: controller, isScrollable: true)),
      body: TabBarView(children: <Widget>[], controller: controller),
    );
  }
}
