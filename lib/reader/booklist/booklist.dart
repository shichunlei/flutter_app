import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class BookListPage extends StatefulWidget {
  BookListPage({Key key}) : super(key: key);

  @override
  createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  List<Tab> tabs = [Tab(text: '男生'), Tab(text: '女生'), Tab(text: '出版')];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0.0,
          iconTheme: lightIconTheme,
          title: Text('书单', style: TextStyle(color: Colors.black54)),
          backgroundColor: Colors.white,
          bottom: TabBar(
              tabs: tabs,
              controller: _controller,
              indicatorColor: readerMainColor,
              labelColor: readerMainColor,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 16))),
      body: TabBarView(controller: _controller, children: [
        BookListsPage(gender: 'male'),
        BookListsPage(gender: 'female'),
        BookListsPage(gender: 'press')
      ]),
    );
  }
}
