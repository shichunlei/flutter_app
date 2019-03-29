import 'package:flutter/material.dart';

import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieGridView extends StatelessWidget {
  final Movie movie;

  MovieGridView(this.movie);

  @override
  Widget build(BuildContext context) {
    double width = (Utils.width - 6 * 2 - 5 * 2) / 3;
    double height = width * 383 / 270;

    return GestureDetector(
      onTap: () => pushNewPage(context, MovieDetail(id: movie.id)),
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movie.images.medium.toString(),
              fit: BoxFit.fill,
              height: height,
            ),
            SizedBox(height: 5),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            SizedBox(height: 3),
            SmoothStarRating(
              rating: movie.rating.average / 2,
              starCount: 5,
              size: 18,
              allowHalfRating: false,
              color: Colors.deepOrange,
            ),
          ],
        ),
      ),
    );
  }
}
