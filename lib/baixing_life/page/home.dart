import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage(this.title, {Key key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Baixing data;

  List<Goods> goods = [];

  double headerHeight;

  int page;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getHomeData();

    headerHeight = Utils.width * 20 / 49;

    page = 1;
    getHotGoods(page);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoaderContainer(
            contentView: EasyRefresh.custom(
                footer: BallPulseFooter(),
                onLoad: () async {
                  page++;
                  getHotGoods(page);
                },
                slivers: <Widget>[
                  /// 头部banner
                  _buildSliverAppBar(data?.slides ?? []),

                  /// 分类
                  _buildSliverGridCategory(data?.category ?? []),

                  /// 广告
                  _buildSliverToBoxAdapterAds(
                      data?.advertesPicture, data?.shopInfo, data?.ads),

                  /// 商品推荐
                  _buildSliverToBoxAdapter('商品推荐'),
                  _buildSliverGridRecommend(data?.recommend ?? []),

                  /// floor
                  _buildFloorView(data?.floors ?? []),

                  /// 火爆专区
                  _buildHotGoodsTitle(),
                  _buildHotGoods()
                ]),
            loaderState: state));
  }

  void getHomeData() async {
    data = await ApiService.getBaixingHomeData('115.02932', '35.76189');

    if (data != null) {
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.NoAction;
    }

    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSliverAppBar(List<Goods> slides) {
    return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        backgroundColor: Colors.red,
        expandedHeight: headerHeight,
        title: Text('${widget.title}'),
        flexibleSpace: Container(
            child: Swiper(
                autoplay: true,
                itemCount: slides.length,
                itemBuilder: (BuildContext context, int index) => ImageLoadView(
                    '${slides[index].comPic}',
                    height: headerHeight),
                onTap: (int index) =>
                    pushNewPage(context, DetailsPage(slides[index].goodsId)))));
  }

  Widget _buildSliverGridCategory(List<GoodsCategory> category) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Store.value<BaixingModel>(context, listen: false)
                      ..setPageIndex(1)
                      ..setCategories(index, 0);
                  },
                  child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ImageLoadView('${category[index].image}',
                                height: 40, width: 40),
                            Gaps.vGap5,
                            Text('${category[index].mallCategoryName}')
                          ]))));
        }, childCount: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, childAspectRatio: 0.9));
  }

  Widget _buildSliverToBoxAdapterAds(AdvertesPicture advertesPicture,
      ShopInfo shopInfo, List<AdvertesPicture> ads) {
    double width = (Utils.width - 20) / 3;
    double height = (Utils.width - 20) / 3 * 287 / 224;

    return SliverToBoxAdapter(
        child: Container(
            child: Column(children: <Widget>[
              GestureDetector(
                  child: ImageLoadView(
                      '${advertesPicture?.pictureAddress ?? ""}',
                      width: double.infinity,
                      height: Utils.width * 67 / 750,
                      fit: BoxFit.fitWidth),
                  onTap: () {
                    /// TODO
                  }),
              Gaps.vGap10,
              GestureDetector(
                  child: ImageLoadView(shopInfo?.shopImage ?? "",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      height: Utils.width * 23 / 75),
                  onTap: () {
                    /// TODO
                  }),
              Row(children: <Widget>[
                GestureDetector(
                    child: ImageLoadView('${ads?.first?.pictureAddress ?? ""}',
                        width: width, height: height),
                    onTap: () {
                      /// TODO
                    }),
                GestureDetector(
                    child: ImageLoadView(
                        '${ads?.elementAt(1)?.pictureAddress ?? ""}',
                        width: width,
                        height: height),
                    onTap: () {
                      /// TODO
                    }),
                GestureDetector(
                    child: ImageLoadView(
                        '${ads?.elementAt(2)?.pictureAddress ?? ""}',
                        width: width,
                        height: height),
                    onTap: () {
                      /// TODO
                    })
              ])
            ]),
            color: Colors.white,
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(10.0)));
  }

  Widget _buildSliverToBoxAdapter(title) {
    return SliverToBoxAdapter(
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 5.0, bottom: 1.0),
            padding: EdgeInsets.only(left: 10.0, bottom: 5, top: 5),
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: TextStyle(color: Colors.green, fontSize: 20.0))));
  }

  Widget _buildSliverGridRecommend(List<Goods> recommend) {
    return SliverToBoxAdapter(
        child: Container(
            height: Utils.width / 3 * 2 / 1.45,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => Container(
                    width: Utils.width / 3,
                    child: ItemGoodsGrid(recommend[index],
                        height: Utils.width / 3 * 2 / 1.45)),
                separatorBuilder: (_, index) => Gaps.hGap5,
                itemCount: recommend.length)));
  }

  Widget _buildFloorView(List<FloorBean> floors) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => ItemHomeFloor(floor: floors[index]),
            childCount: floors.length));
  }

  Widget _buildHotGoodsTitle() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('🔥'),
                  SizedBox(width: 10.0),
                  Text('火爆专区')
                ])));
  }

  Widget _buildHotGoods() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => ItemGoodsGrid(
                  goods[index],
                  height: Utils.width / 1.6,
                ),
            childCount: goods.length),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Utils.width / 2,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1.6 / 2));
  }

  void getHotGoods(page) async {
    List<Goods> _goods = await ApiService.getBaixingHomeHotData(page);
    setState(() => goods.addAll(_goods));
  }
}
