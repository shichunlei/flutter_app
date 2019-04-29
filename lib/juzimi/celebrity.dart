import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CelebrityPage extends StatefulWidget {
  final List<MingjuClassify> classify;

  CelebrityPage(this.classify, {Key key}) : super(key: key);

  @override
  createState() => _CelebrityPageState();
}

class _CelebrityPageState extends State<CelebrityPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> titleTabs = [];

  TabController controller;

  @override
  void initState() {
    super.initState();
    widget.classify.forEach((type) {
      titleTabs.add(Tab(text: type.title));
    });

    controller = TabController(
        length: widget.classify.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          centerTitle: true,
          title: Text('名人'),
          bottom: TabBar(
              tabs: titleTabs, controller: controller, isScrollable: true)),
      body: TabBarView(
          controller: controller,
          children: titleTabs.map((page) {
            int index = titleTabs.indexOf(page);
            return CelebrityListPage(category: widget.classify[index].tag);
          }).toList()),
    );
  }
}

class CelebrityListPage extends StatefulWidget {
  final String category;

  CelebrityListPage({Key key, this.category}) : super(key: key);

  @override
  createState() => _CelebrityListPageState();
}

class _CelebrityListPageState extends State<CelebrityListPage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;

  bool isLoadComplete = false;

  List<JuzimiCelebrity> data = [];

  @override
  bool get wantKeepAlive => true;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getCelebrityByCategory(widget.category, page);
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
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
                    getCelebrityByCategory(widget.category, page);
                  },
            child: GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Utils.width / 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 0.9),
                itemBuilder: (BuildContext context, int index) => Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: GestureDetector(
                        child: Column(children: <Widget>[
                          Hero(
                              tag: data[index].image,
                              child: ImageLoadView('${data[index].image}')),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('${data[index].name}',
                                  style: TextStyle(color: Colors.pink),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1))
                        ]),
                        onTap: () {}))))
        : getLoadingWidget();
  }

  void getCelebrityByCategory(String category, int page) async {
    List<JuzimiCelebrity> list =
        await ApiService.getCelebrityList(category, page);
    data.addAll(list);
    setState(() {});
  }
}
