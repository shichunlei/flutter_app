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
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: pageColor,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.favorite_border), onPressed: () {})
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text('${movie.title}(${movie.year})'),
        background: Stack(
          children: <Widget>[
            ImageLoadView(
                movie.photos.isNotEmpty ? movie.photos[0].image : defaultImage,
                fit: BoxFit.fitWidth,
                width: double.infinity),

            /// 加上一层毛玻璃效果
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 6.0,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: pageColor,
                  ),
                ),
              ),
            ),
            Center(
                child: ImageLoadView(movie.images.large.toString(),
                    height: 191.5, width: 135.0)),
          ],
        ),
      ),
    );
  }
}
