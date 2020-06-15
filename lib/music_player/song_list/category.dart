import 'dart:convert';

import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class SongListCategoryPage extends StatefulWidget {
  SongListCategoryPage({Key key}) : super(key: key);

  @override
  createState() => _SongListCategoryState();
}

class _SongListCategoryState extends State<SongListCategoryPage> {
  LoaderState state = LoaderState.Loading;

  List<MusicCategory> category = [];

  @override
  void initState() {
    super.initState();

    getSongListCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(title: Text('全部分类')),
        body: LoaderContainer(
            contentView: ListView.builder(
              itemBuilder: (_, index) {
                int _ = category[index].list.length % 3 == 0 ? 0 : 1;
                return ItemSongListCategory(
                  category: category[index],
                  height: (category[index].list.length ~/ 3 + _ - 2) * 3 +
                      (category[index].list.length ~/ 3 + _) *
                          ((Utils.width - 3.0 - Utils.width / 4.5) - 6.0) /
                          3 /
                          1.65,
                );
              },
              itemCount: category.length,
            ),
            loaderState: state),
      ),
    );
  }

  void getSongListCategoryData() async {
    await FileUtil.getInstance()
        .readDataFromAssets("assets/data/", "songlist_category.json")
        .then((data) {
      category = List()
        ..addAll((json.decode(data) as List ?? [])
            .map((o) => MusicCategory.fromMap(o)));
      setState(() {
        state = LoaderState.Succeed;
      });
    });
  }
}
