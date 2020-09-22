import 'package:flutter/material.dart';
import 'package:flutter_app/juzimi/item_list.dart';
import 'package:flutter_app/res/styles.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'provider_widget.dart';
import 'test_list_model.dart';

class TestListViewPage extends StatefulWidget {
  TestListViewPage({Key key}) : super(key: key);

  @override
  createState() => _TestListViewPageState();
}

class _TestListViewPageState extends State<TestListViewPage> {
  TextListModel model;

  @override
  void initState() {
    super.initState();

    model = TextListModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    model.setContext(context);

    return Scaffold(
        appBar: AppBar(title: Text("TestListView Demo")),
        body: ProviderWidget<TextListModel>(
            model: model,
            showLoading: true,
            showEmpty: true,
            onModelReady: (model) {
              model.initData();
            },
            builder: (BuildContext context, TextListModel model, Widget child) {
              return EasyRefresh(
                  footer: BallPulseFooter(enableHapticFeedback: true),
                  header: MaterialHeader(enableHapticFeedback: true),
                  controller: model.easyRefreshController,
                  scrollController: model.scrollController,
                  onRefresh: () async {
                    model.refresh();
                  },
                  onLoad: () async {
                    model.loadMore();
                  },
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) =>
                          ItemList(item: model.list[index], onPressed: () {}),
                      separatorBuilder: (_, index) => Gaps.vGap5,
                      itemCount: model.list.length));
            }));
  }
}
