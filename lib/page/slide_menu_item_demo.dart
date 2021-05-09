import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bean/country.dart';

import '../page_index.dart';

class SlideMenuItemDemoPage extends StatefulWidget {
  @override
  createState() => _SlideMenuItemDemoPageState();
}

class _SlideMenuItemDemoPageState extends State<SlideMenuItemDemoPage> {
  List<GlobalKey<SlideMenuItemState>> keyList = [];

  List<Country> countries = [];

  @override
  void initState() {
    super.initState();

    getCountryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('自定义侧滑')),
        body: countries.length > 0
            ? ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return SlideMenuItem(
                      key: keyList[index],
                      onSlideStarted: () {
                        keyList.forEach((slide) {
                          if (slide != keyList[index]) {
                            slide.currentState?.close();
                          }
                        });
                      },
                      child: Container(child: Text("${countries[index].name}")),
                      actions: countries[index].pyFull.length % 2 == 0
                          ? <ActionsWidget>[
                              ActionsWidget(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onTap: () {
                                    print("object按钮被点击了");
                                    countries.removeAt(index);
                                    keyList.removeAt(index);
                                    setState(() {});
                                  }),
                              ActionsWidget(
                                  child: Container(
                                      child: Text('编辑'),
                                      alignment: Alignment.center),
                                  color: Colors.lightGreenAccent,
                                  onTap: () {
                                    print("object按钮被点击了");
                                  })
                            ]
                          : [
                              ActionsWidget(
                                  icon: Icon(Icons.add),
                                  color: Colors.green,
                                  onTap: () {
                                    print("object按钮被点击了");
                                  })
                            ],
                      onTap: () {
                        print('object---------------------------------onTap');
                      });
                },
                itemCount: countries.length,
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 1))
            : Container(child: Text("加载中..."), alignment: Alignment.center));
  }

  void getCountryData() async {
    //加载城市列表
    await rootBundle.loadString('assets/data/country.json').then((value) {
      countries = []
        ..addAll(
            (json.decode(value) as List ?? []).map((o) => Country.fromMap(o)));

      if (countries.isNotEmpty) {
        keyList.clear();
        countries.forEach((bean) {
          keyList.add(GlobalKey<SlideMenuItemState>());
        });
      }

      setState(() {});
    });
  }
}
