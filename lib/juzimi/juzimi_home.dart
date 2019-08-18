import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/juzimi/classify.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../page_index.dart';

class JuzimiHomePage extends StatefulWidget {
  JuzimiHomePage({Key key}) : super(key: key);

  @override
  createState() => _JuzimiHomePageState();
}

class _JuzimiHomePageState extends State<JuzimiHomePage> {
  List<MeiTuMeiJu> meitumeiju = [];

  List<MingjuClassify> classify = [];

  /// 句子迷所有接口页码均从0开始
  int page = 0;

  bool isLoadComplete = false;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getMeitumeiju(page);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('句子迷')),
        drawer: _leftMenu(),
        body: meitumeiju.isNotEmpty
            ? EasyRefresh(
                key: _easyRefreshKey,
                refreshFooter: BallPulseFooter(
                    key: _footerKey,
                    color: Colors.indigo,
                    backgroundColor: Colors.white),
                loadMore: isLoadComplete
                    ? null
                    : () async {
                        page++;
                        getMeitumeiju(page);
                      },
                child: StaggeredGridView.countBuilder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    itemCount: meitumeiju.length,
                    itemBuilder: (context, index) =>
                        _buildItemMeiTuMeiJuGridView(index),
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2)))
            : getLoadingWidget());
  }

  void getMeitumeiju(int page) async {
    // calssify = await ApiService.getMingrenmingjuType();
    rootBundle.loadString('assets/data/juzimi_classify.json').then((value) {
      classify = MingjuClassify.fromMapList(json.decode(value));
    });

    JuzimiResult result = await ApiService.getMeiTuMeiJu(page);
    if (result.meijus.length < 15 || result.totalPage == page) {
      isLoadComplete = true;
    }
    List<MeiTuMeiJu> list = result.meijus;
    meitumeiju.addAll(list);
    setState(() {});
  }

  Widget _leftMenu() {
    List<Widget> children = [];

    children.add(ImageLoadView(
        'http://img.juzimi.com/juzimi/images/mingrenmingyan.jpg',
        height: 180));

    children.add(Gaps.vGap20);

    classify.map((type) {
      int index = classify.indexOf(type);
      children.add(ListTile(
          title: Text('${type.title}'),
          onTap: () {
            Navigator.pop(context);

            if (index == 0 || index == 1) {
              pushNewPageBack(
                  context,
                  ClassifyPage(
                      classify: type.classify, title: '名人', flag: 'celebrity'));
            }
            if (index == 2) {
              pushNewPageBack(
                  context,
                  ClassifyPage(
                      classify: type.classify, title: '书籍', flag: 'book'));
            }
            if (index == 3) {
              pushNewPageBack(
                  context,
                  ClassifyPage(
                      classify: type.classify, title: '名言', flag: 'album'));
            }
            if (index == 4) {
              pushNewPageBack(
                  context,
                  ClassifyPage(
                      classify: type.classify, title: '句集', flag: 'juji'));
            }
            if (index == 5) {
              pushNewPageBack(
                  context,
                  ClassifyPage(
                      classify: type.classify, title: '原创', flag: 'original'));
            }
          },
          trailing: Icon(Icons.keyboard_arrow_right)));
    }).toList();

    return Drawer(
      child: Container(
          child:
              ListView(children: children, padding: EdgeInsets.only(top: 0))),
    );
  }

  Widget _buildItemMeiTuMeiJuGridView(int index) {
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ImageLoadView(meitumeiju[index].image,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('${meitumeiju[index].desc}',
                          style: TextStyle(fontSize: 12)))
                ])),
        onTap: () {});
  }
}
