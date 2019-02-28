import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/utils/api.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('电影详情'),
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !loadError,
            child: Center(
              child: RaisedButton(
                onPressed: () {
                  getMovieDetail(widget.id);
                },
                child: Text("加载失败，重新加载"),
              ),
            ),
          ),
          Offstage(
            offstage: (loadError && movie != null),
            child: SingleChildScrollView(
              child: _bulderView(movie),
            ),
          ),
        ],
      ),
    );
  }

  void getMovieDetail(String id) async {
    var data = {'apikey': '0b2bdeda43b5688921839c8ecb20399b'};

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

  Widget _bulderView(Movie movie) {
    if (movie == null) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: getLoadingWidget(),
        ),
      );
    }
    var movieImage = Center(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: movie.images.medium.toString(),
        fit: BoxFit.fill,
        height: 150.0,
        width: 100.0,
      ),
    );

    var casts = '';
    for (int i = 0; i < movie.casts.length; i++) {
      if (i == 0) {
        casts = casts + movie.casts[i].name;
      } else {
        casts = casts + '/' + movie.casts[i].name;
      }
    }

    var directors = '';
    for (int i = 0; i < movie.directors.length; i++) {
      if (i == 0) {
        directors = directors + movie.directors[i].name;
      } else {
        directors = directors + '/' + movie.directors[i].name;
      }
    }

    var movieMsg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          movie.title,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
        ),
        Text('导演：' + directors),
        Text('主演：' + casts),
        Text(
          movie.collect_count.toString() + '人看过',
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.redAccent,
          ),
        ),
        Text('评分：' + movie.rating.average.toString()),
        Text(
          '剧情简介：' + movie.summary,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scrollbar(
        child: Column(
          children: <Widget>[
            movieImage,
            movieMsg,
          ],
        ),
      ),
    );
  }
}
