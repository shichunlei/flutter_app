import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/news.dart';
import 'package:flutter_app/movie/page/movie_classify_page.dart';
import 'package:flutter_app/movie/page/movie_hot.dart';
import 'package:flutter_app/movie/page/movie_soon.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/banner_view.dart';
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
    return Scaffold(appBar: AppBar(title: Text('豆瓣电影')), body: bodyView());
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
          ItemGridView(movies: hotMovies),
          HomeSectionView("即将上映",
              onPressed: () => pushNewPage(context, MovieSoonPage())),
          Container(
            padding: EdgeInsets.all(6.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children:
                  soonMovies.map((movie) => MovieGridView(movie)).toList(),
            ),
          ),
          HomeSectionView("电影榜单", hiddenMore: true),
          HomeSectionView("分类浏览",
              onPressed: () => pushNewPage(context, MovieClassifyPage())),
        ],
      );
    }
  }
}
