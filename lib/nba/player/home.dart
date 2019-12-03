import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class PlayerHomePage extends StatefulWidget {
  final String id;

  PlayerHomePage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _PlayerHomePageState();
}

class _PlayerHomePageState extends State<PlayerHomePage>
    with SingleTickerProviderStateMixin {
  StatsBase player;

  Player playerBaseInfo;
  List<Player> playerPos = [];
  LeagueSeasonStat playerLeagueSeasonStat;
  SeasonDataStat playerSeasonStat;

  ScrollController scrollController;
  TabController _tabController;

  List<String> titleTabs = ['数据', "同位置", "比赛", "生涯", "新闻", "资料"];

  List<Tab> tabs = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: titleTabs.length);

    tabs = titleTabs.map((title) => Tab(text: "$title")).toList();

    getPlayerData(widget.id);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        contentView: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 0.0,
                pinned: true,
                centerTitle: true,
                expandedHeight: 250,
                title: Text('${playerBaseInfo.cnName}'),
                bottom: TabBar(
                    controller: _tabController, tabs: tabs, isScrollable: true),
                backgroundColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 74.0,
                          width: 74.0,
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(37.0)),
                              color: Colors.white),
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${playerBaseInfo?.avatar}'),
                              radius: 35.0),
                        ),
                        Gaps.vGap5,
                        Text('${playerBaseInfo.cnName}',
                            style: TextStyles.textWhite16),
                        Gaps.vGap5,
                        Text('${playerBaseInfo?.enName}',
                            style: TextStyles.textWhite14),
                        Gaps.vGap5,
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${playerSeasonStat?.pointsPG ?? "0"}分',
                                  style: TextStyles.textWhite14),
                              VerticalDivider(color: Colors.white),
                              Text('${playerSeasonStat?.reboundsPG ?? "0"}篮板',
                                  style: TextStyles.textWhite14),
                              VerticalDivider(color: Colors.white),
                              Text('${playerSeasonStat?.assistsPG ?? "0"}助攻',
                                  style: TextStyles.textWhite14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            child: TabBarView(
              controller: _tabController,
              children: [
                PlayerDataPage(
                    playerSeasonStat: playerSeasonStat,
                    playerLeagueSeasonStat: playerLeagueSeasonStat),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (_, index) => ItemRoster(
                      player: playerPos[index],
                      onPressed: () {
                        setState(() {
                          state = LoaderState.Loading;
                        });
                        getPlayerData(playerPos[index].playerId);
                      }),
                  itemCount: playerPos.length,
                ),
                PlayerMatchPage(id: playerBaseInfo?.playerId),
                PlayerCareerPage(id: playerBaseInfo?.playerId),
                NBANewsPage(name: playerBaseInfo?.cnAlias),
                PlayerInfoPage(playerBaseInfo: playerBaseInfo)
              ],
            ),
          ),
        ),
        loaderState: state,
      ),
    );
  }

  void getPlayerData(String id) async {
    player = await ApiService.getPlayerInfo(id: id);

    playerBaseInfo = player.playerBaseInfo;

    playerPos.clear();
    playerPos.addAll(player.playerPos);

    playerSeasonStat = player.playerSeasonStat;

    playerLeagueSeasonStat = player.playerLeagueSeasonStat;

    setState(() {
      state = LoaderState.Succeed;
    });
  }
}
