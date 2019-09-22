import 'dart:ui';

import 'package:flutter/material.dart';

import '../../bean/movie.dart';

import '../../page_index.dart';

import 'package:custom_widgets/custom_widgets.dart';

import 'movie_video.dart';
import 'movie_comment.dart';
import 'movie_photos.dart';

import '../ui/index.dart';

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

  var data;

  @override
  void initState() {
    super.initState();
    height = width * 405 / 720 + 10;

    getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    if (movie == null) {
      return Scaffold(
          backgroundColor: pageColor,
          appBar: AppBar(backgroundColor: pageColor),
          body: Center(
            child: Stack(children: <Widget>[
              Offstage(
                  offstage: !loadError,
                  child: RaisedButton(
                      onPressed: () => getMovieDetail(widget.id),
                      child: Text("加载失败，重新加载"))),
              Offstage(offstage: loadError, child: getLoadingWidget())
            ]),
          ));
    }

    return Scaffold(
        backgroundColor: pageColor,
        body: BottomDragWidget(
            body: CustomScrollView(slivers: <Widget>[
              MovieDetailHeader(movie, pageColor: pageColor),

              _builderDesc(),

              /// 剧照、花絮、片段、评论
              _builderContent(),
            ]),
            dragContainer: DragContainer(
                drawer: Container(
                    child:
                        OverscrollNotificationWidget(child: BottomDragView()),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 244, 248),
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0)))),
                defaultShowHeight: Utils.height * 0.1,
                height: Utils.height * 0.6)));
  }

  void getMovieDetail(String id) async {
    movie = await ApiService.getMovieDetail(id);

    loadError = movie == null;

    pageColor = await Utils.getImageDarkMutedColor(movie.images.small,
        defaultColor: Color(0xff35374c));

    cardColor = await Utils.getImageLightVibrantColor(movie.images.small);

    setState(() {});
  }

  /// 展开 or 收起
  changeSummaryMaxLines() => setState(() => isSummaryUnfold = !isSummaryUnfold);

  Widget _builderDesc() {
    List<Casts> casts = [];

    /// 导演
    movie.directors.forEach((director) => casts.add(director));

    /// 演员
    movie.casts.forEach((cast) {
      if (casts.indexOf(cast) == -1) casts.add(cast);
    });

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        SectionView("简介", hiddenMore: true, textColor: Colors.white),
        Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: ExpandableText(movie.summary,
                textColor: Colors.white,
                iconColor: Colors.white,
                iconTextColor: Colors.white,
                alignment: MainAxisAlignment.center,
                fontSize: 15.0,
                isShow: isSummaryUnfold,
                onPressed: () => changeSummaryMaxLines())),
        SectionView("演职员", hiddenMore: true, textColor: Colors.white),
        PersonScroller(casts: casts)
      ]),
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
                offstage: movie.photos.isEmpty,
                child: Column(children: <Widget>[
                  SectionView("剧照",
                      hiddenMore: movie.photos.length < 10,
                      textColor: Colors.white,
                      onPressed: () => pushNewPage(
                          context,
                          MoviePhotosPage(
                              '《${movie.title}》剧照', 'subject', widget.id))),
                  SizedBox.fromSize(
                      size: Size.fromHeight(width),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.photos.length,
                          itemBuilder: (context, index) {
                            List<String> images = [];
                            movie.photos.forEach((f) {
                              images.add(f.image);
                            });

                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: GestureDetector(
                                  onTap: () => pushNewPage(
                                      context,
                                      PhotoView(
                                        title: '《${movie.title}》剧照',
                                        photos: images,
                                        index: index,
                                        heroTag: movie.photos[index].id,
                                      )),
                                  child: Hero(
                                      tag: movie.photos[index].id,
                                      child: Image.network(
                                        movie.photos[index].cover,
                                        // borderRadius: BorderRadius.circular(6.0),
                                        fit: BoxFit.cover,
                                        height: height,
                                        width: height,
                                      )),
                                )

//                                Hero(
//                                    tag: movie.photos[index].id,
//                                    child: ImageLoadView(
//                                        movie.photos[index].cover,
//                                        fit: BoxFit.cover,
//                                        height: width,
//                                        width: width,
//                                        borderRadius:
//                                            BorderRadius.circular(6.0),
//                                        onPressed: () => pushNewPage(
//                                            context,
//                                            MoviePhotoPage('《${movie.title}》剧照',
//                                                photos: movie.photos,
//                                                index: index))))
                                );
                          }))
                ])),
            MovieDesc(movie),
            CoverSectionView('花絮',
                hiddenMore: true,
                backgroundColor: pageColor,
                height: height,
                size: movie.bloopers.length,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.bloopers.length,
                    itemBuilder: (context, index) => ItemCover(
                        movie.bloopers[index].medium,
                        offstage: false,
                        onTop: () => pushNewPage(
                            context,
                            MovieVideoPage(
                                movie.bloopers[index].resourceUrl))))),
            CoverSectionView('片段',
                hiddenMore: true,
                backgroundColor: pageColor,
                height: height,
                size: movie.clips.length,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie.clips.length,
                    itemBuilder: (context, index) => ItemCover(
                        movie.clips[index].medium,
                        offstage: false,
                        onTop: () => pushNewPage(context,
                            MovieVideoPage(movie.clips[index].resourceUrl))))),
            SectionView("热评",
                hiddenMore: movie.popularComments.length < 4,
                onPressed: () => pushNewPage(context,
                    MovieCommentPage(movie.id, itemBackgroundColor: cardColor)),
                textColor: Colors.white),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: 10.0, left: 10.0, right: 10.0),
                child: Column(
                    children: movie.popularComments
                        .map((comment) => ItemComment(
                            comment: comment, background: cardColor))
                        .toList()))
          ])),
    );
  }
}
