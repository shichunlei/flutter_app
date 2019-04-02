import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_celebrity.dart';
import 'package:flutter_app/movie/page/movie_comment.dart';
import 'package:flutter_app/movie/page/movie_photos.dart';
import 'package:flutter_app/movie/ui/movie_detail_header.dart';
import 'package:flutter_app/movie/page/movie_photo.dart';
import 'package:flutter_app/movie/page/movie_video.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/cover_section_view.dart';
import 'package:flutter_app/movie/ui/expandable_text.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';
import 'package:flutter_app/movie/ui/item_comment.dart';
import 'package:flutter_app/movie/ui/item_cover.dart';
import 'package:flutter_app/movie/ui/movie_desc.dart';
import 'package:flutter_app/movie/ui/person_gridview.dart';
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
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                HomeSectionView("简介",
                    hiddenMore: true,
                    backgroundColor: pageColor,
                    textColor: Colors.white),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
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
                HomeSectionView("导演",
                    hiddenMore: true,
                    backgroundColor: pageColor,
                    textColor: Colors.white),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movie.directors
                        .map(
                          (casts) => PersonGridView(
                                casts: casts,
                                textColor: Colors.white,
                                onTap: () => pushNewPage(
                                      context,
                                      MovieCelebrityPage(
                                        id: casts.id,
                                        name: casts.name,
                                      ),
                                    ),
                              ),
                        )
                        .toList(),
                  ),
                ),
                HomeSectionView("编剧",
                    hiddenMore: true,
                    backgroundColor: pageColor,
                    textColor: Colors.white),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movie.writers
                        .map((casts) => PersonGridView(
                            casts: casts,
                            textColor: Colors.white,
                            onTap: () => pushNewPage(
                                  context,
                                  MovieCelebrityPage(
                                    id: casts.id,
                                    name: casts.name,
                                  ),
                                )))
                        .toList(),
                  ),
                ),
                HomeSectionView("主演",
                    hiddenMore: true,
                    backgroundColor: pageColor,
                    textColor: Colors.white),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movie.casts
                        .map((casts) => PersonGridView(
                            casts: casts,
                            textColor: Colors.white,
                            onTap: () => pushNewPage(
                                  context,
                                  MovieCelebrityPage(
                                    id: casts.id,
                                    name: casts.name,
                                  ),
                                )))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
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

  Widget _builderContent() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            HomeSectionView(
              "剧照",
              hiddenMore: movie.photos.length < 10,
              backgroundColor: pageColor,
              textColor: Colors.white,
              onPressed: () => pushNewPage(context,
                  MoviePhotosPage('《${movie.title}》剧照', 'subject', widget.id)),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(width),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.photos.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: GestureDetector(
                        child: ClipRRect(
                          /// 圆角
                          borderRadius: BorderRadius.circular(6.0),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: movie.photos[index].cover,
                            fit: BoxFit.cover,
                            height: width,
                            width: width,
                          ),
                        ),
                        onTap: () {
                          pushNewPage(
                              context,
                              MoviePhotoPage('《${movie.title}》剧照',
                                  photos: movie.photos, index: index));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
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
                    onTop: () {
                      pushNewPage(context,
                          MovieVideoPage(movie.clips[index].resource_url));
                    },
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
