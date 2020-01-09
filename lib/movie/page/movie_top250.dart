import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieTop250 extends StatefulWidget {
  @override
  createState() => _MovieTop250State();
}

class _MovieTop250State extends State<MovieTop250> {
  int page = 1;
  int pageSize = 30;

  bool isFirst = true;

  List<Movie> movies = [];

  var text = "";

  bool loadError = false;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getMovieTop250List(page, pageSize, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('豆瓣排行前250电影')),
        body: _builderPageView(movies));
  }

  Widget _builderPageView(List<Movie> movies) {
    if (isFirst && movies.isEmpty) {
      return LoadingWidget();
    } else {
      if (loadError) {
        return Center(
          child: RaisedButton(
            onPressed: () {
              page = 1;
              getMovieTop250List(page, pageSize, RefreshType.DEFAULT);
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
        footer: BallPulseFooter(),

        ///加载回调方法
        onLoad: isLoadComplete
            ? null
            : () async {
          page++;
          getMovieTop250List(page, pageSize, RefreshType.LOAD_MORE);
        },
        emptyWidget: movies.length > 0 ? null : Center(child: Text(text)),

        /// 子部件 内容视图
        child: ListView.builder(
            itemBuilder: (context, index) =>
                ItemRankingMovie(movies[index],
                    index: index,
                    onTap: () =>
                        pushNewPage(context, MovieDetail(movies[index].id))),
            itemCount: movies.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(5.0)));
  }

  void getMovieTop250List(int page, int pageSize, RefreshType type) async {
    List<Movie> list =
    await ApiService.getTop250List(page: page, limit: pageSize);
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
        Toast.show(context, "加载完...");
        isLoadComplete = true;
      }
    }

    if (isFirst) {
      loadError = movies == null;
      isFirst = false;
    }

    if (mounted) setState(() {});
  }
}
