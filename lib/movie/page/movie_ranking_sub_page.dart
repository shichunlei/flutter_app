import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_ranking_movie.dart';
import 'package:flutter_app/service/api_url.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';

class MovieRankingSubPage extends StatefulWidget {
  final String url;

  MovieRankingSubPage(this.url, {Key key}) : super(key: key);

  @override
  _MovieRankingSubPageState createState() => _MovieRankingSubPageState();
}

class _MovieRankingSubPageState extends State<MovieRankingSubPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    getMovieList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return getLoadingWidget();
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          Movie movie = (widget.url == ApiUrl.US_MOVIES_URL ||
                  widget.url == ApiUrl.WEEKLY_MOVIES_URL)
              ? movies[index].subject
              : movies[index];
          return ItemRankingMovie(
            movie,
            index: index,
            onTap: () {
              pushNewPage(context, MovieDetail(movie.id));
            },
          );
        },
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(5.0),
      );
    }
  }

  void getMovieList() async {
    movies = await ApiService.getRankingList(widget.url);
    setState(() {});
  }
}
