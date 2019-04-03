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

class MovieWithCelebrityPage extends StatefulWidget {
  final String celebrityId;
  final String name;

  MovieWithCelebrityPage(this.celebrityId, this.name, {Key key})
      : super(key: key);

  @override
  _MovieWithCelebrityPageState createState() => _MovieWithCelebrityPageState();
}

class _MovieWithCelebrityPageState extends State<MovieWithCelebrityPage> {
  int page = 1;
  int pagesize = 30;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;

  List<Movie> movies = [];

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getMovieList(widget.celebrityId, page, pagesize, RefreshType.DEFAULT);
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
      String celebrityId, int page, int pagesize, RefreshType type) async {
    List<Movie> list = await ApiService.getActorMovies(celebrityId,
        start: (page - 1) * pagesize, count: pagesize);
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

  Widget builderPageView() {
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
              getMovieList(
                  widget.celebrityId, page, pagesize, RefreshType.LOAD_MORE);
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
