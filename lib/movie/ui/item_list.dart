import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemList extends StatelessWidget {
  final VoidCallback onTap;
  final Movie movie;

  ItemList({Key key, this.movie, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 影片图片
    var movieImage = ClipRRect(
      /// 圆角
      borderRadius: BorderRadius.circular(4.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: movie.images.medium.toString(),
        fit: BoxFit.fill,
        height: 150.0,
        width: 100.0,
      ),
    );

    var casts = '';
    for (int i = 0; i < movie.casts.length; i++) {
      if (i == 0) {
        casts = casts + movie.casts[i].name;
      } else {
        casts = casts + '/' + movie.casts[i].name;
      }
    }

    var directors = '';
    for (int i = 0; i < movie.directors.length; i++) {
      if (i == 0) {
        directors = directors + movie.directors[i].name;
      } else {
        directors = directors + '/' + movie.directors[i].name;
      }
    }

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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.black),
          ),

          /// 导演
          Text('导演：' + directors, maxLines: 2, overflow: TextOverflow.ellipsis),

          /// 主演
          Text('主演：' + casts),

          /// 豆瓣评书
          Text('评分：' +
              (movie.rating.average.toInt() == 0
                  ? "暂无评分"
                  : movie.rating.average.toString())),

          SmoothStarRating(
            rating: movie.rating.average / 2.0,

            /// 星的大小
            size: 20,

            /// 评分是否使用整数(1.0或0.5)
            allowHalfRating: false,

            /// 选中颜色
            color: Colors.deepOrange,
          ),

          /// 看过人数
          Row(
            children: <Widget>[
              Text(
                movie.collect_count.toString(),
                style: TextStyle(fontSize: 14.0, color: Colors.orange),
              ),
              Text("人看过"),
            ],
          ),
        ],
      ),
    );

    return GestureDetector(
      //点击事件
      onTap: onTap,

      child: Card(
        margin: EdgeInsets.all(5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            movieImage,
            // Expanded 均分
            Expanded(
              child: movieMsg,
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}
