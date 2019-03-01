import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/movie/ui/item_list.dart';
import 'package:flutter_app/utils/api.dart';
import 'package:flutter_app/utils/http_utils.dart';
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

  @override
  void initState() {
    super.initState();
    getMovieHotList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('正在热映电影'),
      ),
      body: Stack(
        children: <Widget>[
          Center(child: getLoadingWidget()),
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
            child: ListView(
              /// 表示列表包含的widget集合，整个滚动视图中的内容设置。
              children: _buildMovieItems(movies),

              /// 表示控件滚动的方向，主要有两个值可设置。Axis.vertical表示垂直滚动视图；Axis.horizontal表示水平滚动视图。
              scrollDirection: Axis.vertical,

              /// 可设置值为true|false。true时表示内容不足够填充控件区间时也可以有滚动反馈；false表示只有内容超出控件大小时才可滚动。
              primary: true,

              /// 表示读取内容的方向是否颠倒，可设置值为true|false。false表示由左向右或由上向下读取；true表示由右向左或由下向上读取。
              reverse: false,

              /// 表示物理反馈，一般设置值为AlwaysScrollableScrollPhysics()|ScrollPhysics()。AlwaysScrollableScrollPhysics表示总是有滚动反馈，无论primary值为true or false；ScrollPhysics表示只有只有内容超出控件大小时才会有滚动反馈，无论primary值为true or false。
              physics: const AlwaysScrollableScrollPhysics(),

              /// 表示控件的内边距。
              padding: EdgeInsets.all(10.0),
            ),
          ),
        ],
      ),
    );
  }

  _buildMovieItems(List<Movie> movies) {
    List<Widget> widgets = [];
    for (int i = 0; i < movies.length; i++) {
      Movie movie = movies[i];

      widgets.add(ItemList(
          movie: movie,
          onTap: () => pushNewPage(context, MovieDetail(id: movie.id))));
    }
    return widgets;
  }

  void getMovieHotList() async {
    var data = {'apikey': '0b2bdeda43b5688921839c8ecb20399b', 'city': '北京'};
    Response response = await HttpUtils().get(Api.MOVIE_LIST_URL, data: data);
    if (response.statusCode != 200) {
      loadError = true;
    } else {
      var jsonData = response.data;

      Result result = Result.fromMap(jsonData);

      print("================================");
      print('${result.title} ${result.start} ${result.subjects.toString()}');

      movies = result.subjects;

      if (movies.length == 0) {
        isEmpty = true;
      }
    }
    setState(() {});
  }
}
