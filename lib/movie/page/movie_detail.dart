import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/page/movie_comment.dart';
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
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:palette_generator/palette_generator.dart';

class MovieDetail extends StatefulWidget {
  final String id;

  MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;
  bool loadError = false;
  bool isSummaryUnfold = false;

  Color pageColor = Colors.white;
  Color cardColor = Colors.white;

  double width = (Utils.width - 5 * 4) / 2;
  double height;

  @override
  void initState() {
    super.initState();
    height = width * 405 / 720 + 10;
    getMovieDetail(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bulderBodyView(movie);
  }

  void getMovieDetail(String id) async {
    movie = await ApiService.getMovieDetail(id);

    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
            NetworkImage(movie.photos[0].image));

    loadError = movie == null;
    setState(() {
      if (paletteGenerator.darkVibrantColor != null) {
        pageColor = paletteGenerator.darkVibrantColor.color;
      } else {
        pageColor = Color(0xff35374c);
      }
      if (paletteGenerator.lightMutedColor != null) {
        cardColor = paletteGenerator.lightMutedColor.color;
      } else {
        cardColor = Color(0xff35374c);
      }
    });
  }

  Widget _bulderBodyView(Movie movie) {
    if (movie == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(""),
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
          _builderHeader(),
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
                        .map((directors) => PersonGridView(
                            directors: directors, textColor: Colors.white))
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
                            casts: casts, textColor: Colors.white))
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

  // 展开 or 收起
  changeSummaryMaxLines() {
    setState(() {
      isSummaryUnfold = !isSummaryUnfold;
    });
  }

  void getMoviePhotos(id) async {
    showLoadingDialog(context, "正在加载...");

    List<Photos> photos = await ApiService.getMovieAlbum(id);
    if (photos.length > 0) {
      Navigator.pop(context);

      pushNewPage(context, MoviePhotoPage(photos: photos));
    }
  }

  Widget _builderHeader() {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 200,
      backgroundColor: pageColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('${movie.title}(${movie.year})'),
        background: Stack(
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movie.photos[0].image,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: double.infinity,
            ),

            /// 加上一层毛玻璃效果
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 6.0,
              ),
              child: Opacity(
                opacity: 0.4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0x3a000000),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: movie.images.large.toString(),
                  fit: BoxFit.fill,
                  height: 191.5,
                  width: 135.0,
                ),
              ),
              onTap: () => getMoviePhotos(widget.id),
            ),
          ],
        ),
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
            HomeSectionView("剧照",
                hiddenMore: true,
                backgroundColor: pageColor,
                textColor: Colors.white),
            SizedBox.fromSize(
              size: Size.fromHeight(height),
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.photos.length,
                  itemBuilder: (context, index) {
                    return ItemCover(
                      movie.photos[index].image,
                      onTop: () {
                        pushNewPage(context,
                            MoviePhotoPage(photos: movie.photos, index: index));
                      },
                    );
                  },
                ),
              ),
            ),
            MovieDesc(movie),
            CoverSectionView(
              '花絮',
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
            HomeSectionView("热评", onPressed: () {
              pushNewPage(context, MovieCommentPage());
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
