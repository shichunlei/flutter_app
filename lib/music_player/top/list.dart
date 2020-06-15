import 'dart:convert';

import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class RankListPage extends StatefulWidget {
  RankListPage({Key key}) : super(key: key);

  @override
  createState() => _RankListPageState();
}

class _RankListPageState extends State<RankListPage> {
  List<MusicCategory> tops = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getRanksData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
          title: Text('音乐排行榜'),
        ),
        body: LoaderContainer(
            contentView: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) => StickWidget(
                stickContent: tops[index].list.length % 3 == 0
                    ? GridView.builder(
                        padding: EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 3.0,
                            childAspectRatio: 1.0),
                        itemBuilder: (_, rank) =>
                            ItemRankGrid(item: tops[index].list[rank]),
                        itemCount: tops[index].list.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                      )
                    : ListView.separated(
                        padding: EdgeInsets.all(8.0),
                        itemBuilder: (_, rank) =>
                            ItemRankList(item: tops[index].list[rank]),
                        itemCount: tops[index].list.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (BuildContext context, int index) =>
                            Gaps.vGap3,
                      ),
                stickHeader: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Text(
                    '${tops[index].title}',
                    style: TextStyles.textBoldBlue14,
                  ),
                ),
              ),
              itemCount: tops.length,
            ),
            loaderState: state),
      ),
    );
  }

  void getRanksData() async {
    await FileUtil.getInstance()
        .readDataFromAssets("assets/data/", "top_category.json")
        .then((data) {
      tops = List()
        ..addAll((json.decode(data) as List ?? [])
            .map((o) => MusicCategory.fromMap(o)));
      setState(() {
        state = LoaderState.Succeed;
      });
    });
  }
}
