import 'package:flutter/material.dart';

import 'second_second.dart';
import 'second_first.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final List<Tab> titleTabs = <Tab>[
    Tab(child: Text("异常")),
    Tab(child: Text("当日未完成")),
  ];

  TabController controller;

  @override
  void initState() {
    super.initState();

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
            default:
              break;
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('异常单证'),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
        ],
        bottom: TabBar(
          tabs: titleTabs,
          controller: controller,
          isScrollable: true,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          SecondFirstPage(),
          SecondSecondPage(),
        ],
        controller: controller,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
