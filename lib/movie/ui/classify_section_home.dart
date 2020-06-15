import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ClassifySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  ClassifySection(this.title, this.movies);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      InkWell(
          onTap: () => pushNewPage(context, MovieTagListView(title)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[Text(title), Icon(Icons.chevron_right)]),
          )),
      Container(
        padding: EdgeInsets.all(6.0),
        child: Wrap(
          spacing: 5,
          children: movies.length == 0
              ? []
              : movies.map((movie) => MovieGridView(movie)).toList(),
        ),
      )
    ]);
  }
}
