import 'package:flutter/material.dart';
import 'package:flutter_app/movie/index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';

class MovieTagListView extends StatefulWidget {
  final String tag;

  MovieTagListView(this.tag);

  @override
  createState() => _MovieTagListViewState();
}

class _MovieTagListViewState extends State<MovieTagListView> {
  int page = 1;
  int limit = 18;

  LoaderState status = LoaderState.Loading;

  bool isLoadComplete = false;

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    getTagList(widget.tag, page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('${widget.tag}')),
      body: LoaderContainer(
          contentView: EasyRefresh(
              header: BallPulseHeader(),
              footer: BallPulseFooter(),
              onLoad: isLoadComplete
                  ? null
                  : () async {
                      page++;
                      getTagList(widget.tag, page, RefreshType.LOAD_MORE);
                    },
              onRefresh: () async {
                page = 1;
                getTagList(widget.tag, page, RefreshType.REFRESH);
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: movies.length == 0
                      ? []
                      : movies.map((movie) => MovieGridView(movie)).toList(),
                ),
              )),
          loaderState: status),
    );
  }

  void getTagList(String tag, int page, RefreshType type) async {
    if (type == RefreshType.DEFAULT || RefreshType.REFRESH == type) {
      movies.clear();
    }
    List<Movie> list =
        await ApiService.getSearchListByTag(tag, page: page, limit: limit);

    if (list.length > 0) {
      status = LoaderState.Succeed;
      movies.addAll(list);
    } else {
      isLoadComplete = true;
    }

    if (mounted) setState(() {});
  }
}
