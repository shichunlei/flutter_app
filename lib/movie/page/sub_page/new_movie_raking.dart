import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_grid_view.dart';
import 'package:flutter_app/utils/loading_util.dart';

class NewMovieRakingPage extends StatefulWidget {
  @override
  _NewMovieRakingPageState createState() => _NewMovieRakingPageState();
}

class _NewMovieRakingPageState extends State<NewMovieRakingPage>
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
      return ItemGridView(movies: movies);
    }
    return getLoadingWidget();
  }

  void getMovieList() async {
    movies = await ApiService.getNewMoviesList();
    loadError = movies == null;
    setState(() {});
  }
}
