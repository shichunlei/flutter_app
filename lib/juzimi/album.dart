import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class AlbumListPage extends StatefulWidget {
  final String category;

  AlbumListPage({Key key, this.category}) : super(key: key);

  @override
  createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;

  bool isLoadComplete = false;

  List<MeiTuMeiJu> data = [];

  @override
  bool get wantKeepAlive => true;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getData(widget.category, page);
  }

  @override
  void dispose() {
    super.dispose();
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
                  getData(widget.category, page);
                },
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text('${data[index].desc}'),
                  ),
                );
              },
              itemCount: data.length));
    } else {
      return getLoadingWidget();
    }
  }

  void getData(String category, int page) async {
    JuzimiResult result = await ApiService.getAlbumList(category, page);
    if (result.meijus.length < 10 || result.totalPage == page) {
      isLoadComplete = true;
    }
    List<MeiTuMeiJu> list = result.meijus;
    data.addAll(list);
    setState(() {});
  }
}
