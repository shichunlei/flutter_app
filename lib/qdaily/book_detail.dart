import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/bean/qdaily_app.dart';

class BookDetailPage extends StatefulWidget {
  final int id;

  BookDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  DetailBean detailBean;
  PostBean post;
  AuthorBean author;

  ResponseBean responseBean;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: null,
    );
  }
}
