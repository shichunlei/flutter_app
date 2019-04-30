import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/casts.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_celebrity.dart';
import 'package:flutter_app/movie/page/movie_comment.dart';
import 'package:flutter_app/movie/page/movie_photos.dart';
import 'package:flutter_app/movie/ui/movie_detail_header.dart';
import 'package:flutter_app/movie/page/movie_photo.dart';
import 'package:flutter_app/movie/page/movie_video.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/cover_section_view.dart';
import 'package:flutter_app/movie/ui/expandable_text.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';
import 'package:flutter_app/movie/ui/item_comment.dart';
import 'package:flutter_app/movie/ui/item_cover.dart';
import 'package:flutter_app/movie/ui/movie_desc.dart';
import 'package:flutter_app/movie/ui/person_gridview.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetail extends StatefulWidget {
  final String id;

  MovieDetail(this.id, {Key key}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;
  bool loadError = false;
  bool isSummaryUnfold = false;

  Color pageColor = Color(0xff35374c);
  Color cardColor = Color(0xff35374c);

  double width = (Utils.width - 5 * 4) / 2;
  double height;

  @override
  void initState() {
    super.initState();
    height = width * 405 / 720 + 10;

    LogUtil.v('${widget.id}');
    getMovieDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Scaffold(
        backgroundColor: pageColor,
        appBar: AppBar(
          title: Text(""),
          backgroundColor: pageColor,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Offstage(
                offstage: !loadError,
                child: RaisedButton(
                  onPressed: () {
                    getMovieDetail(widget.id);
                  },
                  child: Text("加载失败，重新加载"),
                ),
              ),
              Offstage(
                offstage: loadError,
                child: getLoadingWidget(),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: pageColor,
      body: CustomScrollView(
        slivers: <Widget>[
          MovieDetailHeader(movie, pageColor: pageColor),
          _builderDesc(),

          /// 剧照、花絮、片段、评论
          _builderContent(),
        ],
      ),
    );
  }

  void getMovieDetail(String id) async {
    movie = await ApiService.getMovieDetail(id);

    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(movie.images.small));

    loadError = movie == null;
    setState(() {
      if (paletteGenerator.darkVibrantColor != null) {
        pageColor = paletteGenerator.darkVibrantColor.color;
      }
      if (paletteGenerator.lightMutedColor != null) {
        cardColor = paletteGenerator.lightMutedColor.color;
      }
    });
  }

  /// 展开 or 收起
  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  Widget _builderDesc() {
    List<Casts> casts = [];

    /// 导演
    movie.directors.forEach((director) {
      casts.add(director);
    });

    /// 演员
    movie.casts.forEach((cast) {
      if (casts.indexOf(cast) == -1) {
        casts.add(cast);
      }
    });

    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          HomeSectionView("简介",
              hiddenMore: true,
              backgroundColor: pageColor,
              textColor: Colors.white),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: ExpandableText(
              movie.summary,
              textColor: Colors.white,
              iconColor: Colors.white,
              iconTextColor: Colors.white,
              alignment: MainAxisAlignment.center,
              fontSize: 15.0,
              isShow: isSummaryUnfold,
              onPressed: () => changeSummaryMaxLines(),
            ),
          ),
          HomeSectionView("演职员",
              hiddenMore: true,
              backgroundColor: pageColor,
              textColor: Colors.white),
          SizedBox.fromSize(
            size: Size.fromHeight(110.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 5.0, right: 5.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: casts.length,
                itemBuilder: (context, index) {
                  return PersonGridView(
                      casts: casts[index],
                      textColor: Colors.white,
                      onTap: () => pushNewPage(
                            context,
                            MovieCelebrityPage(
                              id: casts[index].id,
                              name: casts[index].name,
                            ),
                          ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderContent() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Offstage(
                offstage: movie.photos.length == 0,
                child: Column(children: <Widget>[
                  HomeSectionView(
                    "剧照",
                    hiddenMore: movie.photos.length < 10,
                    backgroundColor: pageColor,
                    textColor: Colors.white,
                    onPressed: () => pushNewPage(
                        context,
                        MoviePhotosPage(
                            '《${movie.title}》剧照', 'subject', widget.id)),
                  ),
                  SizedBox.fromSize(
                      size: Size.fromHeight(width),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.photos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Hero(
                                  tag: movie.photos[index].id,
                                  child: ImageLoadView(
                                      movie.photos[index].cover,
                                      fit: BoxFit.cover,
                                      height: width,
                                      width: width,
                                      borderRadius: BorderRadius.circular(6.0),
                                      placeholder: kTransparentImage,
                                      onPressed: () => pushNewPage(
                                          context,
                                          MoviePhotoPage('《${movie.title}》剧照',
                                              photos: movie.photos,
                                              index: index)))),
                            );
                          }))
                ])),
            MovieDesc(movie),
            CoverSectionView(
              '花絮',
              hiddenMore: true,
              backgroundColor: pageColor,
              height: height,
              size: movie.bloopers.length,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie.bloopers.length,
                itemBuilder: (context, index) {
                  return ItemCover(
                    movie.bloopers[index].medium,
                    offstage: false,
                    onTop: () {
                      pushNewPage(context,
                          MovieVideoPage(movie.bloopers[index].resource_url));
                    },
                  );
                },
              ),
            ),
            CoverSectionView(
              '片段',
              hiddenMore: true,
              backgroundColor: pageColor,
              height: height,
              size: movie.clips.length,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie.clips.length,
                itemBuilder: (context, index) {
                  return ItemCover(
                    movie.clips[index].medium,
                    offstage: false,
                    onTop: () => pushNewPage(context,
                        MovieVideoPage(movie.clips[index].resource_url)),
                  );
                },
              ),
            ),
            HomeSectionView("热评", hiddenMore: movie.popular_comments.length < 4,
                onPressed: () {
              pushNewPage(context,
                  MovieCommentPage(movie.id, itemBackgroundColor: cardColor));
            }, backgroundColor: pageColor, textColor: Colors.white),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              child: Column(
                children: movie.popular_comments
                    .map((comment) =>
                        ItemComment(comment: comment, background: cardColor))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
