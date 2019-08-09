import 'package:flutter/material.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_ranking_movie.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MovieTop250 extends StatefulWidget {
  @override
  _MovieTop250State createState() => _MovieTop250State();
}

class _MovieTop250State extends State<MovieTop250> {
  int page = 1;
  int pagesize = 30;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;

  List<Movie> movies = [];

  var text = "";

  bool loadError = false;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getMovieTop250List(page, pagesize, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('豆瓣排行前250电影'),
      ),
      body: _builderPageView(movies),
    );
  }

  Widget _builderPageView(List<Movie> movies) {
    if (isFirst && movies.isEmpty) {
      return getLoadingWidget();
    } else {
      if (loadError) {
        return Center(
          child: RaisedButton(
            onPressed: () {
              page = 1;
              getMovieTop250List(page, pagesize, RefreshType.DEFAULT);
            },
            child: Text("加载失败"),
          ),
        );
      } else if ((movies.isNotEmpty)) {
        return _builderGridView(movies);
      } else {
        return Center(child: Text(text));
      }
    }
  }

  Widget _builderGridView(List<Movie> movies) {
    return EasyRefresh(
      key: _easyRefreshKey,

      /// 自动控制(刷新和加载完成)
      autoControl: true,

      /// 底部视图
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),

      ///加载回调方法
      loadMore: isLoadComplete
          ? null
          : () async {
              page++;
              getMovieTop250List(page, pagesize, RefreshType.LOAD_MORE);
            },

      emptyWidget: Center(child: Text(text)),

      /// 子部件 内容视图
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemRankingMovie(
            movies[index],
            index: index,
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

  void getMovieTop250List(int page, int pagesize, RefreshType type) async {
    List<Movie> list = await ApiService.getTop250List(
        start: (page - 1) * pagesize, count: pagesize);
    if (type == RefreshType.DEFAULT) {
      movies.addAll(list);
      if (isFirst && movies.isEmpty) {
        text = "暂无数据";
      } else {
        text = "";
      }
    } else if (type == RefreshType.LOAD_MORE) {
      movies.addAll(list);
      if (list.isEmpty) {
        Toast.show(context, "加载完...",
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        isLoadComplete = true;
      }
    }

    if (isFirst) {
      loadError = movies == null;
      isFirst = false;
    }

    setState(() {});
  }
}
