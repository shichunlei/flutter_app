import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'widget/lore.dart';
import 'widget/map.dart';
import 'widget/note_remark.dart';
import 'widget/protect.dart';
import 'widget/rumor.dart';
import 'widget/card_widget.dart';
import 'widget/home_head_view.dart';
import 'ui/item_continent_view.dart';
import 'ui/item_province_view.dart';
import 'widget/title_container.dart';

class SARSCoVIndexPage extends StatefulWidget {
  SARSCoVIndexPage({Key key}) : super(key: key);

  @override
  createState() => _SARSCoVIndexPageState();
}

class _SARSCoVIndexPageState extends State<SARSCoVIndexPage> {
  ScrollController controller;

  double opacity = 0.0;

  final Color primary = Color(0xff291747);
  final Color active = Color(0xff6C48AB);

  SARSCov data;

  List<Province> provinces = [];
  List<Continent> continents = [];

  List<RumourBean> rumour = [];
  List<WikiListBean> wikiList = [];
  List<RecommendBean> recommend = [];

  LoaderState state = LoaderState.Loading;

  double expandedHeight;

  @override
  void initState() {
    super.initState();

    expandedHeight = Utils.width / 1125 * 546 - Utils.topSafeHeight;

    controller = ScrollController()
      ..addListener(() {
        var offset = controller.offset;
        if (offset < 0) {
          if (opacity != 0) setState(() => opacity = 0);
        } else if (offset < expandedHeight && offset >= 0) {
          setState(
              () => opacity = 1 - (expandedHeight - offset) / expandedHeight);
        } else {
          if (opacity != 1) setState(() => opacity = 1);
        }
      });

    getData();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
        child: LoaderContainer(
            contentView: EasyRefresh
                .custom(scrollController: controller, slivers: <Widget>[
              SliverAppBar(
                  pinned: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: primary,
                  title: Text("战疫情",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, opacity))),
                  expandedHeight: expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                      ImageLoadView(
                          'https://mat1.gtimg.com/news/feiyanarea/head_bg_new.png'),
                      Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Column(children: [
                            Text('新型冠状病毒肺炎',
                                style: TextStyle(
                                    color: Color(0xFFFDE9A6),
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),
                            Text('疫情实时追踪',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold)),
                            Text('数据来源：国家及各地卫健委每日信息公布',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ]))
                    ]),
                  )),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Swiper(
                        autoplay: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data?.marquee?.length,
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      '${data?.marquee[index]?.marqueeLabel}',
                                      style:
                                          TextStyle(color: Color(0xFFEA4D36))),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFCEFED),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                ),
                                Gaps.hGap10,
                                Expanded(
                                    child: Text(
                                  '${data?.marquee[index]?.marqueeContent}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    HomeHeadView(data: data),
                    CardWidget(),
                  ],
                ),
              ),

              /// 疫情介绍
              NoteRemarkView(data: data),
              MapView(data: data),

              /// 中国数据分布
              SliverToBoxAdapter(child: TitleContainer(title: "全国数据分布")),
              SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                    minHeight: 35.0,
                    maxHeight: 35.0,
                    child: buildTitleRow(),
                  ),
                  pinned: true),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (_, index) =>
                          ItemProvinceDataView(province: provinces[index]),
                      childCount: provinces.length)),

              /// 海外数据分布
              SliverToBoxAdapter(
                child: Column(children: <Widget>[
                  Container(
                      child: Text('${data?.generalRemark}'),
                      padding: EdgeInsets.all(8),
                      color: Colors.white),
                  TitleContainer(title: "海外数据分布")
                ]),
              ),
              SliverPersistentHeader(
                  delegate: CustomSliverAppBarDelegate(
                      minHeight: 35.0,
                      maxHeight: 35.0,
                      child: buildTitleRow())),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (_, index) =>
                          ItemContinentDataView(continent: continents[index]),
                      childCount: continents.length)),

              /// 辟谣
              RumorView(rumour: rumour),

              /// 疾病知识
              LoreView(wikiList: wikiList),

              /// 预防手册
              ProtectView(),
            ]),
            loaderState: state),
      ),
    );
  }

  Widget buildTitleRow() {
    return Row(children: <Widget>[
      Expanded(
          flex: 7,
          child: Container(
              child: Text('地区'),
              height: 35.0,
              color: Color(0xFFE2E6F2),
              alignment: Alignment.center)),
      Expanded(
          flex: 6,
          child: Container(
              child: Text('现存确诊'),
              height: 35.0,
              color: Color(0xFFF4BBAF),
              alignment: Alignment.center)),
      Expanded(
          flex: 6,
          child: Container(
              child: Text('累计确诊'),
              height: 35.0,
              color: Color(0xFFE39B8F),
              alignment: Alignment.center)),
      Expanded(
          flex: 5,
          child: Container(
              child: Text('死亡'),
              height: 35.0,
              color: Color(0xFFB4C0DA),
              alignment: Alignment.center)),
      Expanded(
          flex: 5,
          child: Container(
              child: Text('治愈'),
              height: 35.0,
              color: Color(0xFF95DC9A),
              alignment: Alignment.center))
    ]);
  }

  void getData() async {
    data = await ApiService.getSARSCovIndexData();

    provinces.addAll(data.provinces);
    continents.addAll(data.continents);

    rumour.addAll(data?.rumour);

    wikiList.addAll(data?.wikiList);
    recommend.addAll(data?.recommend);

    if (mounted)
      setState(() {
        state = LoaderState.Succeed;
      });
  }
}
