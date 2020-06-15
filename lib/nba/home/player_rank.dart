import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class PlayerRankPage extends StatefulWidget {
  PlayerRankPage({Key key}) : super(key: key);

  @override
  createState() => _PlayerRankPageState();
}

class _PlayerRankPageState extends State<PlayerRankPage>
    with AutomaticKeepAliveClientMixin<PlayerRankPage> {
  PlayerSeasonRank rank;

  List<Player> assistsRank = [];
  List<Player> blocksRank = [];
  List<Player> pointsRank = [];
  List<Player> reboundsRank = [];
  List<Player> stealsRank = [];
  List<Player> turnoversRank = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: ListView(
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            CardPlayerRank(
              players: pointsRank,
              title: '场均得分',
              sort: 't70',
            ),
            CardPlayerRank(
              players: assistsRank,
              title: '场均助攻',
              sort: 't68',
            ),
            CardPlayerRank(
              players: reboundsRank,
              title: '场均篮板',
              sort: 't71',
            ),
            CardPlayerRank(
              players: blocksRank,
              title: '场均盖帽',
              sort: 't69',
            ),
            CardPlayerRank(
              players: stealsRank,
              title: '场均抢断',
              sort: 't72',
            ),
            CardPlayerRank(
              players: turnoversRank,
              title: '场均失误',
              sort: 't74',
            ),
          ],
        ),
        loaderState: state);
  }

  void getData() async {
    rank = await ApiService.getPlayerRankTopN();

    assistsRank.addAll(rank.assistsRank);
    blocksRank.addAll(rank.blocksRank);
    pointsRank.addAll(rank.pointsRank);
    stealsRank.addAll(rank.stealsRank);
    reboundsRank.addAll(rank.reboundsRank);
    turnoversRank.addAll(rank.turnoversRank);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
