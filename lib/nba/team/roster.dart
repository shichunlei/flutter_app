import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class TeamRosterPage extends StatefulWidget {
  final String id;

  TeamRosterPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _TeamRosterPageState();
}

class _TeamRosterPageState extends State<TeamRosterPage>
    with AutomaticKeepAliveClientMixin<TeamRosterPage> {
  List<Player> players = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getDataByTeamId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => ItemRoster(
                  player: players[index],
                  onPressed: () => pushNewPage(
                    context,
                    PlayerHomePage(id: players[index].playerId),
                  ),
                ),
            separatorBuilder: (_, index) => Gaps.vGap(2.0),
            itemCount: players.length),
        loaderState: state);
  }

  void getDataByTeamId(String id) async {
    List<Player> list = await ApiService.getTeamRoster(id: id);
    players.addAll(list);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
