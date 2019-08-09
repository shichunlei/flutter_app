import 'package:flutter/material.dart';

import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/service/api_service.dart';
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

  var _scrollController = ScrollController();
  var _showBackTop = false;

  @override
  void initState() {
    super.initState();

    searchMovies(page, pagesize, widget.q, widget.tag, RefreshType.DEFAULT);

    // 对 scrollController 进行监听
    _scrollController.addListener(() {
      // _scrollController.position.pixels 获取当前滚动部件滚动的距离
      // 当滚动距离大于 800 之后，显示回到顶部按钮
      setState(() => _showBackTop = _scrollController.position.pixels >= 800);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
        floatingActionButton: _showBackTop // 当需要显示的时候展示按钮，不需要的时候隐藏，设置 null
            ? FloatingActionButton(
                onPressed: () {
                  // scrollController 通过 animateTo 方法滚动到某个具体高度
                  // duration 表示动画的时长，curve 表示动画的运行方式，flutter 在 Curves 提供了许多方式
                  _scrollController.animateTo(0.0,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.decelerate);
                },
                child: Icon(Icons.vertical_align_top))
            : null);
  }

  void searchMovies(page, pagesize, String q, String tag, type) async {
    List<Movie> list = await ApiService.getSearchList(
        start: (page - 1) * pagesize, count: pagesize, key: q, tag: tag);
    if (type == RefreshType.DEFAULT) {
      movies.addAll(list);
      isFirst = false;
    } else if (type == RefreshType.LOAD_MORE) {
      movies.addAll(list);
      if (list.isEmpty) {
        Toast.show(context, "加载完...",
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
        controller: _scrollController,
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
