import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class FirstMovieView extends StatelessWidget {
  final Movie movie;
  final Color cardColor;

  FirstMovieView({Key key, @required this.movie, @required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 200,
        decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: <Widget>[
            ImageLoadView('${movie.images.medium}',
                fit: BoxFit.cover, width: 120, radius: 8),
            Gaps.hGap8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${movie.title}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Gaps.vGap8,
                  Text(
                    '豆瓣评分TM',
                    style: TextStyles.textWhite14,
                    maxLines: 1,
                  ),
                  Gaps.vGap8,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('${movie.rating.average}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold)),
                            SmoothStarRating(
                              rating: movie.rating.average / 2.0,
                              size: 10,
                              allowHalfRating: false,
                              color: Colors.yellow,
                              borderColor: Colors.grey,
                            )
                          ],
                        ),
                        Expanded(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                              StarRate(
                                  rating: 5.0,
                                  starCount: 5,
                                  rate: movie.rating.details.star5,
                                  width: 70,
                                  starColor: Colors.white),
                              StarRate(
                                  rating: 4.0,
                                  starCount: 4,
                                  rate: movie.rating.details.star4,
                                  width: 70,
                                  starColor: Colors.white),
                              StarRate(
                                  rating: 3.0,
                                  starCount: 3,
                                  rate: movie.rating.details.star3,
                                  width: 70,
                                  starColor: Colors.white),
                              StarRate(
                                  rating: 2.0,
                                  starCount: 2,
                                  rate: movie.rating.details.star2,
                                  width: 70,
                                  starColor: Colors.white),
                              StarRate(
                                  rating: 1.0,
                                  starCount: 1,
                                  rate: movie.rating.details.star1,
                                  width: 70,
                                  starColor: Colors.white),
                              Text('${movie.ratingsCount}人评分',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0))
                            ]))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onPressed: () => pushNewPage(context, MovieDetail(movie.id)),
    );
  }
}
