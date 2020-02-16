import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieDesc extends StatefulWidget {
  final Movie movie;

  MovieDesc(this.movie);

  @override
  createState() => _MovieDescState();
}

class _MovieDescState extends State<MovieDesc> {
  Color pageColor;

  @override
  void initState() {
    super.initState();
    getBackgroundColor();
  }

  void getBackgroundColor() async {
    pageColor =
        await Utils.getImageLightVibrantColor(widget.movie.images.medium);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String desc = '';

    widget.movie.tags.map((tag) {
      if (RegionList.indexOf(tag) != -1) {
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

    desc += widget.movie.pubDates.isNotEmpty
        ? '${widget.movie.pubDates?.first}上映'
        : '';

    desc +=
        '${widget.movie.durations.isNotEmpty ? "/ 片长${widget.movie.durations?.first}" : ""}';

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
            child: Column(children: <Widget>[
              /// 图片，名称等
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// 图片
                    ImageLoadView(widget.movie.images.large.toString(),
                        width: 88, height: 130),
                    Gaps.hGap10,

                    /// 名称等
                    Container(
                        width: Utils.width - 138.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              /// 中文名
                              Text(widget.movie.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold)),

                              /// 原名
                              Text(
                                  '${widget.movie.originalTitle}(${widget.movie.year})',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15.0)),

                              /// 国家、类型、上映（时间）等
                              Text(desc,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.0)),

                              /// 想看、看过
                              Row(children: <Widget>[
                                _buildButton('想看', Icons.favorite),
                                Gaps.hGap8,
                                _buildButton('看过', Icons.star)
                              ])
                            ]))
                  ]),

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
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Row(

                                    /// 两端对齐
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('豆瓣评分',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                      Icon(Icons.arrow_right,
                                          color: Colors.white)
                                    ])),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  _buildAverage(widget.movie.rating.average),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        StarRate(
                                            rating: 5.0,
                                            starCount: 5,
                                            rate: totalRating == 0
                                                ? 0.0
                                                : widget.movie.rating.details
                                                        .star5 /
                                                    totalRating),
                                        StarRate(
                                            rating: 4.0,
                                            starCount: 4,
                                            rate: totalRating == 0
                                                ? 0.0
                                                : widget.movie.rating.details
                                                        .star4 /
                                                    totalRating),
                                        StarRate(
                                            rating: 3.0,
                                            starCount: 3,
                                            rate: totalRating == 0
                                                ? 0.0
                                                : widget.movie.rating.details
                                                        .star3 /
                                                    totalRating),
                                        StarRate(
                                            rating: 2.0,
                                            starCount: 2,
                                            rate: totalRating == 0
                                                ? 0.0
                                                : widget.movie.rating.details
                                                        .star2 /
                                                    totalRating),
                                        StarRate(
                                            rating: 1.0,
                                            starCount: 1,
                                            rate: totalRating == 0
                                                ? 0.0
                                                : widget.movie.rating.details
                                                        .star1 /
                                                    totalRating),
                                        Text('${widget.movie.ratingsCount}人评分',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0))
                                      ])
                                ]),
                            Container(
                                height: 1,
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 8.0)),
                            Gaps.vGap8,
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '${widget.movie.collectCount > 1000 ? "${(widget.movie.collectCount / 1000).toStringAsFixed(1)}k" : widget.movie.collectCount}人看过 ${widget.movie.wishCount > 1000 ? "${(widget.movie.wishCount / 1000).toStringAsFixed(1)}k" : widget.movie.wishCount}人想看',
                                    style: TextStyle(color: Colors.white)))
                          ]))),

              /// 所属频道
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('所属频道')),
                        Expanded(
                            child: SizedBox.fromSize(
                                size: Size.fromHeight(30.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.movie.tags.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: InputChip(
                                            label: Text(widget.movie.tags[index]
                                                .toString()),
                                            onPressed: () => pushNewPage(
                                                context,
                                                MovieTagListView(
                                                    widget.movie.tags[index]))),
                                      );
                                    })))
                      ]))
            ])));
  }

  Widget _buildAverage(num value) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            Text('$value',
                style: TextStyle(color: Colors.white, fontSize: 38.0)),
            Text('分', style: TextStyle(color: Colors.white, fontSize: 18.0))
          ]),
          SmoothStarRating(
              rating: value / 2.0,
              size: 18,
              allowHalfRating: false,
              color: Colors.yellow,
              borderColor: Colors.white)
        ]);
  }

  Widget _buildButton(String title, IconData icon) {
    return Expanded(
      child: RaisedButton.icon(
        color: Colors.lightGreen,
        onPressed: () {},
        elevation: 0,
        icon: Icon(icon, color: Colors.yellow, size: 18),
        label: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
