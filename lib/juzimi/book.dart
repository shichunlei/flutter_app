import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class BookListPage extends StatefulWidget {
  final String category;

  BookListPage({Key key, @required this.category})
      : assert(category != null),
        super(key: key);

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;

  bool isLoadComplete = false;

  List<JuzimiBook> data = [];

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
    if (data.isNotEmpty) {
      return EasyRefresh(
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
              padding: EdgeInsets.all(5.0),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (Utils.width - 12) / 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.65),
              itemBuilder: (BuildContext context, int index) => Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: GestureDetector(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Hero(
                              tag: data[index].image,
                              child: ImageLoadView(
                                '${data[index].image}',
                                width: (Utils.width - 12) / 2,
                                height: (Utils.width - 12) * 10 / 13,
                              )),
                          Container(
                              padding: EdgeInsets.all(5.0),
                              color: Color(0x9affffff),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text('《${data[index].name}》',
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1)),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Text('-- ${data[index].author}',
                                          style: TextStyle(color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1))
                                ],
                                mainAxisSize: MainAxisSize.min,
                              ))
                        ],
                      ),
                      onTap: () {}))));
    } else {
      return getLoadingWidget();
    }
  }

  void getCelebrityByCategory(String category, int page) async {
    JuzimiResult result = await ApiService.getBookList(category, page);
    if (result.books.length < 20 || result.totalPage == page) {
      isLoadComplete = true;
    }
    List<JuzimiBook> list = result.books;
    data.addAll(list);
    setState(() {});
  }
}
