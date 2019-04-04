import 'package:flutter/material.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_soon_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MovieSoonPage extends StatefulWidget {
  @override
  _MovieSoonPageState createState() => _MovieSoonPageState();
}

class _MovieSoonPageState extends State<MovieSoonPage> {
  int page = 1;
  int pagesize = 20;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;
  bool isLoadComplete = false;

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    getMovieList(page, pagesize, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('即将上映影片')),
      body: builderPageView(),
    );
  }

  void getMovieList(int page, int pagesize, RefreshType type) async {
    List<Movie> list = await ApiService.getComingList(
        start: (page - 1) * pagesize, count: pagesize);
    if (type == RefreshType.DEFAULT) {
      movies.addAll(list);
      isFirst = false;
    } else if (type == RefreshType.LOAD_MORE) {
      movies.addAll(list);
      if (list.length == 0) {
        Toast.show("加载完...", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        isLoadComplete = true;
      }
    }

    setState(() {});
  }

  Widget builderPageView() {
    if (isFirst && movies.isEmpty) {
      return getLoadingWidget();
    }
    return EasyRefresh(
      key: _easyRefreshKey,
      autoControl: true,
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),
      loadMore: isLoadComplete
          ? null
          : () async {
              page++;
              getMovieList(page, pagesize, RefreshType.LOAD_MORE);
            },
      emptyWidget: Center(child: Text('暂无数据')),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemSoonView(
            movies[index],
            onTap: () {
              pushNewPage(context, MovieDetail(movies[index].id));
            },
          );
        },
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
