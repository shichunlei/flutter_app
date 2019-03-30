import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/page/movie_detail.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:transparent_image/transparent_image.dart';

class WeeklyMovieRakingPage extends StatefulWidget {
  @override
  _WeeklyMovieRakingPageState createState() => _WeeklyMovieRakingPageState();
}

class _WeeklyMovieRakingPageState extends State<WeeklyMovieRakingPage>
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
        physics: const BouncingScrollPhysics(),

        /// 表示网格的单元格总数。
        itemCount: movies.length,
      );
    }
    return getLoadingWidget();
  }

  void getMovieList() async {
    movies = await ApiService.getWeeklyList();
    loadError = movies == null;
    setState(() {});
  }
}
