import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';

import '../../page_index.dart';

class ItemRankingMovie extends StatefulWidget {
  final Movie movie;
  final int index;
  final VoidCallback onTap;

  ItemRankingMovie(
    this.movie, {
    Key key,
    this.index = 0,
    this.onTap,
  }) : super(key: key);

  @override
  createState() => _ItemRankingMovieState();
}

class _ItemRankingMovieState extends State<ItemRankingMovie>
    with AutomaticKeepAliveClientMixin<ItemRankingMovie> {
  @override
  bool get wantKeepAlive => true;

  List<Color> colors = [
    Colors.red,
    Colors.deepOrange,
    Colors.orangeAccent,
    Color(0x2affffff)
  ];

  Color cardBackgroundColor = Color(0xff35374c);

  @override
  void initState() {
    super.initState();
    getBackgroundColor();
  }

  void getBackgroundColor() async {
    cardBackgroundColor = await Utils.getImageDarkMutedColor(
        widget.movie.images.small,
        defaultColor: Color(0xff35374c));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String desc = '${widget.movie.year}\n';
    widget.movie.genres.map((genre) {
      desc += genre;
      desc += ' ';
    }).toList();

    widget.movie.pubDates.map((date) {
      desc += '\n';
      desc += '$date上映';
    }).toList();

    desc += "\n${widget.movie?.durations?.first ?? ''}";

    return BouncingView(
        child: Card(
          color: cardBackgroundColor,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// 排行
                      Container(
                        width: 80.0,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0),
                          ),
                          color: widget.index > 2
                              ? colors[3]
                              : colors[widget.index],
                        ),
                        child: Text(
                          'No.${widget.index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                      ),
                      Gaps.vGap10,

                      /// 电影信息
                      Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// 电影主图
                              ImageLoadView(
                                  widget.movie.images.medium.toString(),
                                  height: 180,
                                  width: 120),
                              Gaps.hGap8,

                              /// 右侧部分
                              Expanded(
                                child: Column(

                                    /// 垂直居上
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    /// 水平居左
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// 中文名
                                      Text(
                                        widget.movie.title,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                        ),
                                      ),
                                      Gaps.vGap8,

                                      /// 评分
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SmoothStarRating(
                                              rating:
                                                  widget.movie.rating.average /
                                                      2.0,
                                              size: 18,
                                              allowHalfRating: false,
                                            ),
                                            Text(
                                                '${widget.movie.rating.average}分',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      Gaps.vGap8,

                                      /// 上映信息
                                      Text(
                                        desc,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                    ]),
                              ),
                            ]),
                      ),
                    ]),
              ),

              /// 收藏
              GestureDetector(
                onTap: () {},
                child: Column(children: <Widget>[
                  Icon(Icons.favorite_border, color: Colors.white),
                  Gaps.vGap6,
                  Text(' 收藏 ', style: TextStyle(color: Colors.white))
                ]),
              ),
            ]),
          ),
        ),
        onPressed: widget.onTap);
  }
}
