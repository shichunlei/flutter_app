import 'package:flutter/material.dart';

import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/custom_widgets/smooth_star_rating.dart';

import '../../page_index.dart';

class MovieGridView extends StatefulWidget {
  final Movie movie;
  final Color textColor;

  MovieGridView(this.movie, {Key key, this.textColor = Colors.black})
      : super(key: key);

  @override
  createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView>
    with SingleTickerProviderStateMixin {
  var _animationController;
  var _animation;

  @override
  void initState() {
    super.initState();

    // 定义动画控制器
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    // 定义动画
    _animation =
        Tween<double>(begin: 1, end: 0.98).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = (Utils.width - 6 * 2 - 5 * 2) / 3;
    double height = width * 383 / 270;

    return GestureDetector(
        onTap: () => pushNewPage(context, MovieDetail(widget.movie.id)),
        onPanDown: (details) {
          debugPrint('onPanDown');
          _animationController.forward(); // 点击的时候播放动画
        },
        onPanCancel: () {
          debugPrint('onPanCancel');
          _animationController.reverse(); // cancel的时候回弹动画
        },
        child: Container(
            width: width,
            child: ScaleTransition(
                scale: _animation, // 定义动画
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ImageLoadView(widget.movie.images.medium.toString(),
                          fit: BoxFit.cover, height: height),
                      SizedBox(height: 5),
                      Text(widget.movie.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: widget.textColor),
                          maxLines: 1),
                      SizedBox(height: 3),
                      SmoothStarRating(
                          rating: widget.movie.rating.average / 2.0,
                          size: 18,
                          allowHalfRating: false,
                          color: Colors.deepOrange)
                    ]))));
  }
}
