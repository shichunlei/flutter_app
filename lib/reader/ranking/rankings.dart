import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class RankingsPage extends StatefulWidget {
  RankingsPage({Key key}) : super(key: key);

  @override
  createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  RankingResult result;

  List<Tab> tabs = [
    Tab(text: '男生'),
    Tab(text: '女生'),
    Tab(text: '漫画'),
    Tab(text: '电子书')
  ];

  List<Ranking> male = [];
  List<Ranking> female = [];
  List<Ranking> picture = [];
  List<Ranking> epub = [];

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: tabs.length, vsync: this);

    getRankings();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
            title: Text('排行', style: TextStyle(color: Colors.black54)),
            bottom: TabBar(
                tabs: tabs,
                controller: _controller,
                indicatorColor: readerMainColor,
                labelColor: readerMainColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 16))),
        body: LoaderContainer(
            contentView: TabBarView(controller: _controller, children: [
              RankingPage(ranking: female),
              RankingPage(ranking: male),
              RankingPage(ranking: picture),
              RankingPage(ranking: epub)
            ]),
            loaderState: _status),
      ),
    );
  }

  void getRankings() async {
    result = await ApiService.getBookRankings();

    if (result != null) {
      male = result.male;
      picture = result.picture;
      female = result.female;
      epub = result.epub;

      setState(() {
        _status = LoaderState.Succeed;
      });
    } else {
      setState(() {
        _status = LoaderState.Failed;
      });
    }
  }
}
