import 'package:flutter/material.dart';

class MovieCelebrityPage extends StatefulWidget {
  final String id;
  final String name;

  MovieCelebrityPage({
    Key key,
    this.id,
    this.name,
  }) : super(key: key);

  @override
  createState() => _MovieCelebrityPageState();
}

class _MovieCelebrityPageState extends State<MovieCelebrityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: null,
    );
  }
}
