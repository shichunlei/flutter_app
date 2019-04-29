import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/baixing_life/ui/item_goods_grid.dart';
import 'package:flutter_app/bean/category.dart';
import 'package:flutter_app/bean/goods.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/toolbar.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  List<Category> category = [];

  int parentCategoryIndex;
  int subCategoryIndex;
  int subCategoryLength;

  TabController controller;

  List<Goods> goods = [];

  int page = 1;

  bool isLoadComplete = false;

  double rightWidth = 259.0;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    parentCategoryIndex = widget.categoryIndex;
    subCategoryIndex = widget.subIndex;
    getCategoryData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: <Widget>[
          ToolBar(
            title: '${widget.title}',
            backgroundColor: Colors.deepPurple,
          ),
          Expanded(
              child: category.length > 0
                  ? _buildBodyView()
                  : Container(
                      child: getLoadingWidget(),
                    ))
        ],
      ),
    );
  }

  void getCategoryData() async {
    category = await ApiService.getBaixingCategoryData();

    LogUtil.v('${category.toString()}');

    getGoodsList(page, category[parentCategoryIndex].mallCategoryId,
        category[parentCategoryIndex].bxMallSubDto[subCategoryIndex].mallSubId);
    setState(() {});
  }

  Widget _buildBodyView() {
    return Row(
      children: <Widget>[
        _buildLeftView(),
        Container(height: double.infinity, color: Colors.grey[500], width: 0.5),
        _buildRightView()
      ],
    );
  }

  TabController changeTabController(int length) {
    return controller = TabController(
        length: length, vsync: this, initialIndex: subCategoryIndex)
      ..addListener(() {
        // 监听滑动/点选位置
        if (controller.index.toDouble() == controller.animation.value) {
          setState(() {
            subCategoryIndex = controller.index;
            goods = [];
            page = 1;

            isLoadComplete = false;
            getGoodsList(
                page,
                category[parentCategoryIndex].mallCategoryId,
                category[parentCategoryIndex]
                    .bxMallSubDto[subCategoryIndex]
                    .mallSubId);
          });
        }
      });
  }

  Widget _buildLeftView() {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return Column(children: <Widget>[
          ListTile(
            title: Text('${category[index].mallCategoryName}'),
            onTap: () {
              setState(() {
                parentCategoryIndex = index;
                subCategoryIndex = 0;
                goods = [];
                page = 1;

                isLoadComplete = false;
                getGoodsList(
                    page,
                    category[parentCategoryIndex].mallCategoryId,
                    category[parentCategoryIndex]
                        .bxMallSubDto[subCategoryIndex]
                        .mallSubId);
              });
            },
            selected: index == parentCategoryIndex,
          ),
          Divider()
        ]);
      },
      itemCount: category.length,
    ));
  }

  Widget _buildRightView() {
    return Container(
      width: rightWidth,
      child: Column(children: <Widget>[
        TabBar(
            indicatorColor: Colors.pinkAccent,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.grey,
            controller: changeTabController(
                category[parentCategoryIndex].bxMallSubDto.length),
            isScrollable: true,
            tabs: category[parentCategoryIndex]
                .bxMallSubDto
                .map((category) => Tab(text: "${category.mallSubName}"))
                .toList()),
        _buildGoodsListView(
            category[parentCategoryIndex].mallCategoryId,
            category[parentCategoryIndex]
                .bxMallSubDto[subCategoryIndex]
                .mallSubId)
      ]),
    );
  }

  Widget _buildGoodsListView(String categoryId, String subId) {
    return Expanded(
        child: EasyRefresh(
            key: _easyRefreshKey,
            refreshFooter: BallPulseFooter(
                key: _footerKey,
                color: Colors.indigo,
                backgroundColor: Colors.white),
            loadMore: isLoadComplete
                ? null
                : () async {
                    page++;
                    getGoodsList(
                        page,
                        category[parentCategoryIndex].mallCategoryId,
                        category[parentCategoryIndex]
                            .bxMallSubDto[subCategoryIndex]
                            .mallSubId);
                  },
            child: GridView.builder(
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
    List<Goods> _goods =
        await ApiService.getBaixingGoodsData(page, categoryId, subId);
    if (_goods.length < 20) {
      isLoadComplete = true;
    }
    goods.addAll(_goods);
    setState(() {});
  }
}
