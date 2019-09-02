import 'package:flutter/material.dart';
import 'package:custom_widgets/custom_widgets.dart';

class StarRatingWidget extends StatefulWidget {
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  double rating = 0.0;
  double rating2 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('评分控件'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SmoothStarRating(
                rating: rating,

                /// 评分总星数
                starCount: 5,

                /// 评分更新回调
                onRatingChanged: (value) {
                  setState(() {
                    rating = value;
                  });
                },
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: SmoothStarRating(
                rating: rating2,
                starCount: 5,

                /// 星的大小
                size: 45,

                /// 评分是否使用整数(1.0或0.5)
                allowHalfRating: true,

                /// 选中颜色
                color: Colors.red,

                /// 星星边框颜色
                borderColor: Colors.yellow,
                onRatingChanged: (value) {
                  print("点击事件");
                  setState(() {
                    rating2 = value;
                  });
                },
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Center(
              child: SmoothStarRating(
                rating: 6.2 / 2,
                starCount: 5,

                /// 星的大小
                size: 20,

                /// 评分是否使用整数(1.0或0.5)
                allowHalfRating: false,

                /// 选中颜色
                color: Colors.red,

                onRatingChanged: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
