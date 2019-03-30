import 'package:flutter/material.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDesc extends StatefulWidget {
  final Movie movie;

  MovieDesc(this.movie);

  @override
  _MovieDescState createState() => _MovieDescState();
}

class _MovieDescState extends State<MovieDesc> {
  Color pageColor;

  @override
  void initState() {
    super.initState();
    getBackgroundColor();
  }

  void getBackgroundColor() async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(widget.movie.images.medium));

    setState(() {
      if (paletteGenerator.lightVibrantColor != null) {
        pageColor = paletteGenerator.lightVibrantColor.color;
      } else {
        pageColor = Color(0xff35374c);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String desc = '';

    widget.movie.tags.map((tag) {
      if (Config.RegionList.indexOf(tag) != -1) {
        desc += tag;
        desc += ' ';
      }
    }).toList();

    desc += '/ ';

    widget.movie.genres.map((genre) {
      desc += genre;
      desc += ' ';
    }).toList();

    desc += '/ ';

    widget.movie.languages.map((language) {
      desc += language;
      desc += ' ';
    }).toList();

    desc += '/ ';

    desc += '${widget.movie.pubdates[0]}上映 / 片长${widget.movie.durations[0]}';

    num totalRating = widget.movie.rating.details.star5 +
        widget.movie.rating.details.star4 +
        widget.movie.rating.details.star3 +
        widget.movie.rating.details.star2 +
        widget.movie.rating.details.star1;

    return Card(
      color: pageColor,
      margin: const EdgeInsets.all(10.0),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            /// 图片，名称等
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// 图片
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.movie.images.large.toString(),
                  fit: BoxFit.cover,
                  width: 88,
                  height: 130,
                ),
                SizedBox(width: 10.0),

                /// 名称等
                Container(
                  width: Utils.width - 138.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// 中文名
                      Text(
                        widget.movie.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),

                      /// 原名
                      Text(
                        '${widget.movie.original_title}(${widget.movie.year})',
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                      ),

                      /// 国家、类型、上映（时间）等
                      Text(
                        desc,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),

                      /// 想看、看过
                      Row(
                        children: <Widget>[
                          _buildButton('想看', Icons.favorite),
                          SizedBox(width: 8),
                          _buildButton('看过', Icons.star),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// 豆瓣评分
            Card(
              elevation: 0.0,
              color: Color(0x20000000),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '豆瓣评分',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      /// 两端对齐
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _buildAverage(widget.movie.rating.average),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            _buildStarRate(
                              5,
                              5,
                              totalRating == 0
                                  ? 0.0
                                  : widget.movie.rating.details.star5 /
                                      totalRating,
                            ),
                            _buildStarRate(
                              4,
                              4,
                              totalRating == 0
                                  ? 0.0
                                  : widget.movie.rating.details.star4 /
                                      totalRating,
                            ),
                            _buildStarRate(
                              3,
                              3,
                              totalRating == 0
                                  ? 0.0
                                  : widget.movie.rating.details.star3 /
                                      totalRating,
                            ),
                            _buildStarRate(
                              2,
                              2,
                              totalRating == 0
                                  ? 0.0
                                  : widget.movie.rating.details.star2 /
                                      totalRating,
                            ),
                            _buildStarRate(
                              1,
                              1,
                              totalRating == 0
                                  ? 0.0
                                  : widget.movie.rating.details.star1 /
                                      totalRating,
                            ),
                            Text(
                              '${widget.movie.reviews_count}人评论',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.white,
                      margin: const EdgeInsets.only(top: 8.0),
                    ),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${(widget.movie.collect_count / 1000).toStringAsFixed(1)}k人看过 ${(widget.movie.wish_count / 1000).toStringAsFixed(1)}k人想看',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 所属频道
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '所属频道',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                  Expanded(
                    child: SizedBox.fromSize(
                      size: Size.fromHeight(30.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.movie.tags.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Chip(
                              label: Text(widget.movie.tags[index].toString()),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRate(double rating, int stars, double rate) {
    return Row(
      children: <Widget>[
        SmoothStarRating(
          rating: rating,
          starCount: stars,
          size: 12,
          color: Colors.blueGrey,
        ),
        SizedBox(width: 8),
        Container(
          width: 100,
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
            value: rate,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        )
      ],
    );
  }

  Widget _buildAverage(num value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(color: Colors.white, fontSize: 38.0),
            ),
            Text(
              '分',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ],
        ),
        SmoothStarRating(
          rating: value / 2,
          starCount: 5,
          size: 18,
          allowHalfRating: false,
          color: Colors.yellow,
          borderColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildButton(String title, IconData icon) {
    return Expanded(
      child: RaisedButton(
        color: Colors.lightGreen,
        onPressed: () {},
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: Colors.yellow, size: 18),
            SizedBox(width: 4),
            Text(title, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
