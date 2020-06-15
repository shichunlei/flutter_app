import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;
  final Color pageColor;

  MovieDetailHeader(this.movie, {Key key, this.pageColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String defaultImage =
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3271389503,231131796&fm=26&gp=0.jpg';

    return SliverAppBar(
        pinned: true,
        expandedHeight: 200,
        backgroundColor: pageColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})
        ],
        flexibleSpace: FlexibleSpaceBar(
            title: Text('${movie.title}(${movie.year})'),
            centerTitle: true,
            background: ImageLoadView(
                movie.photos.length > 0
                    ? movie?.photos?.first?.image
                    : defaultImage,
                fit: BoxFit.fitWidth,
                sigmaX: 5.0,
                sigmaY: 6.0,
                opacity: 0.4,
                filterColor: pageColor,
                child: ImageLoadView(movie.images.large.toString(),
                    height: 191.5, width: 135.0))));
  }
}
