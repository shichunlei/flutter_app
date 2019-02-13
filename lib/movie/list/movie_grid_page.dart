import 'package:flutter/material.dart';
import 'package:flutter_app/movie/details/movie_detail_page.dart';
import 'package:flutter_app/movie/list/movie.dart';
import 'package:flutter_app/utils/api.dart';
import 'package:flutter_app/utils/constant.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_app/utils/loading_util.dart';

class MovieGridPage extends StatefulWidget {
  @override
  createState() => MovieGridStatePage();
}

class MovieGridStatePage extends State<MovieGridPage> {
  List<Movie> movies = [];
  int page = 0;
  int pagesize = 36;
  var contentView;
  bool isShowLoading = false;

  @override
  void initState() {
    super.initState();

    isShowLoading = true;
    getMovieList(page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    if (isShowLoading) {
      contentView = Center(
        // 可选参数 child:
        child: getLoadingWidget(),
      );
    } else {
      contentView = getGridViewBuilder();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("电影Top250"),
      ),
      body: contentView,
    );
  }

  getMovieList(page, type) async {
    String url = Api.MOVIE_TOP250_URL;
    var data = {
      'apikey': '0b2bdeda43b5688921839c8ecb20399b',
      'start': page * pagesize,
      'count': pagesize,
    };
    var jsonData = await HttpUtils().get(url, data: data);

    // setState 相当于 runOnUiThread
    setState(() {
      isShowLoading = false;
      List<Movie> list = Movie.decodeData(jsonData);
      if (type == RefreshType.DEFAULT) {
        movies.addAll(list);
      } else if (type == RefreshType.REFRESH) {
        movies.clear();
        movies.addAll(list);
      } else if (type == RefreshType.LOAD_MORE) {
        movies.addAll(list);
      }
    });
  }

  Widget getGridViewBuilder() {
    if (movies.length > 0) {
      return GridView.builder(
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
            onTap: () => navigateToMovieDetailPage(movies[index], index),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: movies[index].smallImage,
            ),
          );
        },

        /// 表示网格的单元格总数。
        itemCount: movies.length,
      );
    } else {
      return Center(
        child: Text("暂无数据"),
      );
    }
  }

  navigateToMovieDetailPage(movie, imageTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
              movie,
              imageTag: imageTag,
            ),
      ),
    );
  }
}
