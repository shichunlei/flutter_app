import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/movie/page/movie_photo.dart';
import 'package:flutter_app/movie/ui/item_casts.dart';
import 'package:flutter_app/movie/ui/item_tag.dart';
import 'package:flutter_app/global/api.dart';
import 'package:flutter_app/movie/ui/video_cover.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
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
    var data = {'apikey': Config.DOUBAN_MOVIE_KEY};

    Response response =
        await HttpUtils().get('${Api.MOVIE_DETAIL_URL}/$id', data: data);
    if (response.statusCode != 200) {
      loadError = true;
    } else {
      var jsonData = response.data;

      movie = Movie.fromMap(jsonData);
    }

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
      body: CustomScrollView(
        slivers: <Widget>[
          _builderHeader(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  VideoCover(cover: movie.bloopers[index].medium),
              childCount: movie.bloopers.length,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                /// 导演
                ItemCasts(title: "导演", directors: movie.directors),

                /// 主演
                ItemCasts(title: "主演", casts: movie.casts),
              ],
            ),
          ),
          _builderContent(),
        ],
      ),
    );
  }

  void getMoviePhotos(id) async {
    showLoadingDialog(context, "正在加载...");

    var data = {'apikey': Config.DOUBAN_MOVIE_KEY};

    Response response = await HttpUtils()
        .get('${Api.MOVIE_DETAIL_URL}/${id}/photos', data: data);

    var jsonData = response.data;

    Result result = Result.fromMap(jsonData);

    if (result.photos.length > 0) {
      Navigator.pop(context);

      pushNewPage(context, MoviePhotoPage(photos: result.photos));
    }
  }

  Widget _builderHeader() {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      expandedHeight: 191.5,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('${movie.title}(${movie.year})'),
        background: Stack(
          children: <Widget>[
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
                onTap: () => getMoviePhotos(widget.id)),
          ],
        ),
      ),
    );
  }

  Widget _builderContent() {
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

            Text(
              '剧情简介：' + movie.summary,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
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
