import 'package:flutter/material.dart';
import 'package:flutter_app/bean/index.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieRangeDetailPage extends StatelessWidget {
  final Color cardColor;
  final String topImage;
  final List<Movie> movies;
  final String title;
  final String year;
  final Movie movie;

  MovieRangeDetailPage(
      {Key key,
      @required this.cardColor,
      @required this.topImage,
      this.year,
      this.movies,
      this.movie,
      this.title})
      : assert(cardColor != null, topImage != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ImageLoadView(
                    topImage,
                    width: Utils.width,
                    height: Utils.width / 3 * 4,
                  ),
                  Container(
                    color: Colors.black54,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Column(
                            children: <Widget>[
                              Text(
                                '${title.replaceAll("$year", "").replaceAll("|", "")}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              Gaps.vGap10,
                              Text(
                                '豆瓣$year年度电影榜单',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 5.0),
                              )
                            ],
                          ),
                          top: 80,
                          left: 0,
                          right: 0,
                        ),
                        Positioned(
                          child: FirstMovieView(
                              movie: movie, cardColor: cardColor),
                          bottom: 30,
                          left: 10,
                          right: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(6.0),
                child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movies.map((movie) {
                      int index = movies.indexOf(movie);
                      if (index != 0) {
                        return MovieGridView(movie);
                      } else {
                        return Center();
                      }
                    }).toList()))
          ],
        ),
      ),
    );
  }
}
