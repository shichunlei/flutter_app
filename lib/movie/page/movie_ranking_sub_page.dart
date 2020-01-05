import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieRankingSubPage extends StatefulWidget {
  final String url;

  MovieRankingSubPage(this.url, {Key key}) : super(key: key);

  @override
  createState() => _MovieRankingSubPageState();
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
    super.build(context);
    return FutureBuilder<List<Movie>>(
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              debugPrint('MovieRankingSubPage none');
              return Text('');
            case ConnectionState.waiting:
              debugPrint('MovieRankingSubPage waiting');
              return LoadingWidget();
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
                        Movie movie = snapshot.data[index];
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
