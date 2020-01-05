import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ClassifyPage extends StatefulWidget {
  final String title;
  final int categoryIndex;
  final int subIndex;

  ClassifyPage(
    this.title, {
    Key key,
    this.categoryIndex = 0,
    this.subIndex = 0,
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
    super.build(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('${widget.title}'),
            backgroundColor: Colors.deepPurple),
        backgroundColor: Colors.grey[200],
        body: category.isNotEmpty ? _buildBodyView() : LoadingWidget());
  }

  void getCategoryData() async {
    category = await ApiService.getBaixingCategoryData();

    if (mounted) setState(() {});
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
      )
    ]);
  }
}
