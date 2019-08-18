import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ClassifyPage extends StatefulWidget {
  final String title;
  final int categoryIndex;
  final int subIndex;
  final GoodsProvider provider;

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
