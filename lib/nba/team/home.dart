import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class TeamHomePage extends StatefulWidget {
  final String title;
  final String id;

  TeamHomePage({Key key, @required this.title, @required this.id})
      : super(key: key);

  @override
  createState() => _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage>
    with SingleTickerProviderStateMixin {
  LoaderState state = LoaderState.Loading;

  ScrollController scrollController;
  TabController _tabController;

  List<String> titleTabs = ['数据', "赛程", "阵容", "新闻", "资料"];

  List<Tab> tabs = [];

  Team team;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: titleTabs.length);

    tabs = titleTabs.map((title) => Tab(text: "$title")).toList();

    getTeamInfo(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: Text('${team?.cnName}'),
                bottom: TabBar(
                    controller: _tabController, tabs: tabs, isScrollable: true),
                backgroundColor:
                    Color(Utils.getColorHexFromStr(team?.teamColor)),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ImageLoadView('${team?.logo}',
                            width: 74.0, height: 74.0),
                        Gaps.vGap5,
                        Text('${team?.cnName}', style: TextStyles.textWhite16),
                        Gaps.vGap5,
                        Text('${team?.enName}', style: TextStyles.textWhite14),
                        Gaps.vGap5,
                        Container(
                          height: 18,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${team?.wins}胜',
                                  style: TextStyles.textWhite14),
                              VerticalDivider(color: Colors.white),
                              Text('${team?.losses}负',
                                  style: TextStyles.textWhite14),
                              VerticalDivider(color: Colors.white),
                              Text('${team?.continueRecord}',
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
                TeamDataPage(
                  id: team?.teamId,
                  teamName: team?.cnName,
                  teamColor: team == null
                      ? Color(0xa6FF00FF)
                      : Color(Utils.getColorHexFromStr(team?.teamColor,
                          alpha: 'A6')),
                ),
                TeamSchedulePage(id: team?.teamId),
                TeamRosterPage(id: team?.teamId),
                NBANewsPage(name: team?.cnName),
                TeamInfoPage(team: team),
              ],
            ),
          ),
        ),
        loaderState: state,
      ),
    );
  }

  void getTeamInfo(String id) async {
    team = await ApiService.getTeamInfo(id);

    setState(() {
      state = LoaderState.Succeed;
    });
  }
}
