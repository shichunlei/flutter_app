import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/details/movie_detail_page.dart';
import 'package:flutter_app/movie/list/movie.dart';

class MovieListPage extends StatefulWidget {
  @override
  MovieListPageState createState() => new MovieListPageState();
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
      content = new Center(
        // 可选参数 child:
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView(children: buildMovieItems());
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('电影'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.person),
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
      var movieImage = new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Image.network(
          movie.smallImage,
          width: 100.0,
          height: 120.0,
        ),
      );

      var movieMsg = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            movie.title,
            textAlign: TextAlign.left,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black),
          ),
          new Text('导演：' + movie.director),
          new Text('主演：' + movie.cast),
          new Text('评分：' + movie.average),
          new Row(
            children: <Widget>[
              new Text(
                movie.collectCount.toString(),
                style: new TextStyle(fontSize: 14.0, color: Colors.orange),
              ),
              new Text("人看过"),
            ],
          ),
        ],
      );

      var movieItem = new GestureDetector(
        //点击事件
        onTap: () => navigateToMovieDetailPage(movie, i),

        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                movieImage,
                // Expanded 均分
                new Expanded(
                  child: movieMsg,
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            new Divider(),
          ],
        ),
      );

      widgets.add(movieItem);
    }
    return widgets;
  }

  // 跳转页面
  navigateToMovieDetailPage(Movie movie, Object imageTag) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new MovieDetailPage(movie, imageTag: imageTag);
    }));
  }

  //网络请求
  getMovieListData() async {
    var httpClient = new HttpClient();
    var url =
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.OK) {
      var jsonData = await response.transform(utf8.decoder).join();

      // setState 相当于 runOnUiThread
      setState(() {
        movies = Movie.decodeData(jsonData.toString());
      });
    }
  }
}
