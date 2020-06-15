import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ClassifyPage extends StatefulWidget {
  final String title;

  const ClassifyPage(this.title, {Key key}) : super(key: key);

  @override
  createState() => _ClassifyPageState();
}

class _ClassifyPageState extends State<ClassifyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<GoodsCategory> category = [];

  GlobalKey<RightListViewState> rightKey = GlobalKey<RightListViewState>();

  @override
  void initState() {
    super.initState();
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
        body: category.isNotEmpty ? _buildBodyView(context) : LoadingWidget());
  }

  void getCategoryData() async {
    category = await ApiService.getBaixingCategoryData();

    if (mounted) setState(() {});
  }

  Widget _buildBodyView(BuildContext context) {
    var provider = Store.value<BaixingModel>(context, listen: false);

    return Row(children: <Widget>[
      LeftMenu(category: category, rightKey: rightKey),
      Container(height: double.infinity, color: Colors.grey[500], width: 0.5),
      RightListView(
          key: rightKey,
          subCategory: category[provider.categoryIndex],
          subCategoryIndex: 0)
    ]);
  }
}
