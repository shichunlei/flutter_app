import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/movie/index.dart';
import '../page/movie_detail.dart';

import '../../page_index.dart';

class MovieHotPage extends StatefulWidget {
  @override
  _MovieHotPageState createState() => _MovieHotPageState();
}

class _MovieHotPageState extends State<MovieHotPage> {
  var result;

  bool isList = true;

  @override
  void initState() {
    super.initState();

    ///用result来保存fetchData()的结果，以避免不必要的ui重绘
    result = fetchData('北京');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('影院热映'), actions: <Widget>[
          IconButton(
              icon: Icon(!isList ? Icons.menu : Icons.apps),
              onPressed: () => setState(() => isList = !isList))
        ]),
        body: FutureBuilder<List<Movie>>(
          builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                debugPrint('none');
                return Text('');
              case ConnectionState.waiting:
                debugPrint('waiting');
                return LoadingWidget();
              case ConnectionState.done:
                debugPrint('done');
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return ErrorPage(text: '网络请求错误');
                } else {
                  debugPrint('${snapshot.data.length}');
                  if (snapshot.data.length > 0) {
                    return showBodyView(snapshot.data);
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
          future: result,
        ));
  }

  Widget showBodyView(List<Movie> movies) {
    return isList
        ? ListView(
            /// 表示列表包含的widget集合，整个滚动视图中的内容设置。
            children: movies
                .map((movie) => ItemList(
                      movie: movie,
                      onTap: () => pushNewPage(context, MovieDetail(movie.id)),
                    ))
                .toList(),

            /// 可设置值为true|false。true时表示内容不足够填充控件区间时也可以有滚动反馈；false表示只有内容超出控件大小时才可滚动。
            primary: true,

            /// 表示读取内容的方向是否颠倒，可设置值为true|false。false表示由左向右或由上向下读取；true表示由右向左或由下向上读取。
            reverse: false,

            /// 表示物理反馈，一般设置值为AlwaysScrollableScrollPhysics()|ScrollPhysics()。AlwaysScrollableScrollPhysics表示总是有滚动反馈，无论primary值为true or false；ScrollPhysics表示只有只有内容超出控件大小时才会有滚动反馈，无论primary值为true or false。
            physics: const BouncingScrollPhysics(),

            /// 表示控件的内边距。
            padding: EdgeInsets.all(6.0),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(6.0),
            physics: const BouncingScrollPhysics(),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: movies.map((movie) => MovieGridView(movie)).toList(),
            ),
          );
  }

  Future<List<Movie>> fetchData(String city) async {
    return await ApiService.getNowPlayingList(city: city);
  }
}
