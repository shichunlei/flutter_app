import 'package:flutter/material.dart';
import 'package:flutter_app/movie/ui/classify_section_view.dart';

class MovieClassifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('分类找电影'),
      ),
      body: ListView(
        children: <Widget>[
          ClassifySectionView('类型'),
          ClassifySectionView('地区'),
          ClassifySectionView('年代'),
          ClassifySectionView('特色'),
        ],
      ),
    );
  }
}
