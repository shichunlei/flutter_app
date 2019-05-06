import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
    return data.isNotEmpty
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
                    maxCrossAxisExtent: Utils.width / 4,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 0.8),
                itemBuilder: (BuildContext context, int index) => Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: GestureDetector(
                        child: Column(children: <Widget>[
                          Hero(
                              tag: data[index].image,
                              child: ImageLoadView(
                                '${data[index].image}',
                                width: Utils.width / 4,
                              )),
                          Container(
                              alignment: Alignment.center,
                              child: Text('${data[index].name}',
                                  style: TextStyle(color: Colors.pink),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1))
                        ]),
                        onTap: () {}))))
        : getLoadingWidget();
  }

  void getCelebrityByCategory(String category, int page) async {
    JuzimiResult result = await ApiService.getCelebrityList(category, page);
    if (result.celebrity.length < 20 || result.totalPage == page) {
      isLoadComplete = true;
    }
    List<JuzimiCelebrity> list = result.celebrity;
    data.addAll(list);
    setState(() {});
  }
}
