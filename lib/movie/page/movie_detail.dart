import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/page/movie_photo.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/expandable_text.dart';
import 'package:flutter_app/movie/ui/home_section_view.dart';
import 'package:flutter_app/movie/ui/item_comment.dart';
import 'package:flutter_app/movie/ui/item_cover.dart';
import 'package:flutter_app/movie/ui/item_tag.dart';
import 'package:flutter_app/movie/ui/person_gridview.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:transparent_image/transparent_image.dart';

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

  @override
  void initState() {
    super.initState();

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
    loadError = movie == null;
    setState(() {});
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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _builderHeader(),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                HomeSectionView("简介", hiddenMore: true),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: ExpandableText(
                    movie.summary,
                    textColor: Colors.black,
                    iconColor: Colors.grey,
                    iconTextColor: Colors.grey,
                    alignment: MainAxisAlignment.center,
                    fontSize: 15.0,
                    isShow: isSummaryUnfold,
                    onPressed: () => changeSummaryMaxLines(),
                  ),
                ),
                HomeSectionView("导演", hiddenMore: true),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movie.directors
                        .map(
                            (directors) => PersonGridView(directors: directors))
                        .toList(),
                  ),
                ),
                HomeSectionView("主演", hiddenMore: true),
                Container(
                  padding: EdgeInsets.all(6.0),
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: movie.casts
                        .map((casts) => PersonGridView(casts: casts))
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
      flexibleSpace: FlexibleSpaceBar(
        title: Text('${movie.title}(${movie.year})'),
        background: Stack(
          children: <Widget>[
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movie.images.large.toString(),
              fit: BoxFit.cover,
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
                opacity: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
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
    double width = (Utils.width - 5 * 4) / 2;
    double height = width * 405 / 720 + 10;

    var comment_children;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// 标签
            Wrap(children: _builderTag(movie.tags), spacing: 10.0),

            /// 看过人数
            Text(
              '${movie.collect_count}人看过',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.redAccent,
              ),
            ),

            /// 评分
            Row(
              children: <Widget>[
                Text('评分：'),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SmoothStarRating(
                        rating: movie.rating.average / 2,
                        starCount: 5,
                        size: 20,
                        allowHalfRating: false,
                        color: Colors.deepOrange)),
                Text('${movie.rating.average.toString()} 分',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepOrange))
              ],
            ),
            HomeSectionView("预告片", hiddenMore: true),
            SizedBox.fromSize(
              size: Size.fromHeight(height),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie.bloopers.length,
                itemBuilder: (context, index) {
                  return ItemCover(
                    movie.bloopers[index].medium,
                    offstage: false,
                    onTop: () {},
                  );
                },
              ),
            ),
            HomeSectionView("剧照", hiddenMore: true),
            SizedBox.fromSize(
              size: Size.fromHeight(height),
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
            HomeSectionView(
              "热评",
              onPressed: () {},
            ),
            Column(
              children: movie.popular_comments
                  .map((comment) => ItemComment(comment))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _builderTag(List<String> tags) {
    List<Widget> widgets = [];

    for (int i = 0; i < tags.length; i++) {
      widgets.add(ItemTag(tag: tags[i].toString()));
    }

    return widgets;
  }
}
