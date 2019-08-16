import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../page/movie_search_page.dart';
import 'movie_grid_view.dart';

import '../../page_index.dart';

class ClassifySection extends StatefulWidget {
  final String title;

  ClassifySection(this.title);

  @override
  _ClassifySectionState createState() => _ClassifySectionState();
}

class _ClassifySectionState extends State<ClassifySection>
    with AutomaticKeepAliveClientMixin<ClassifySection> {
  @override
  bool get wantKeepAlive => true;

  List<Movie> tagMovies = [];

  @override
  void initState() {
    super.initState();

    searchMovie(widget.title);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FlatButton(
        onPressed: () =>
            pushNewPage(context, MovieSearchPage(tag: widget.title)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(widget.title), Icon(Icons.chevron_right)]),
      ),
      Container(
        padding: EdgeInsets.all(6.0),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: tagMovies.length == 0
              ? <Widget>[]
              : tagMovies.map((movie) => MovieGridView(movie)).toList(),
        ),
      )
    ]);
  }

  void searchMovie(String title) async {
    tagMovies = await ApiService.getSearchListByTag(
        tag: widget.title, start: 0, count: 3);

    setState(() {});
  }
}
