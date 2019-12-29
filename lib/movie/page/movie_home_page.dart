import 'package:flutter/material.dart';
import 'package:flutter_app/movie/index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../page_index.dart';

class MovieHomePage extends StatefulWidget {
  MovieHomePage({Key key}) : super(key: key);

  @override
  createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  LoaderState _status = LoaderState.Loading;

  /// 头部banner新闻
  List<MovieNews> banners = [];

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
      appBar: AppBar(
        title: Text('豆瓣电影'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesome.filter),
              onPressed: () => pushNewPage(context, MovieFilterPage()))
        ],
      ),
      backgroundColor: Colors.white,
      body: LoaderContainer(
        contentView: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            BannerView(banner: banners),
            SectionView(
              "影院热映",
              onPressed: () => pushNewPage(context, MovieHotPage()),
              child: Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: hotMovies
                          .map((movie) => MovieGridView(movie))
                          .toList())),
            ),
            SectionView(
              "即将上映",
              onPressed: () => pushNewPage(context, MovieSoonPage()),
              child: ItemGridView(movies: soonMovies),
            ),
            SectionView(
              "电影榜单",
              more: '年度榜单',
              onPressed: () => showYearsDialog(),
              child: RankingBanner(ranges),
            ),
            SectionView(
              "分类浏览",
              onPressed: () => pushNewPage(context, MovieClassifyPage()),
              child: Column(children: widgets),
            ),
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
        ClassifySection(tags?.first?.title, tags?.first?.subjects),
        ClassifySection(
            tags?.elementAt(1)?.title, tags?.elementAt(1)?.subjects),
        ClassifySection(tags?.elementAt(2)?.title, tags?.elementAt(2)?.subjects)
      ];

      ranges = data.ranges;
    }

    if (mounted) setState(() {});
  }

  void showYearsDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('豆瓣年度榜单'),
            titlePadding: EdgeInsets.all(20),
            children: <Widget>[
              ListTile(
                title: Text('豆瓣电影2019年度榜单'),
                onTap: () {
                  Navigator.pop(context);
                  pushNewPage(context, MovieRangePage(year: 2019));
                },
              ),
              ListTile(
                title: Text('豆瓣电影2018年度榜单'),
                onTap: () {
                  Navigator.pop(context);
                  pushNewPage(context, MovieRangePage(year: 2018));
                },
              ),
              ListTile(
                title: Text('豆瓣电影2017年度榜单'),
                onTap: () {
                  Navigator.pop(context);
                  pushNewPage(context, MovieRangePage(year: 2017));
                },
              ),
              ListTile(
                title: Text('豆瓣电影2016年度榜单'),
                onTap: () {
                  Navigator.pop(context);
                  pushNewPage(context, MovieRangePage(year: 2016));
                },
              ),
              ListTile(
                title: Text('豆瓣电影2015年度榜单'),
                onTap: () {
                  Navigator.pop(context);
                  pushNewPage(context, MovieRangePage(year: 2015));
                },
              ),
            ],
            contentPadding: EdgeInsets.all(0),
          );
        });
  }
}
