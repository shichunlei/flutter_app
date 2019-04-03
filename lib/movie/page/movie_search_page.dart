import 'package:flutter/material.dart';

import 'package:flutter_app/custom_widgets/toast/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_list.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MovieSearchPage extends StatefulWidget {
  final String tag;
  final String q;

  MovieSearchPage({Key key, this.tag = '', this.q = ''}) : super(key: key);

  @override
  _MovieSearchPageState createState() => _MovieSearchPageState();
}

class _MovieSearchPageState extends State<MovieSearchPage> {
  int page = 1;
  int pagesize = 20;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;
  bool isLoadComplete = false;

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    searchMovies(page, pagesize, widget.q, widget.tag, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('搜索电影'),
      ),
      body: buildBodyView(),
    );
  }

  void searchMovies(page, pagesize, String q, String tag, type) async {
    List<Movie> list = await ApiService.getSearchList(
        start: (page - 1) * pagesize, count: pagesize, key: q, tag: tag);
    if (type == RefreshType.DEFAULT) {
      movies.addAll(list);
      isFirst = false;
    } else if (type == RefreshType.LOAD_MORE) {
      movies.addAll(list);
      if (list.length == 0) {
        Toast.show("加载完...", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        isLoadComplete = true;
      }
    }

    setState(() {});
  }

  Widget buildBodyView() {
    if (isFirst && movies.isEmpty) {
      return getLoadingWidget();
    }
    return EasyRefresh(
      key: _easyRefreshKey,
      autoControl: true,
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),
      loadMore: isLoadComplete
          ? null
          : () async {
              page++;
              searchMovies(
                  page, pagesize, widget.q, widget.tag, RefreshType.LOAD_MORE);
            },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemList(
            movie: movies[index],
            onTap: () => pushNewPage(context, MovieDetail(movies[index].id)),
          );
        },
        itemCount: movies.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
