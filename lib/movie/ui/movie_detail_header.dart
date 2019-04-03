import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailHeader extends StatelessWidget {
  final Movie movie;
  final Color pageColor;

  MovieDetailHeader(this.movie, {Key key, this.pageColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movie.photos[0].image,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: double.infinity,
            ),

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
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: movie.images.large.toString(),
                fit: BoxFit.fill,
                height: 191.5,
                width: 135.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
