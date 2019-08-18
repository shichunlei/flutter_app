import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class HomePage extends StatefulWidget {
  final String title;
  final GoodsProvider provider;

  HomePage(this.title, this.provider, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Baixing data;

  List<Goods> goods = [];

  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  int page;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getHomeData();

    headerHeight = Utils.width * 20 / 49;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < headerHeight) {
        setState(() {
          navAlpha = 1 - (headerHeight - offset) / headerHeight;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });

    page = 1;
    getHotGoods(page);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyView();
  }

  void getHomeData() async {
    data = await ApiService.getBaixingHomeData('115.02932', '35.76189');

    setState(() {});
  }

  Widget _buildBodyView() {
    if (data == null) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(children: <Widget>[
          ToolBar(
              title: '${widget.title}', backgroundColor: Colors.transparent),
          Expanded(child: Container(child: getLoadingWidget()))
        ]),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          EasyRefresh(
              refreshFooter: BallPulseFooter(
                  key: _footerKey,
                  color: Colors.indigo,
                  backgroundColor: Colors.white),
              loadMore: () async {
                page++;
                getHotGoods(page);
              },
              child: CustomScrollView(
                  controller: scrollController,
                  slivers: <Widget>[
                    /// 头部banner
                    _buildSliverAppBar(data.slides),

                    /// 分类
                    _buildSliverGridCategory(data.category),

                    /// 广告
                    _buildSliverToBoxAdapterAds(
                        data.advertesPicture, data.shopInfo, data.ads),

                    /// 商品推荐
                    _buildSliverToBoxAdapter('商品推荐'),
                    _buildSliverGridRecommend(data.recommend),

                    /// floor
                    _buildFloorView(data.floors),

                    /// 火爆专区
                    _buildHotGoodsTitle(),
                    _buildHotGoods()
                  ])),
          ChangeAppBar(
              title: widget.title,
              backgroundColor: Colors.red,
              navAlpha: navAlpha)
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(List<Goods> slides) {
    return SliverAppBar(
        backgroundColor: Colors.red,
        expandedHeight: headerHeight,
        flexibleSpace: Container(
            child: Swiper(
                autoplay: true,
                itemCount: slides.length,
                itemBuilder: (BuildContext context, int index) => Hero(
                    tag: slides[index].goodsId,
                    child: ImageLoadView('${slides[index].comPic}')),
                onTap: (int index) => pushNewPage(
                    context,
                    DetailsPage(slides[index].goodsId,
                        provider: widget.provider)))));
  }

  Widget _buildSliverGridCategory(List<Category> category) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => pushReplacement(context,
                  IndexPage(index: 1, category: index, subCategory: 0)),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(5.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ImageLoadView('${category[index].image}',
                          height: 40, width: 40),
                      Gaps.vGap5,
                      Text('${category[index].mallCategoryName}')
                    ]),
              ),
            );
          },
          childCount: 10,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, childAspectRatio: 0.9));
  }

  Widget _buildSliverToBoxAdapterAds(AdvertesPicture advertesPicture,
      ShopInfo shopInfo, List<AdvertesPicture> ads) {
    double width = (Utils.width - 20) / 3;
    double height = (Utils.width - 20) / 3 * 287 / 224;

    return SliverToBoxAdapter(
        child: Container(
            child: Column(
              children: <Widget>[
                GestureDetector(
                    child: ImageLoadView('${advertesPicture.pictureAddress}'),
                    onTap: () {
                      /// TODO
                    }),
                SizedBox(height: 10),
                GestureDetector(
                    child: ImageLoadView(shopInfo.leaderImage),
                    onTap: () {
                      /// TODO
                    }),
                Row(children: <Widget>[
                  GestureDetector(
                      child: ImageLoadView('${ads[0].pictureAddress}',
                          width: width, height: height),
                      onTap: () {
                        /// TODO
                      }),
                  GestureDetector(
                      child: ImageLoadView('${ads[1].pictureAddress}',
                          width: width, height: height),
                      onTap: () {
                        /// TODO
                      }),
                  GestureDetector(
                      child: ImageLoadView('${ads[2].pictureAddress}',
                          width: width, height: height),
                      onTap: () {
                        /// TODO
                      })
                ])
              ],
            ),
            color: Colors.white,
            margin: EdgeInsets.only(top: 5.0),
            padding: EdgeInsets.all(10.0)));
  }

  Widget _buildSliverToBoxAdapter(title) {
    return SliverToBoxAdapter(
      child: Column(children: <Widget>[
        Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 5.0, bottom: 1.0),
            padding: EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,
            child: Text(title,
                style: TextStyle(color: Colors.green, fontSize: 20.0)),
            height: 40.0),
        Container(color: Colors.white, height: 5.0)
      ]),
    );
  }

  Widget _buildSliverGridRecommend(List<Goods> recommend) {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) =>
                ItemGoodsGrid(recommend[index], provider: widget.provider),
            childCount: recommend.length),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Utils.width / recommend.length,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1.45 / 2));
  }

  Widget _buildFloorView(List<FloorBean> floors) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          child: Column(children: <Widget>[
            _buildFloorHeader(floors[index]),
            _buildFloorGoods(floors[index])
          ]),
        );
      }, childCount: floors.length),
    );
  }

  Widget _buildFloorHeader(FloorBean floor) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
            onTap: () {
              /// TODO 跳转商品列表页？
            },
            child: ImageLoadView('${floor.floorPic.pictureAddress}')));
  }

  Widget _buildFloorGoods(FloorBean floor) {
    return Container(
        child: Column(children: <Widget>[
          Container(
              height: Utils.width / 2,
              child: Row(children: <Widget>[
                ItemFloorGoods(floor.floor[0].goodsId, floor.floor[0].comPic,
                    width: Utils.width / 2, provider: widget.provider),
                Container(
                    width: Utils.width / 2,
                    child: Column(children: <Widget>[
                      ItemFloorGoods(
                          floor.floor[1].goodsId, floor.floor[1].comPic,
                          height: Utils.width / 4, provider: widget.provider),
                      ItemFloorGoods(
                          floor.floor[2].goodsId, floor.floor[2].comPic,
                          height: Utils.width / 4, provider: widget.provider)
                    ]))
              ])),
          Container(
              height: Utils.width / 4,
              child: Row(children: <Widget>[
                ItemFloorGoods(floor.floor[3].goodsId, floor.floor[3].comPic,
                    width: Utils.width / 2, provider: widget.provider),
                ItemFloorGoods(floor.floor[4].goodsId, floor.floor[4].comPic,
                    width: Utils.width / 2, provider: widget.provider)
              ]))
        ]),
        color: Colors.white);
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
            (BuildContext context, int index) =>
                ItemGoodsGrid(goods[index], provider: widget.provider),
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
