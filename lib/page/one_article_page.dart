import 'package:flutter/material.dart';

class OneArticlePage extends StatefulWidget {
  OneArticlePage({Key key}) : super(key: key);

  @override
  _OneArticlePageState createState() => _OneArticlePageState();
}

class _OneArticlePageState extends State<OneArticlePage> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('每日一文'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
