import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/details/movie_detail_page.dart';
import 'package:flutter_app/movie/list/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieGridPage extends StatefulWidget {
  @override
  createState() => MovieGridStatePage();
}

class MovieGridStatePage extends State<MovieGridPage> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    var content;
    if (movies.isEmpty) {
      content = Center(
        // 可选参数 child:
        child: CircularProgressIndicator(),
      );
    } else {
      content = getGridViewBuilder();
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("电影"),
      ),
      body: content,
    );
  }

  getMovieList() async {
    var httpClient = HttpClient();
    var url =
        'https://api.douban.com/v2/movie/top250?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100';
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

  Widget getGridViewBuilder() {
    return GridView.builder(
      padding: EdgeInsets.all(6.0),

      /// 网格代理对象，一般使用SliverGridDelegateWithFixedCrossAxisCount对象创建，可指定crossAxisCount、mainAxisSpacing、crossAxisSpacing和childAspectRatio等值。
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
        crossAxisCount: 3,

        /// 表示主轴方向单元格的间距。
        mainAxisSpacing: 5.0,

        /// 表示垂直于主轴方向的单元格间距。
        crossAxisSpacing: 5.0,

        /// 表示单元格的宽高比。
        childAspectRatio: 270 / 383,
      ),

      /// 其值为一个函数：Widget Function(BuildContext context, int index)，实现该函数用于创建每个网格对应的Widget。
      itemBuilder: (context, index) {
        return GestureDetector(
          //点击事件
          onTap: () => navigateToMovieDetailPage(movies[index], index),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: movies[index].smallImage,
          ),
        );
      },

      /// 表示网格的单元格总数。
      itemCount: movies.length,
    );
  }

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
}
