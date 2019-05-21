import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/baixing_life/ui/left_menu.dart';
import 'package:flutter_app/baixing_life/ui/right_listview.dart';
import 'package:flutter_app/bean/category.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/loading_util.dart';

class ClassifyPage extends StatefulWidget {
  final String title;
  final int categoryIndex;
  final int subIndex;
  final GoodsPrivider provider;

  ClassifyPage(
    this.title, {
    Key key,
    this.categoryIndex = 0,
    this.subIndex = 0,
    this.provider,
  })  : assert(categoryIndex != null),
        assert(subIndex != null),
        super(key: key);

  @override
  _ClassifyPageState createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Category> category = [];

  int parentCategoryIndex;
  int subCategoryIndex;

  GlobalKey<RightListViewState> rightKey = GlobalKey<RightListViewState>();

  @override
  void initState() {
    super.initState();

    parentCategoryIndex = widget.categoryIndex;
    subCategoryIndex = widget.subIndex;
    getCategoryData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(children: <Widget>[
          ToolBar(title: '${widget.title}', backgroundColor: Colors.deepPurple),
          Expanded(
              child:
                  category.isNotEmpty ? _buildBodyView() : getLoadingWidget())
        ]));
  }

  void getCategoryData() async {
    category = await ApiService.getBaixingCategoryData();

    setState(() {});
  }

  Widget _buildBodyView() {
    return Row(children: <Widget>[
      LeftMenu(
          category: category, index: parentCategoryIndex, rightKey: rightKey),
      Container(height: double.infinity, color: Colors.grey[500], width: 0.5),
      RightListView(
          key: rightKey,
          subCategory: category[parentCategoryIndex],
          subCategoryIndex: subCategoryIndex,
          provider: widget.provider)
    ]);
  }
}
