import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/details/movie_detail_page.dart';
import 'package:flutter_app/movie/list/movie.dart';
import 'package:flutter_app/utils/api.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';

class MovieListPage extends StatefulWidget {
  @override
  createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    // 一进页面就请求接口，一开始不知道这个 initState 方法 ，折腾了很久
    getMovieListData();
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (movies.isEmpty) {
      content = Center(
        /// 加载菊花
        child: getLoadingWidget(),
      );
    } else {
      content = ListView(
        /// 表示列表包含的widget集合，整个滚动视图中的内容设置。
        children: buildMovieItems(),

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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('电影'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              print('onclick');
            },
          )
        ],
      ),
      body: content,
    );
  }

  buildMovieItems() {
    List<Widget> widgets = [];
    for (int i = 0; i < movies.length; i++) {
      Movie movie = movies[i];

      /// 影片图片
      var movieImage = ClipRRect(
        /// 圆角
        borderRadius: BorderRadius.circular(4.0),
        child: Image.network(
          movie.smallImage,
          width: 100.0,
          height: 150.0,
          fit: BoxFit.fill,
        ),
      );

      var movieMsg = Container(
        //高度
        height: 150.0,
        margin: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// 电影名称
            Text(
              movie.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black),
            ),

            /// 导演
            Text('导演：' + movie.director),
            Text('主演：' + movie.cast),

            /// 豆瓣评书
            Text('评分：' + movie.average),
            Row(
              children: <Widget>[
                Text(
                  movie.collectCount.toString(),
                  style: TextStyle(fontSize: 14.0, color: Colors.orange),
                ),
                Text("人看过"),
              ],
            ),
          ],
        ),
      );

      var movieItem = GestureDetector(
        //点击事件
        onTap: () => navigateToMovieDetailPage(movie, i),

        child: Card(
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              movieImage,
              // Expanded 均分
              Expanded(
                child: movieMsg,
              ),
              const Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      );

      widgets.add(movieItem);
    }
    return widgets;
  }

  // 跳转页面
  navigateToMovieDetailPage(movie, imageTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
              movie,
              imageTag: imageTag,
            ),
      ),
    );
  }

  //网络请求
  getMovieListData() async {
    String url = Api.MOVIE_LIST_URL;
    var data = {
      'apikey': '0b2bdeda43b5688921839c8ecb20399b',
      'city': '北京',
      'start': 0,
      'count': 100,
    };
    var jsonData = await HttpUtils().get(url, data: data);

    // setState 相当于 runOnUiThread
    setState(() {
      movies = Movie.decodeData(jsonData);
    });
  }
}
