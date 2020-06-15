import 'package:flutter/material.dart';
import '../../page_index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../index.dart';

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
          child: Stack(
            children: <Widget>[
              ImageLoadView(list[index]?.subjects?.first?.images?.medium,
                  height: height,
                  width: double.infinity,
                  opacity: 0.5,
                  filterColor: Colors.black,
                  radius: radius),
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
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        Gaps.vGap8,
                        Text(
                          list[index].title,
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
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
                                rating: list[index].subjects[i].rating.average /
                                    2.0,
                                size: 18,
                                allowHalfRating: false,
                                color: Colors.deepOrangeAccent,
                                borderColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        itemCount: list[index].subjects.length,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
