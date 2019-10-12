import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../page/movie_search_page.dart';
import 'movie_grid_view.dart';

import '../../page_index.dart';

class ClassifySection extends StatefulWidget {
  final String title;
  final List<Movie> movies;

  ClassifySection(this.title, this.movies);

  @override
  createState() => _ClassifySectionState();
}

class _ClassifySectionState extends State<ClassifySection>
    with AutomaticKeepAliveClientMixin<ClassifySection> {
  @override
  bool get wantKeepAlive => true;

  List<Movie> tagMovies = [];

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
          children: widget.movies.length == 0
              ? <Widget>[]
              : widget.movies.map((movie) => MovieGridView(movie)).toList(),
        ),
      )
    ]);
  }
}
