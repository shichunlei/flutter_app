import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/movie/ui/movie_grid_view.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_list.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';

class MovieHotPage extends StatefulWidget {
  @override
  _MovieHotPageState createState() => _MovieHotPageState();
}

class _MovieHotPageState extends State<MovieHotPage> {
  List<Movie> movies = [];

  bool loadError = false;
  bool isEmpty = false;
  bool isFirst = true;

  bool isList = true;

  @override
  void initState() {
    super.initState();
    getMovieHotList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('影院热映'), actions: <Widget>[
        IconButton(
            icon: Icon(isList ? Icons.menu : Icons.apps),
            onPressed: () => setState(() => isList = !isList))
      ]),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !isFirst,
            child: Center(child: getLoadingWidget()),
          ),
          Offstage(
            offstage: !isEmpty,
            child: Center(
              child: Text("暂无数据"),
            ),
          ),
          Offstage(
            offstage: !loadError,
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  getMovieHotList();
                },
                child: Text("加载失败，重新加载"),
              ),
            ),
          ),
          Offstage(
              offstage: loadError && isEmpty,
              child: isList
                  ? ListView(
                      /// 表示列表包含的widget集合，整个滚动视图中的内容设置。
                      children: movies.map((movie) {
                        return ItemList(
                          movie: movie,
                          onTap: () =>
                              pushNewPage(context, MovieDetail(movie.id)),
                        );
                      }).toList(),

                      /// 表示控件滚动的方向，主要有两个值可设置。Axis.vertical表示垂直滚动视图；Axis.horizontal表示水平滚动视图。
                      scrollDirection: Axis.vertical,

                      /// 可设置值为true|false。true时表示内容不足够填充控件区间时也可以有滚动反馈；false表示只有内容超出控件大小时才可滚动。
                      primary: true,

                      /// 表示读取内容的方向是否颠倒，可设置值为true|false。false表示由左向右或由上向下读取；true表示由右向左或由下向上读取。
                      reverse: false,

                      /// 表示物理反馈，一般设置值为AlwaysScrollableScrollPhysics()|ScrollPhysics()。AlwaysScrollableScrollPhysics表示总是有滚动反馈，无论primary值为true or false；ScrollPhysics表示只有只有内容超出控件大小时才会有滚动反馈，无论primary值为true or false。
                      physics: const BouncingScrollPhysics(),

                      /// 表示控件的内边距。
                      padding: EdgeInsets.all(10.0),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        child: Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: movies
                              .map((movie) => MovieGridView(movie))
                              .toList(),
                        ),
                      ),
                    ))
        ],
      ),
    );
  }

  void getMovieHotList() async {
    movies = await ApiService.getNowPlayingList(city: '北京');
    loadError = movies == null;
    if (movies.isEmpty) {
      isEmpty = true;
    }
    isFirst = false;

    setState(() {});
  }
}
