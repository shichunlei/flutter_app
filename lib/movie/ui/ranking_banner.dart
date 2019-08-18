import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../../page_index.dart';
import '../page/movie_ranking_home.dart';
import '../page/movie_top250.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_app/custom_widgets/smooth_star_rating.dart';

class RankingBanner extends StatelessWidget {
  final List<List<Movie>> movies;

  RankingBanner(this.movies);

  final double radius = 10.0;
  final double height = 200.0;

  final List<String> titles = ['一周口碑电影榜', '豆瓣电影Top250', '一周新电影榜', '北美电影票房榜'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              /// 圆角
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: <Widget>[
                  ImageLoadView(movies[index][0].images.medium,
                      height: height,
                      width: double.infinity,
                      fit: BoxFit.cover),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(radius))),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 15.0, right: 15.0, bottom: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              index == 1
                                  ? "豆瓣榜单~共250部"
                                  : '每周五更新~共${movies[index].length}部',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                            SizedBox(height: 8),
                            Text(
                              titles[index],
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: double.infinity,
                          color: Color(0xaa000000),
                          child: ListView.builder(
                            itemBuilder: (context, i) => Container(
                              height: 30.0,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '${i + 1}.${movies[index][i].title}',
                                      style: TextStyle(color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SmoothStarRating(
                                    rating:
                                        movies[index][i].rating.average / 2.0,
                                    size: 18,
                                    allowHalfRating: false,
                                    color: Colors.deepOrangeAccent,
                                    borderColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),

                            ///   _buildItem(movies[index][i], i + 1),
                            itemCount: movies[index].length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: movies.length,
        viewportFraction: 0.9,
        autoplay: true,
        onTap: (index) {
          if (index == 1) {
            pushNewPage(context, MovieTop250());
          } else if (index == 0) {
            pushNewPage(context, MovieRakingHome(index: 1));
          } else if (index == 2) {
            pushNewPage(context, MovieRakingHome(index: 0));
          } else if (index == 3) {
            pushNewPage(context, MovieRakingHome(index: 2));
          }
        },
      ),
    );
  }
}
