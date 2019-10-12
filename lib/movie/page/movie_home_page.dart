import 'package:flutter/material.dart';
import 'package:flutter_app/bean/index.dart';
import 'package:flutter_app/movie/ui/index.dart';

import '../../page_index.dart';
import 'movie_classify_page.dart';
import 'movie_hot.dart';
import 'movie_soon.dart';

class MovieHomePage extends StatefulWidget {
  MovieHomePage({Key key}) : super(key: key);

  @override
  createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  LoaderState _status = LoaderState.Loading;

  /// 头部banner新闻
  List<News> banners = [];

  /// 影院热映
  List<Movie> hotMovies = [];

  /// 即将上映
  List<Movie> soonMovies = [];

  List<MovieTag> ranges = [];

  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();

    getMovieData("北京");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣电影'), automaticallyImplyLeading: false),
      backgroundColor: Colors.white,
      body: LoaderContainer(
        contentView: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            BannerView(banner: banners),
            SectionView("影院热映",
                onPressed: () => pushNewPage(context, MovieHotPage())),
            Container(
                padding: EdgeInsets.all(6.0),
                child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: hotMovies
                        .map((movie) => MovieGridView(movie))
                        .toList())),
            SectionView("即将上映",
                onPressed: () => pushNewPage(context, MovieSoonPage())),
            ItemGridView(movies: soonMovies),
            SectionView("电影榜单", hiddenMore: true),
            RankingBanner(ranges),
            SectionView("分类浏览",
                onPressed: () => pushNewPage(context, MovieClassifyPage())),
            ...widgets,
          ],
        ),
        loaderState: _status,
      ),
    );
  }

  void getMovieData(String city) async {
    MovieHomeData data = await ApiService.getMovieHomeData(city: city);

    if (data != null) {
      _status = LoaderState.Succeed;

      banners = data.banners;
      hotMovies = data.inTheaters;
      soonMovies = data.soonMovies;

      List<MovieTag> tags = data.category;

      widgets = [
        ClassifySection(tags[0].title, tags[0].subjects),
        ClassifySection(tags[1].title, tags[1].subjects),
        ClassifySection(tags[2].title, tags[2].subjects)
      ];

      ranges = data.ranges;
    }

    setState(() {});
  }
}
