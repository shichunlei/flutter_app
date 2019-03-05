import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/global/api.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:transparent_image/transparent_image.dart';

class UsMovieRakingPage extends StatefulWidget {
  @override
  _UsMovieRakingPageState createState() => _UsMovieRakingPageState();
}

class _UsMovieRakingPageState extends State<UsMovieRakingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<Movie> movies = [];

  bool loadError = false;

  @override
  void initState() {
    super.initState();

    getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return _builderPageView(movies);
  }

  Widget _builderPageView(List<Movie> movies) {
    if (loadError) {
      return Center(
        child: RaisedButton(
          onPressed: () {
            getMovieList();
          },
          child: Text("加载失败"),
        ),
      );
    }
    if (movies.length > 0) {
      return GridView.builder(
        padding: EdgeInsets.all(6.0),

        /// 网格代理对象，一般使用SliverGridDelegateWithFixedCrossAxisCount对象创建，可指定crossAxisCount、mainAxisSpacing、crossAxisSpacing和childAspectRatio等值。
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          /// 表示垂直于主轴方向上的单元格Widget数量。如果scrollDirection为Axis.vertical，则表示水平单元格的数量；如果scrollDirection为Axis.horizontal，则表示垂直单元格的数量。
          crossAxisCount: 2,

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
                pushNewPage(context, MovieDetail(id: movies[index].subject.id)),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movies[index].subject.images.large.toString(),
              fit: BoxFit.fill,
            ),
          );
        },

        /// 表示网格的单元格总数。
        itemCount: movies.length,
      );
    }
    return getLoadingWidget();
  }

  void getMovieList() async {
    var data = {'apikey': Config.DOUBAN_MOVIE_KEY};

    Response response = await HttpUtils().get(Api.US_MOVIES_URL, data: data);
    if (response.statusCode != 200) {
      loadError = true;
    } else {
      var jsonData = response.data;

      Result result = Result.fromMap(jsonData);

      movies = result.subjects;
    }

    setState(() {});
  }
}
