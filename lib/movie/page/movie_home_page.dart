import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/news.dart';
import 'package:flutter_app/movie/page/movie_classify_page.dart';
import 'package:flutter_app/movie/page/movie_hot.dart';
import 'package:flutter_app/movie/page/movie_soon.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/banner_view.dart';
import 'package:flutter_app/movie/ui/classify_section_home.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';
import 'package:flutter_app/movie/ui/item_grid_view.dart';
import 'package:flutter_app/movie/ui/movie_grid_view.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/route_util.dart';

class MovieHomePage extends StatefulWidget {
  @override
  _MovieHomePageState createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  List<News> banner = [];
  List<Movie> hotMovies = [];
  List<Movie> soonMovies = [];

  @override
  void initState() {
    super.initState();

    getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣电影')),
      body: bodyView(),
      backgroundColor: Colors.white,
    );
  }

  Future<void> getHomeData() async {
    banner = await ApiService.getNewsList();
    hotMovies =
        await ApiService.getNowPlayingList(city: "北京", start: 0, count: 6);
    soonMovies = await ApiService.getComingList(start: 0, count: 6);
    LogUtil.v(banner.toString());
    setState(() {});
  }

  Widget bodyView() {
    if (banner.length == 0) {
      return Center(child: CupertinoActivityIndicator());
    } else {
      return ListView(
        children: <Widget>[
          BannerView(banner: banner),
          HomeSectionView("影院热映",
              onPressed: () => pushNewPage(context, MovieHotPage())),
          Container(
            padding: EdgeInsets.all(6.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: hotMovies.map((movie) => MovieGridView(movie)).toList(),
            ),
          ),
          HomeSectionView("即将上映",
              onPressed: () => pushNewPage(context, MovieSoonPage())),
          ItemGridView(movies: soonMovies),
          HomeSectionView("电影榜单", hiddenMore: true),

          HomeSectionView("分类浏览",
              onPressed: () => pushNewPage(context, MovieClassifyPage())),
          ClassifySection(
              '${Config.GenreList[Random().nextInt(Config.GenreList.length - 1)]}'),
          ClassifySection(
              '${Config.RegionList[Random().nextInt(Config.RegionList.length - 1)]}'),
          ClassifySection(
              '${Config.FeatureList[Random().nextInt(Config.FeatureList.length - 1)]}'),
          ClassifySection(
              '${Config.YearList[Random().nextInt(Config.YearList.length - 1)]}'),
        ],
      );
    }
  }
}
