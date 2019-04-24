import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
    LogUtil.v('===============${widget.index}================');
  }

  void getBackgroundColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.movie.images.small));

    setState(() {
      if (paletteGenerator.darkVibrantColor != null) {
        cardBackgroundColor = paletteGenerator.darkVibrantColor.color;
      } else {
        cardBackgroundColor = Color(0xff35374c);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String desc = '${widget.movie.year}\n';
    widget.movie.genres.map((genre) {
      desc += genre;
      desc += ' ';
    }).toList();

    widget.movie.pubdates.map((pubdate) {
      desc += '\n';
      desc += '$pubdate上映';
    }).toList();

    desc +=
        '\n${widget.movie.durations.length > 0 ? "${widget.movie.durations[0]}" : ""}';

    return GestureDetector(
      child: Card(
        color: cardBackgroundColor,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
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
                        color:
                            widget.index > 2 ? colors[3] : colors[widget.index],
                      ),
                      child: Text(
                        'No.${widget.index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(height: 10),

                    /// 电影信息
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// 电影主图
                          ImageLoadView(widget.movie.images.medium.toString(),
                              height: 180, width: 120),
                          SizedBox(width: 8),

                          /// 右侧部分
                          Expanded(
                            child: Column(
                              /// 垂直居上
                              mainAxisAlignment: MainAxisAlignment.start,

                              /// 水平居左
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(height: 8.0),

                                /// 评分
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SmoothStarRating(
                                        rating:
                                            widget.movie.rating.average / 2.0,
                                        size: 18,
                                        allowHalfRating: false,
                                      ),
                                      Text('${widget.movie.rating.average}分',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0),

                                /// 上映信息
                                Text(
                                  desc,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 收藏
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    SizedBox(height: 6),
                    Text(
                      ' 收藏 ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
