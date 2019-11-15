import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class RankingPage extends StatefulWidget {
  final List<Ranking> ranking;

  RankingPage({Key key, @required this.ranking}) : super(key: key);

  @override
  createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int checkIndex = 0;

  @override
  void initState() {
    super.initState();

    debugPrint('${widget.ranking.length}========================');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: Row(children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                    color: colorSnow,
                    child: ListView.separated(
                        itemCount: widget.ranking.length,
                        itemBuilder: (_, index) => GestureDetector(
                            onTap: () => setState(() => checkIndex = index),
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                color: checkIndex == index
                                    ? Colors.white
                                    : colorSnow,
                                child: Row(children: <Widget>[
                                  Container(
                                      color: checkIndex == index
                                          ? readerMainColor
                                          : Colors.white,
                                      width: 4,
                                      height: 20),
                                  Gaps.hGap8,
                                  Text('${widget.ranking[index].shortTitle}',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize:
                                              checkIndex == index ? 16.0 : 15.0,
                                          color: checkIndex == index
                                              ? readerMainColor
                                              : Colors.grey))
                                ]))),
                        separatorBuilder: (BuildContext context, int index) =>
                            Gaps.line))),
            Container(width: 0.2, height: double.infinity, color: Colors.grey),
            Expanded(
                flex: 7,
                child: IndexedStack(
                    index: checkIndex,
                    children: widget.ranking
                        .map((ranking) =>
                            RankingBookListPage(rankingId: ranking?.id))
                        .toList()))
          ]),
        ));
  }
}
