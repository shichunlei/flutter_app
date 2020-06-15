import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class RankingBookListPage extends StatefulWidget {
  final String rankingId;

  RankingBookListPage({Key key, @required this.rankingId}) : super(key: key);

  @override
  createState() => _RankingBookListPageState();
}

class _RankingBookListPageState extends State<RankingBookListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LoaderState _status = LoaderState.Loading;

  List<Books> _books = [];

  Ranking ranking;

  @override
  void initState() {
    super.initState();

    debugPrint('${widget.rankingId}=====-------');
    getRankingBooks(widget.rankingId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoaderContainer(
          contentView: ListView.separated(
              itemBuilder: (_, index) {
                return ItemRankingBook(
                    book: _books[index],
                    index: index,
                    onPressed: () => pushNewPage(
                        context,
                        BookDetailsPage(
                            id: _books[index].id,
                            imageUrl: _books[index].cover)));
              },
              itemCount: _books.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Gaps.vGap3),
          loaderState: _status,
          onReload: () => getRankingBooks(widget.rankingId)),
    );
  }

  void getRankingBooks(String rankingId) async {
    ranking = await ApiService.getRankingBooks(rankingId);

    if (null == ranking) {
      _status = LoaderState.Failed;
    } else {
      _books = ranking.books;
      if (_books.length == 0) {
        _status = LoaderState.NoData;
      } else {
        _status = LoaderState.Succeed;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }
}
