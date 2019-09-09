import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class PicturePage extends StatefulWidget {
  PicturePage({Key key}) : super(key: key);

  @override
  createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<String> titles = ['热血', '魔幻', '科幻', '恋爱', '搞笑', '悬疑', '少儿'];

  List<Tab> tabs = [];

  @override
  void initState() {
    super.initState();

    titles.forEach((title) {
      tabs.add(Tab(text: title));
    });

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
        appBar: AppBar(
            title: Text('漫画', style: TextStyle(color: Colors.black54)),
            bottom: TabBar(
                tabs: tabs,
                isScrollable: true,
                controller: _controller,
                indicatorColor: readerMainColor,
                labelColor: readerMainColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16))),
        body: TabBarView(
            children:
                titles.map((title) => PictureBookPage(major: title)).toList(),
            controller: _controller),
      ),
    );
  }
}
