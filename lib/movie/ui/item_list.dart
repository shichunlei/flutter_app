import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';

import '../../page_index.dart';

class ItemList extends StatelessWidget {
  final VoidCallback onTap;
  final Movie movie;

  ItemList({Key key, this.movie, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 影片图片
    var movieImage = ImageLoadView(movie.images.medium,
        radius: 4, height: 150.0, width: 100.0);

    var casts = '';
    movie.casts.map((cast) {
      casts += cast.name + '/';
    }).toList();

    var directors = '';
    movie.directors.map((director) {
      directors += director.name + ' ';
    }).toList();

    var movieMsg = Container(
      //高度
      height: 150.0,
      margin: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /// 电影名称（中文名）
          Text(
            movie.title,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Colors.black),
          ),

          /// 导演
          Text('导演：' + directors, maxLines: 2, overflow: TextOverflow.ellipsis),

          /// 主演
          Text('主演：' + casts),

          Row(
            children: <Widget>[
              /// 豆瓣评书
              Text('评分：' +
                  (movie.rating.average.toInt() == 0
                      ? "暂无评分"
                      : movie.rating.average.toString())),

              SizedBox(width: 10.0),
              Offstage(
                offstage: movie.rating.average.toInt() == 0,
                child: SmoothStarRating(
                  rating: movie.rating.average / 2.0,

                  /// 星的大小
                  size: 20,

                  /// 评分是否使用整数(1.0或0.5)
                  allowHalfRating: false,

                  /// 选中颜色
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return BouncingView(
      //点击事件
      onPressed: onTap,

      child: Card(
        child: Row(
          children: <Widget>[
            movieImage,
            // Expanded 均分
            Expanded(
              child: movieMsg,
            ),
          ],
        ),
      ),
    );
  }
}
