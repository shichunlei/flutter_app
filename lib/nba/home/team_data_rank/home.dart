import 'package:flutter/material.dart';
import 'package:flutter_app/ui/loader.dart';

import '../../../page_index.dart';
import '../../index.dart';

class TeamDataRankPage extends StatefulWidget {
  TeamDataRankPage({Key key}) : super(key: key);

  @override
  createState() => _TeamDataRankPageState();
}

class _TeamDataRankPageState extends State<TeamDataRankPage>
    with
        AutomaticKeepAliveClientMixin<TeamDataRankPage>,
        SingleTickerProviderStateMixin {
  LoaderState state = LoaderState.Loading;

  List<SeasonDataStat> list = [];

  List<SeasonDataStat> pointsList = [];
  List<SeasonDataStat> assistsList = [];
  List<SeasonDataStat> reboundsList = [];
  List<SeasonDataStat> stealsList = [];
  List<SeasonDataStat> blocksList = [];
  List<SeasonDataStat> turnoversList = [];
  List<SeasonDataStat> oppPointsList = [];

  TabController _controller;

  List<String> titleTabs = ['得分榜', "助攻榜", "篮板榜", "抢断榜", "盖帽榜", "失误榜", '失分榜'];

  int customIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
        vsync: this, length: titleTabs.length, initialIndex: customIndex)
      ..addListener(() {
        setState(() {
          customIndex = _controller.index;

          print(customIndex);
        });
      });

    getData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        TabBar(
          labelPadding: EdgeInsets.zero,
          tabs: titleTabs.map(
            (title) {
              int index = titleTabs.indexOf(title);
              return Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: index == customIndex
                          ? Colors.blueAccent
                          : Colors.transparent),
                  child: Text(
                    "$title",
                    style: TextStyle(
                        color: index == customIndex
                            ? Colors.white
                            : Colors.black54,
                        fontSize: 14.0),
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                ),
              );
            },
          ).toList(),
          isScrollable: true,
          controller: _controller,

          /// 取消指示器横线
          indicator: const BoxDecoration(),
        ),
        Expanded(
          child: LoaderContainer(
            contentView: TabBarView(
              controller: _controller,
              children: [
                TeamDataRankListPage(list: pointsList),
                TeamDataRankListPage(list: assistsList),
                TeamDataRankListPage(list: reboundsList),
                TeamDataRankListPage(list: stealsList),
                TeamDataRankListPage(list: blocksList),
                TeamDataRankListPage(list: turnoversList),
                TeamDataRankListPage(list: oppPointsList),
              ],
            ),
            loaderState: state,
          ),
        )
      ],
    );
  }

  void getData() async {
    list = await ApiService.getTeamRankAll();

    list.forEach((item) {
      pointsList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.pointsPG),
        value: double.parse(item.points),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      assistsList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.assistsPG),
        value: double.parse(item.assists),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      blocksList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.blocksPG),
        value: double.parse(item.blocks),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      turnoversList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.turnoversPG),
        value: double.parse(item.turnovers),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      stealsList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.stealsPG),
        value: double.parse(item.steals),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      reboundsList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.reboundsPG),
        value: double.parse(item.rebounds),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));

      oppPointsList.add(SeasonDataStat(
        teamId: item.teamId,
        cnName: item.cnName,
        valuePG: double.parse(item.oppPointsPG),
        value: double.parse(item.oppPointsPG) * int.parse(item.games),
        logo: item.logo,
        wins: item.wins,
        losses: item.losses,
      ));
    });

    pointsList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    assistsList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    blocksList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    turnoversList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    stealsList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    reboundsList.sort((left, right) => right.valuePG.compareTo(left.valuePG));
    oppPointsList.sort((left, right) => left.valuePG.compareTo(right.valuePG));
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
