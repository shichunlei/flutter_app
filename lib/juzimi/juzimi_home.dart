import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/juzimi/album.dart';
import 'package:flutter_app/juzimi/book.dart';
import 'package:flutter_app/juzimi/celebrity.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class JuzimiHomePage extends StatefulWidget {
  JuzimiHomePage({Key key}) : super(key: key);

  @override
  createState() => _JuzimiHomePageState();
}

class _JuzimiHomePageState extends State<JuzimiHomePage> {
  List<MeiTuMeiJu> meitumeiju = [];

  List<MingjuClassify> calssify = [];

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
        body: meitumeiju.length > 0
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
    calssify = await ApiService.getMingrenmingjuType();

    List<MeiTuMeiJu> mtmj = await ApiService.getMeiTuMeiJu(page);
    if (mtmj.length < 15) {
      isLoadComplete = true;
    }

    meitumeiju.addAll(mtmj);

    setState(() {});
  }

  Widget _leftMenu() {
    List<Widget> children = [];

    children.add(ImageLoadView(
        'http://img.juzimi.com/juzimi/images/mingrenmingyan.jpg',
        height: 180));

    children.add(SizedBox(height: 20));

    calssify.map((type) {
      int index = calssify.indexOf(type);
      children.add(ListTile(
          title: Text('${type.title}'),
          onTap: () {
            Navigator.pop(context);

            if (index == 0 || index == 1) {
              pushNewPage(context, CelebrityPage(type.classify));
            }
            if (index == 2) {
              pushNewPage(context, BookPage(type.classify));
            }
            if (index == 3) {
              pushNewPage(context, AlbumPage(type.classify));
            }
          },
          trailing: Icon(Icons.arrow_forward_ios)));
    }).toList();

    return Drawer(elevation: 10.0, child: ListView(children: children));
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
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      child: ImageLoadView(meitumeiju[index].image)),
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('${meitumeiju[index].desc}',
                          style: TextStyle(fontSize: 12)))
                ])),
        onTap: () {});
  }
}
