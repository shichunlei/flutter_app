import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'widget/lore.dart';
import 'widget/map.dart';
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

    expandedHeight = Utils.width / 3 - Utils.topSafeHeight;

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
      body: LoaderContainer(
        contentView: EasyRefresh.custom(
          scrollController: controller,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: primary,
              title: Text(
                "战疫情",
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, opacity)),
              ),
              expandedHeight: expandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: ImageLoadView(
                    'https://img1.dxycdn.com/2020/0208/285/3395498790898861169-2.png'),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Swiper(
                      onTap: (index) {},
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
                                  style: TextStyle(color: Color(0xFFEA4D36)),
                                ),
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
                  TitleContainer(title: "疫情介绍"),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 10, right: 10),
              sliver: SliverList(
                  delegate: SliverChildListDelegate([
                RichText(
                    text: TextSpan(
                        text: '${data?.note1?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.red),
                        children: <TextSpan>[
                      TextSpan(
                        text:
                            data == null ? "" : '${data?.note1[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.note2?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange),
                        children: <TextSpan>[
                      TextSpan(
                        text:
                            data == null ? "" : '${data?.note2[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.note3?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.purple),
                        children: <TextSpan>[
                      TextSpan(
                        text:
                            data == null ? "" : '${data?.note3[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark1?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.green),
                        children: <TextSpan>[
                      TextSpan(
                        text: data == null
                            ? ""
                            : '${data?.remark1[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark2?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.cyan),
                        children: <TextSpan>[
                      TextSpan(
                        text: data == null
                            ? ""
                            : '${data?.remark2[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
                RichText(
                    text: TextSpan(
                        text: '${data?.remark3?.first.toString()}：',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.pink),
                        children: <TextSpan>[
                      TextSpan(
                        text: data == null
                            ? ""
                            : '${data?.remark3[1].toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ])),
              ])),
            ),
            MapView(data: data),
            SliverToBoxAdapter(
              child: TitleContainer(title: "全国数据分布"),
            ),
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                minHeight: 35.0,
                maxHeight: 35.0,
                child: buildTitleRow(),
              ),
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) =>
                        ItemProvinceDataView(province: provinces[index]),
                    childCount: provinces.length)),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text('${data?.generalRemark}'),
                    padding: EdgeInsets.all(8),
                    color: Colors.white,
                  ),
                  TitleContainer(title: "海外数据分布"),
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                minHeight: 35.0,
                maxHeight: 35.0,
                child: buildTitleRow(),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) =>
                        ItemContinentDataView(continent: continents[index]),
                    childCount: continents.length)),
            RumorView(rumour: rumour),
            LoreView(wikiList: wikiList),
            ProtectView(),
          ],
        ),
        loaderState: state,
      ),
    );
  }

  Widget buildTitleRow() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Container(
            child: Text('地区'),
            height: 35.0,
            color: Color(0xFFE2E6F2),
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            child: Text('现存确诊'),
            height: 35.0,
            color: Color(0xFFF4BBAF),
            alignment: Alignment.center,
          ),
        ),
        Expanded(
            flex: 6,
            child: Container(
              child: Text('累计确诊'),
              height: 35.0,
              color: Color(0xFFE39B8F),
              alignment: Alignment.center,
            )),
        Expanded(
          flex: 5,
          child: Container(
            child: Text('死亡'),
            height: 35.0,
            color: Color(0xFFB4C0DA),
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            child: Text('治愈'),
            height: 35.0,
            color: Color(0xFF95DC9A),
            alignment: Alignment.center,
          ),
        ),
      ],
    );
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
