import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';
import '../page/movie_tag_list.dart';

import '../../page_index.dart';
import 'index.dart';

class ClassifySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  ClassifySection(this.title, this.movies);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FlatButton(
          onPressed: () => pushNewPage(context, MovieTagListView(title)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(title), Icon(Icons.chevron_right)])),
      Container(
        padding: EdgeInsets.all(6.0),
        child: Wrap(
          spacing: 5,
          runSpacing: 5,
          children: movies.length == 0
              ? []
              : movies.map((movie) => MovieGridView(movie)).toList(),
        ),
      )
    ]);
  }
}
