import 'package:flutter/material.dart';

import '../page_index.dart';
import 'index.dart';

class NBANewsPage extends StatefulWidget {
  final String name;

  NBANewsPage({Key key, @required this.name}) : super(key: key);

  @override
  createState() => _NBANewsPageState();
}

class _NBANewsPageState extends State<NBANewsPage>
    with AutomaticKeepAliveClientMixin<NBANewsPage> {
  LoaderState state = LoaderState.Loading;

  List<NBANews> news = [];

  @override
  void initState() {
    super.initState();

    getPlayerNews(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
      contentView: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) => ItemPlayerNews(item: news[index]),
        itemCount: news.length,
        separatorBuilder: (BuildContext context, int index) => Gaps.vGap3,
      ),
      loaderState: state,
      loadingView: SizedBox(
        width: double.infinity,
        height: 300,
        child: LoadingView(),
      ),
      emptyView: SizedBox(
        width: double.infinity,
        height: 300,
        child: EmptyPage(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void getPlayerNews(String name) async {
    List<NBANews> list = await ApiService.getNBANews(name);

    news.clear();
    news.addAll(list);

    if (news.length > 0) {
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.NoData;
    }

    setState(() {});
  }
}
