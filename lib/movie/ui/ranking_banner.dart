import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../../page_index.dart';
import '../page/movie_ranking_home.dart';
import '../page/movie_top250.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:custom_widgets/custom_widgets.dart';

class RankingBanner extends StatelessWidget {
  final List<MovieTag> list;

  RankingBanner(this.list);

  final double radius = 10.0;
  final double height = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ClipRRect(
            /// 圆角
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: <Widget>[
                ImageLoadView(list[index].subjects[0].images.medium,
                    height: height, width: double.infinity, fit: BoxFit.cover),
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
                            list[index].tip,
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                          Gaps.vGap8,
                          Text(
                            list[index].title,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${i + 1}.${list[index].subjects[i].title}',
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SmoothStarRating(
                                  rating:
                                      list[index].subjects[i].rating.average /
                                          2.0,
                                  size: 18,
                                  allowHalfRating: false,
                                  color: Colors.deepOrangeAccent,
                                  borderColor: Colors.white,
                                ),
                              ],
                            ),
                          ),

                          ///   _buildItem(movies[index][i], i + 1),
                          itemCount: list[index].subjects.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        itemCount: list.length,
        viewportFraction: 0.9,
        onTap: (index) {
          if (list[index].hasMore) {
            pushNewPage(context, MovieTop250());
          } else {
            pushNewPage(context,
                MovieRakingHome(index: index, movies: list[index].subjects));
          }
        },
      ),
    );
  }
}
