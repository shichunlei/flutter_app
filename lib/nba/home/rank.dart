import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class RankPage extends StatefulWidget {
  RankPage({Key key}) : super(key: key);

  @override
  createState() => _RankPageState();
}

class _RankPageState extends State<RankPage>
    with AutomaticKeepAliveClientMixin<RankPage> {
  List<RankBase> ranks = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getRankData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            return StickWidget(
                stickHeader: Container(
                  height: 35,
                  color: Colors.brown[200],
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('${ranks[index].title}'),
                        flex: 5,
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text('胜', textAlign: TextAlign.center),
                            Text('负', textAlign: TextAlign.center),
                            Text('胜率', textAlign: TextAlign.center),
                            Text('胜差', textAlign: TextAlign.center),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        ),
                        flex: 9,
                      ),
                    ],
                  ),
                ),
                stickContent: ListView.builder(
                    itemBuilder: (_, rank) => ItemRank(
                          rank: rank + 1,
                          item: ranks[index].list[rank],
                          type: ranks[index].type,
                        ),
                    itemCount: ranks[index].list.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false));
          },
          itemCount: ranks.length,
        ),
        loaderState: state);
  }

  void getRankData() async {
    List<RankBase> list = await ApiService.getTeamRank();

    ranks.addAll(list);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
