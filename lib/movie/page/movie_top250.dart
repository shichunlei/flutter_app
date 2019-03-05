import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/toast/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/global/api.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieTop250 extends StatefulWidget {
  @override
  _MovieTop250State createState() => _MovieTop250State();
}

class _MovieTop250State extends State<MovieTop250> {
  int page = 1;
  int pagesize = 30;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isFirst = true;

  List<Movie> movies = [];

  var text = "";

  bool loadError = false;

  @override
  void initState() {
    super.initState();

    getMovieTop250List(page, pagesize, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('豆瓣排行前250电影'),
      ),
      body: _builderPageView(movies),
    );
  }

  Widget _builderPageView(List<Movie> movies) {
    if (isFirst) {
      return Center(
        child: getLoadingWidget(),
      );
    } else {
      if (loadError) {
        return Center(
          child: RaisedButton(
            onPressed: () {
              page = 1;
              getMovieTop250List(page, pagesize, RefreshType.DEFAULT);
            },
            child: Text("加载失败"),
          ),
        );
      } else if ((movies.length > 0)) {
        return _builderGridView(movies);
      } else {
        return Center(child: Text(text));
      }
    }
  }

  Widget _builderGridView(List<Movie> movies) {
    return EasyRefresh(
      key: _easyRefreshKey,

      /// 自动控制(刷新和加载完成)
      autoControl: true,

      /// 底部视图
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),

      ///加载回调方法
      loadMore: () async {
        page++;
        getMovieTop250List(page, pagesize, RefreshType.LOAD_MORE);
      },

      /// 子部件 内容视图
      child: GridView.builder(
        padding: EdgeInsets.all(6.0),

        /// 网格代理对象，一般使用SliverGridDelegateWithFixedCrossAxisCount对象创建，可指定crossAxisCount、mainAxisSpacing、crossAxisSpacing和childAspectRatio等值。
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
          crossAxisCount: 3,

          /// 表示主轴方向单元格的间距。
          mainAxisSpacing: 5.0,

          /// 表示垂直于主轴方向的单元格间距。
          crossAxisSpacing: 5.0,

          /// 表示单元格的宽高比。
          childAspectRatio: 270 / 383,
        ),

        /// 其值为一个函数：Widget Function(BuildContext context, int index)，实现该函数用于创建每个网格对应的Widget。
        itemBuilder: (context, index) {
          return GestureDetector(
            //点击事件
            onTap: () =>
                pushNewPage(context, MovieDetail(id: movies[index].id)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movies[index].images.medium.toString(),
              fit: BoxFit.fill,
            ),
          );
        },

        /// 表示网格的单元格总数。
        itemCount: movies.length,
      ),
    );
  }

  void getMovieTop250List(int page, int pagesize, int type) async {
    var data = {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': (page - 1) * pagesize,
      'count': pagesize,
    };

    Response response = await HttpUtils().get(Api.MOVIE_TOP250_URL, data: data);
    if (response.statusCode != 200) {
      loadError = true;
    } else {
      var jsonData = response.data;

      Result result = Result.fromMap(jsonData);

      print("================================");
      print('${result.title} ${result.start} ${result.subjects.toString()}');

      List<Movie> list = result.subjects;
      if (type == RefreshType.DEFAULT) {
        movies.addAll(list);
        if (isFirst && movies.length == 0) {
          text = "暂无数据";
        } else {
          text = "";
        }
      } else if (type == RefreshType.LOAD_MORE) {
        movies.addAll(list);
        if (list.length == 0) {
          setState(() {
            Toast.show("加载完...", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          });
        }
      }

      if (isFirst) {
        isFirst = false;
      }
    }

    setState(() {});
  }
}
