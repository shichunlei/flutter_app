import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';
import 'package:flutter_app/stream_packing/index.dart';
import 'search.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';
import 'details.dart';
import 'item_home.dart';

class TubiTVHomePage extends StatefulWidget {
  TubiTVHomePage({Key key}) : super(key: key);

  @override
  createState() => _TubiTVHomePageState();
}

class _TubiTVHomePageState extends State<TubiTVHomePage> {
  StateManager manager;

  List<TubiCategory> category = [];

  List<TuBiTV> banners = [];

  @override
  void initState() {
    super.initState();
    manager = StateManager();

    getHomeData();
  }

  @override
  void dispose() {
    manager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DarkTheme(
      child: Scaffold(
        body: MultiStateWidget<List<TubiCategory>>(
          controller: manager.controller,
          builder: (BuildContext buildContext, t) {
            category.clear();
            category.addAll(t);
            banners.addAll(category?.first?.children);

            return EasyRefresh.custom(
              slivers: <Widget>[
                SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => pushNewPage(context, SearchListPage()))
                  ],
                  automaticallyImplyLeading: false,
                  title: Image.asset("images/icon_nav_logo.png"),
                  pinned: true,
                  expandedHeight: Utils.width * 0.6,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Swiper(
                        itemBuilder: (context, index) => InkWell(
                              onTap: () => pushNewPage(
                                  context, DetailsPage(id: banners[index]?.id)),
                              child: Stack(children: <Widget>[
                                ImageLoadView(
                                    banners[index]?.backgrounds?.first),
                                Positioned(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    color: Color(0x3a000000),
                                    child: Text(
                                      '${banners[index]?.title}',
                                      style: TextStyles.textWhite16,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                )
                              ], fit: StackFit.expand),
                            ),
                        itemCount: banners.length,
                        autoplay: true),
                  ),
                ),
                SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) => ItemHomeView(
                              item: category[index + 1]?.children,
                              category: category[index + 1]?.id,
                              title: category[index + 1]?.title,
                              topImage: category[index + 1]?.thumbnail,
                            ),
                        childCount: category.length - 1),
                    itemExtent: 303)
              ],
            );
          },
        ),
      ),
    );
  }

  void getHomeData() async {
    manager.loadingDialog();

    await ApiService.getTubiTVHomeData(
            platform: Utils.isAndroid ? "android" : "iphone", deviceId: "11111")
        .then((value) {
      manager.content(value);
    }).catchError((error) {
      manager.error();
    });
  }
}
