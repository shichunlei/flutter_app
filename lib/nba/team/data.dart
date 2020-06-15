import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class TeamDataPage extends StatefulWidget {
  final String id;
  final String teamName;
  final Color teamColor;

  TeamDataPage({Key key, this.id, this.teamName, this.teamColor})
      : super(key: key);

  @override
  createState() => _TeamDataPageState();
}

class _TeamDataPageState extends State<TeamDataPage>
    with AutomaticKeepAliveClientMixin<TeamDataPage> {
  StatsBase teamStats;

  LeagueSeasonStat teamLeagueSeasonStat;

  SeasonDataStat teamSeasonStat;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getTeamStats(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
      contentView: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '数据总览',
                style: TextStyles.textDark16,
              ),
            ),
            Container(
              height: 180,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ItemBarChartView(
                        title: '得分',
                        avg: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.pointsLeagueAvg),
                        max: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.pointsLeagueMax),
                        value: teamSeasonStat == null
                            ? 0.0
                            : double.parse(teamSeasonStat?.pointsPG),
                        teamColor: widget.teamColor,
                      ),
                      ItemBarChartView(
                        title: '篮板',
                        avg: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.reboundsLeagueAvg),
                        max: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.reboundsLeagueMax),
                        value: teamSeasonStat == null
                            ? 0.0
                            : double.parse(teamSeasonStat?.reboundsPG),
                        teamColor: widget.teamColor,
                      ),
                      ItemBarChartView(
                        title: '助攻',
                        avg: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.assistsLeagueAvg),
                        max: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.assistsLeagueMax),
                        value: teamSeasonStat == null
                            ? 0.0
                            : double.parse(teamSeasonStat?.assistsPG),
                        teamColor: widget.teamColor,
                      ),
                      ItemBarChartView(
                        title: '抢断',
                        avg: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.stealsLeagueAvg),
                        max: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.stealsLeagueMax),
                        value: teamSeasonStat == null
                            ? 0.0
                            : double.parse(teamSeasonStat?.stealsPG),
                        teamColor: widget.teamColor,
                      ),
                      ItemBarChartView(
                        title: '盖帽',
                        avg: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.blockedLeagueAvg),
                        max: teamLeagueSeasonStat == null
                            ? 0.0
                            : double.parse(
                                teamLeagueSeasonStat?.blockedLeagueMax),
                        value: teamSeasonStat == null
                            ? 0.0
                            : double.parse(teamSeasonStat?.blocksPG),
                        teamColor: widget.teamColor,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  Gaps.vGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            color: widget.teamColor,
                            width: 15,
                            height: 15,
                          ),
                          Gaps.hGap10,
                          Text('${widget.teamName}')
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            color: Colors.purpleAccent,
                            width: 15,
                            height: 15,
                          ),
                          Gaps.hGap10,
                          Text('联盟最高')
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            color: Colors.lightBlue,
                            width: 15,
                            height: 15,
                          ),
                          Gaps.hGap10,
                          Text('联盟平均')
                        ],
                        mainAxisSize: MainAxisSize.min,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '数据总览',
                style: TextStyles.textDark16,
              ),
            ),
            Center(
              child: RadarWidget(
                layerNum: 5,
                data: {
                  "得分": teamSeasonStat == null
                      ? 0.0
                      : 30 - double.parse(teamSeasonStat?.pointsSerial),
                  "助攻": teamSeasonStat == null
                      ? 0.0
                      : 30 - double.parse(teamSeasonStat?.assistsSerial),
                  "篮板": teamSeasonStat == null
                      ? 0.0
                      : 30 - double.parse(teamSeasonStat?.reboundsSerial),
                  "抢断": teamSeasonStat == null
                      ? 0.0
                      : 30 - double.parse(teamSeasonStat?.stealsSerial),
                  "盖帽": teamSeasonStat == null
                      ? 0.0
                      : 30 - double.parse(teamSeasonStat?.blocksSerial)
                },
                pointColors: [
                  Colors.redAccent,
                  Colors.purpleAccent,
                  Colors.lightBlue,
                  Colors.green,
                  Colors.pink
                ],
                layerColor: widget.teamColor,
                maxValue: 30.0,
              ),
            ),
          ],
        ),
      ),
      loaderState: state,
    );
  }

  void getTeamStats(String id) async {
    teamStats = await ApiService.getTeamStats(id: id);

    teamLeagueSeasonStat = teamStats.teamLeagueSeasonStat;
    teamSeasonStat = teamStats.teamSeasonStat;
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
