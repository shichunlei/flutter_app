import 'package:flutter/material.dart';
import 'package:flutter_app/nba/widgets/item_team_data_rank.dart';
import 'package:flutter_app/ui/loader.dart';

import '../../../page_index.dart';
import '../../index.dart';

class TeamDataRankListPage extends StatefulWidget {
  final List<SeasonDataStat> list;

  TeamDataRankListPage({Key key, this.list}) : super(key: key);

  @override
  createState() => _TeamDataRankListPageState();
}

class _TeamDataRankListPageState extends State<TeamDataRankListPage>
    with AutomaticKeepAliveClientMixin<TeamDataRankListPage> {
  LoaderState state = LoaderState.NoAction;

  List<SeasonDataStat> list = [];

  @override
  void initState() {
    super.initState();

    list.addAll(widget.list);
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
          itemBuilder: (_, index) =>
              ItemTeamDataRank(item: list[index], rank: index + 1),
          itemCount: list.length,
        ),
        loaderState: state);
  }

  @override
  bool get wantKeepAlive => true;
}
