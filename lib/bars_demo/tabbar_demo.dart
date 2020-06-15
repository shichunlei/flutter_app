import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabBarDemoPage extends StatefulWidget {
  TabBarDemoPage({Key key}) : super(key: key);

  @override
  createState() => _TabBarDemoPageState();
}

class _TabBarDemoPageState extends State<TabBarDemoPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<DataBean> data = [];

  @override
  void initState() {
    super.initState();

    getData();
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
        title: Text('扫描登记'),
        bottom: data.length > 0
            ? TabBar(
                tabs: data.map((item) {
                  return Tab(
                    child: Text("${item.name}"),
                    icon: Icon(Icons.add),
                  );
                }).toList(),
                // setup the controller
                controller: controller,
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              )
            : null,
      ),
      body: data.length > 0
          ? TabBarView(
              controller: controller,
              children: data.map((item) {
                return Container(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return Text('${item.children[index].name}');
                    },
                    itemCount: item.children.length,
                  ),
                );
              }).toList(),
            )
          : Center(child: CupertinoActivityIndicator(radius: 20.0)),
    );
  }

  void getData() async {
    // 自行改为网络数据请求
    await rootBundle.loadString("assets/data/data.json").then((value) {
      data = List()
        ..addAll(
            (json.decode(value) as List ?? []).map((o) => DataBean.fromMap(o)));

      controller = TabController(length: data.length, vsync: this);

      if (mounted) {
        setState(() {});
      }
    });
  }
}

class DataBean {
  String id;
  String pid;
  List<ChildrenBean> children;
  String parentId;
  String name;
  int sortNum;
  String parentName;

  static DataBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DataBean bean = DataBean();
    bean.id = map['id'];
    bean.pid = map['pid'];
    bean.children = List()
      ..addAll(
          (map['children'] as List ?? []).map((o) => ChildrenBean.fromMap(o)));
    bean.parentId = map['parentId'];
    bean.name = map['name'];
    bean.sortNum = map['sortNum'];
    bean.parentName = map['parentName'];
    return bean;
  }

  Map toJson() => {
        "id": id,
        "pid": pid,
        "children": children,
        "parentId": parentId,
        "name": name,
        "sortNum": sortNum,
        "parentName": parentName,
      };
}

class ChildrenBean {
  String id;
  String pid;
  List<dynamic> children;
  String parentId;
  String name;
  int sortNum;
  String parentName;

  static ChildrenBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChildrenBean childrenBean = ChildrenBean();
    childrenBean.id = map['id'];
    childrenBean.pid = map['pid'];
    childrenBean.children = map['children'];
    childrenBean.parentId = map['parentId'];
    childrenBean.name = map['name'];
    childrenBean.sortNum = map['sortNum'];
    childrenBean.parentName = map['parentName'];
    return childrenBean;
  }

  Map toJson() => {
        "id": id,
        "pid": pid,
        "children": children,
        "parentId": parentId,
        "name": name,
        "sortNum": sortNum,
        "parentName": parentName,
      };
}
