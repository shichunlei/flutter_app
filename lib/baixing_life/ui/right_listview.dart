import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class RightListView extends StatefulWidget {
  final Category subCategory;
  final int subCategoryIndex;
  final GoodsProvider provider;

  RightListView(
      {Key key, this.subCategory, this.subCategoryIndex, this.provider})
      : super(key: key);

  @override
  createState() => RightListViewState();
}

class RightListViewState extends State<RightListView>
    with TickerProviderStateMixin {
  double rightWidth = 280.0;

  TabController controller;

  List<Goods> goods = [];

  int page = 1;

  bool isLoadComplete = false;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  int currentIndex;
  Category subCategory;

  @override
  void initState() {
    super.initState();

    this.subCategory = widget.subCategory;
    refreshView(page, widget.subCategoryIndex, subCategory);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: rightWidth,
      child: Column(children: <Widget>[
        TabBar(
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.grey,
            controller: controller,
            isScrollable: true,
            tabs: subCategory.bxMallSubDto
                .map((category) => Tab(text: "${category.mallSubName}"))
                .toList()),
        _buildGoodsListView()
      ]),
    );
  }

  Widget _buildGoodsListView() {
    return Expanded(
        child: EasyRefresh(
            refreshFooter: BallPulseFooter(
                key: _footerKey,
                color: Colors.indigo,
                backgroundColor: Colors.white),
            loadMore: isLoadComplete
                ? null
                : () async {
                    page++;
                    getGoodsList(page, subCategory.mallCategoryId,
                        subCategory.bxMallSubDto[currentIndex].mallSubId);
                  },
            child: GridView.builder(
                padding: EdgeInsets.only(top: 0),
                itemCount: goods.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: rightWidth / 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 0.75),
                itemBuilder: (BuildContext context, int index) =>
                    ItemGoodsGrid(goods[index], provider: widget.provider))));
  }

  void getGoodsList(int page, String categoryId, String subId) async {
    isLoadComplete = false;
    this.page = page;
    List<Goods> _goods =
        await ApiService.getBaixingGoodsData(this.page, categoryId, subId);
    if (_goods.length < 20) {
      isLoadComplete = true;
    }
    goods.addAll(_goods);
    setState(() {});
  }

  void refreshView(int page, int currentIndex, Category subCategory) {
    this.page = page;
    this.currentIndex = currentIndex;
    this.subCategory = subCategory;
    goods = [];

    controller = TabController(
        length: this.subCategory.bxMallSubDto.length,
        vsync: this,
        initialIndex: this.currentIndex)
      ..addListener(() {
        // 监听滑动/点选位置
        if (controller.index.toDouble() == controller.animation.value) {
          setState(() {
            this.currentIndex = controller.index;
            goods = [];
            this.page = 1;

            getGoodsList(this.page, this.subCategory.mallCategoryId,
                this.subCategory.bxMallSubDto[this.currentIndex].mallSubId);
          });
        }
      });

    getGoodsList(this.page, this.subCategory.mallCategoryId,
        this.subCategory.bxMallSubDto[this.currentIndex].mallSubId);

    setState(() {});
  }
}
