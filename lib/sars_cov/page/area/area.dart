import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import 'ui/area_data_view.dart';
import 'ui/item_data.dart';
import 'ui/item_area_news.dart';

class AreaPage extends StatefulWidget {
  final String province;

  AreaPage({Key key, this.province}) : super(key: key);

  @override
  createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  ProvinceDataBean data;

  LoaderState state = LoaderState.Loading;

  List<CitiesBean> cities = [];
  List<HistoryBean> history = [];

  List<ProvinceNews> news = [];

  bool isLoadComplete = false;

  int page = 1;
  int num = 10;

  @override
  void initState() {
    super.initState();

    getSARSCovProvinceData(widget.province, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        contentView: EasyRefresh.custom(
          footer: BallPulseFooter(),
          header: MaterialHeader(),
          onRefresh: () async {
            page = 1;
            getSARSCovProvinceData(widget.province, RefreshType.REFRESH);
          },
          onLoad: isLoadComplete
              ? null
              : () async {
                  page++;
                  getSARSCovProvinceNewsData(
                      widget.province, RefreshType.LOAD_MORE);
                },
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              title: Text('${data?.province}疫情'),
              expandedHeight: Utils.width / 750 * 326,
              backgroundColor: Color(0xff291747),
              flexibleSpace: FlexibleSpaceBar(
                  background: ImageLoadView('${data?.banner}')),
            ),
            SliverToBoxAdapter(
              child: AreaDataView(history: history, data: data),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => ItemDataView(city: cities[index]),
                    childCount: cities.length)),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                child: Text(
                  '疫情新闻',
                  style: TextStyle(color: Color(0xFF4E79F3)),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (_, index) => ItemAreaNewsView(
                      news: news[index],
                      isFirst: index == 0,
                      isLast: index == news.length - 1),
                  childCount: news.length),
            ),
          ],
        ),
        loaderState: state,
      ),
    );
  }

  void getSARSCovProvinceData(String province, RefreshType refreshType) async {
    data = await ApiService.getSARSCovProvinceData(province);

    cities.clear();
    cities.addAll(data?.cities);
    history.clear();
    history.addAll(data?.history);

    await getSARSCovProvinceNewsData(province, refreshType);

    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  Future getSARSCovProvinceNewsData(
      String province, RefreshType refreshType) async {
    if (refreshType != RefreshType.LOAD_MORE) {
      news.clear();
      isLoadComplete = false;
    }

    List<ProvinceNews> list = await ApiService.getSARSCovProvinceNewsData(
        province,
        page: page,
        num: num);

    if (list.length < num) {
      debugPrint('加载完成。。。');
      isLoadComplete = true;
    }
    news.addAll(list);

    if (mounted) setState(() {});
  }
}
