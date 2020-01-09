import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieWithCelebrityPage extends StatefulWidget {
  final String celebrityId;
  final String name;

  MovieWithCelebrityPage(this.celebrityId, this.name, {Key key})
      : super(key: key);

  @override
  createState() => _MovieWithCelebrityPageState();
}

class _MovieWithCelebrityPageState extends State<MovieWithCelebrityPage> {
  int page = 1;
  int pageSize = 30;

  bool isFirst = true;

  List<Movie> movies = [];

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getMovieList(widget.celebrityId, page, pageSize, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.name}的作品')),
      body: builderPageView(),
    );
  }

  void getMovieList(
      String celebrityId, int page, int pageSize, RefreshType type) async {
    List<Movie> list = await ApiService.getActorMovies(celebrityId,
        start: (page - 1) * pageSize, count: pageSize);
    if (type == RefreshType.DEFAULT) {
      movies.addAll(list);
      isFirst = false;
    } else if (type == RefreshType.LOAD_MORE) {
      movies.addAll(list);
      if (list.isEmpty) {
        Toast.show(context, "加载完...");
        isLoadComplete = true;
      }
    }

    if (mounted) setState(() {});
  }

  Widget builderPageView() {
    if (isFirst && movies.isEmpty) {
      return LoadingWidget();
    }
    return EasyRefresh(
      footer: BallPulseFooter(),
      onLoad: isLoadComplete
          ? null
          : () async {
              page++;
              getMovieList(
                  widget.celebrityId, page, pageSize, RefreshType.LOAD_MORE);
            },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemList(
            movie: movies[index],
            onTap: () {
              pushNewPage(context, MovieDetail(movies[index].id));
            },
          );
        },
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
