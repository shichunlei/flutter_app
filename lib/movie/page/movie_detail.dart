import 'dart:ui';

import 'package:flutter/material.dart';

import '../../page_index.dart';

import '../index.dart';

class MovieDetail extends StatefulWidget {
  final String id;

  MovieDetail(this.id);

  @override
  createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;
  bool loadError = false;
  bool isSummaryUnfold = false;

  Color pageColor = Color(0xff35374c);
  Color cardColor = Color(0xff35374c);

  double width = (Utils.width - 5 * 4) / 2;
  double height;

  LoaderState status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();
    height = width * 405 / 720 + 10;

    getMovieDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      body: LoaderContainer(
        contentView: CustomScrollView(slivers: <Widget>[
          MovieDetailHeader(movie, pageColor: pageColor),

          _builderDesc(),

          /// 剧照、花絮、片段、评论
          _builderContent(),
        ]),
        loaderState: status,
      ),
    );
  }

  void getMovieDetail(String id) async {
    movie = await ApiService.getMovieDetail(id);

    if (movie != null) {
      status = LoaderState.Succeed;
    }

    pageColor = await Utils.getImageDarkMutedColor(movie.images.small,
        defaultColor: Color(0xff35374c));

    cardColor = await Utils.getImageLightVibrantColor(movie.images.small);

    if (mounted) setState(() {});
  }

  /// 展开 or 收起
  changeSummaryMaxLines() => setState(() => isSummaryUnfold = !isSummaryUnfold);

  Widget _builderDesc() {
    List<Casts> casts = [];

    /// 导演
    movie?.directors?.forEach((director) => casts.add(director));

    /// 演员
    movie?.casts?.forEach((cast) {
      if (casts.indexOf(cast) == -1) casts.add(cast);
    });

    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        SectionView(
          "简介",
          hiddenMore: true,
          textColor: Colors.white,
          child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
              child: ExpandableText(movie?.summary,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  iconTextColor: Colors.white,
                  alignment: MainAxisAlignment.center,
                  fontSize: 15.0,
                  isShow: isSummaryUnfold,
                  onPressed: () => changeSummaryMaxLines())),
        ),
        SectionView(
          "演职员",
          hiddenMore: true,
          textColor: Colors.white,
          child: PersonScroller(casts: casts),
        ),
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
                offstage: movie?.photos?.isEmpty ?? true,
                child: SectionView(
                  "剧照（${movie?.photosCount}）",
                  hiddenMore: movie == null
                      ? true
                      : movie.photos.length >= movie?.photosCount,
                  textColor: Colors.white,
                  onPressed: () => pushNewPage(
                      context,
                      MoviePhotosPage(
                          '《${movie?.title}》剧照', 'subject', widget.id)),
                  child: SizedBox.fromSize(
                      size: Size.fromHeight(width),
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: movie != null ? movie.photos.length : 0,
                          itemBuilder: (context, index) {
                            List<String> images = [];
                            movie?.photos?.forEach((f) => images.add(f.image));

                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                child: GestureDetector(
                                  onTap: () => pushNewPage(
                                      context,
                                      PhotoView(
                                        title: '《${movie?.title}》剧照',
                                        photos: images,
                                        index: index,
                                        heroTag: movie?.photos[index]?.id,
                                      )),
                                  child: Hero(
                                      tag: movie?.photos[index]?.id,
                                      child: Image.network(
                                        movie?.photos[index]?.cover,
                                        // borderRadius: BorderRadius.circular(6.0),
                                        fit: BoxFit.cover,
                                        height: height,
                                      )),
                                ));
                          })),
                )),
            MovieDesc(movie),
            CoverSectionView('花絮',
                hiddenMore: true,
                backgroundColor: pageColor,
                height: height,
                size: movie?.bloopers?.length ?? 0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie?.bloopers?.length,
                    itemBuilder: (context, index) => ItemCover(
                        movie?.bloopers[index]?.medium,
                        offstage: false,
                        onTop: () => pushNewPage(
                            context,
                            MovieVideoPage(
                                movie?.bloopers[index]?.resourceUrl))))),
            CoverSectionView('片段',
                hiddenMore: true,
                backgroundColor: pageColor,
                height: height,
                size: movie?.clips?.length,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movie?.clips?.length,
                    itemBuilder: (context, index) => ItemCover(
                        movie?.clips[index]?.medium,
                        offstage: false,
                        onTop: () => pushNewPage(
                            context,
                            MovieVideoPage(
                                movie?.clips[index]?.resourceUrl))))),
            SectionView(
              "短评",
              hiddenMore: (movie?.commentsCount ?? 0) < 4,
              onPressed: () =>
                  pushNewPage(context, MovieCommentPage(movie?.id)),
              textColor: Colors.white,
              child: ListView.builder(
                itemBuilder: (_, index) => ItemComment(
                    comment: movie?.popularComments[index],
                    background: cardColor),
                itemCount: movie?.popularComments?.length ?? 0,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              ),
            ),
          ])),
    );
  }
}
