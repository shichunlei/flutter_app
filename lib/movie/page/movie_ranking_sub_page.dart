import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';

import '../page/movie_detail.dart';
import '../ui/item_ranking_movie.dart';

import '../../page_index.dart';

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

  var data;

  @override
  void initState() {
    super.initState();

    data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              debugPrint('MovieRankingSubPage none');
              return Text('');
            case ConnectionState.waiting:
              debugPrint('MovieRankingSubPage waiting');
              return getLoadingWidget();
            case ConnectionState.done:
              debugPrint('MovieRankingSubPage done');
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return ErrorPage(text: '网络请求错误');
              } else {
                debugPrint('${snapshot.data.length}');
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        Movie movie = (widget.url == ApiUrl.US_MOVIES_URL ||
                                widget.url == ApiUrl.WEEKLY_MOVIES_URL)
                            ? snapshot.data[index].subject
                            : snapshot.data[index];
                        return ItemRankingMovie(movie,
                            index: index,
                            onTap: () =>
                                pushNewPage(context, MovieDetail(movie.id)));
                      },
                      itemCount: snapshot.data.length,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.all(5.0));
                } else {
                  return EmptyPage(
                      text: '暂无数据', imageAsset: 'images/empty.jpeg');
                }
              }
              break;
            default:
              return null;
              break;
          }
        },
        future: data);
  }

  Future<List<Movie>> fetchData() async {
    return await ApiService.getRankingList(widget.url);
  }
}
