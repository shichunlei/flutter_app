import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class MatchPage extends StatefulWidget {
  final String mid;

  MatchPage({Key key, @required this.mid}) : super(key: key);

  @override
  createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  MatchBaseBean data;

  List<PeriodGoalsBean> list = [];

  LoaderState state = LoaderState.Loading;

  double width;

  @override
  void initState() {
    super.initState();

    width = Utils.width;

    getMatchData(widget.mid);
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                '${data?.teamInfo?.leftName ?? ""} - ${data?.teamInfo?.rightName ?? ""}'),
            centerTitle: true),
        body: SafeArea(
          child: LoaderContainer(
              contentView: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(children: [
                    ItemMatchHead(teamInfo: data?.teamInfo),
                    Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 2.0),
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        height: 110.0,
                        child: SingleChildScrollView(
                            padding: EdgeInsets.zero,
                            controller: ScrollController(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: list
                                    .map((item) => ItemPeriodGoalsView(
                                          width: width / 6.0,
                                          item: item,
                                        ))
                                    .toList()))),
                    Visibility(
                        visible: data != null && data.maxPlayers.length > 0,
                        child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 2.0),
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('本场最佳',
                                      style: TextStyles.textBoldDark16),
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (_, index) =>
                                        ItemMatchPlayerMaxDataView(
                                      item: data?.maxPlayers[index],
                                      leftColor: Color(Utils.getColorHexFromStr(
                                          '${data?.teamInfo?.leftTeamColor}')),
                                      rightColor: Color(Utils.getColorHexFromStr(
                                          '${data?.teamInfo?.rightTeamColor}')),
                                    ),
                                    itemCount: data?.maxPlayers?.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                  )
                                ]))),
                    Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 2.0),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('球队统计', style: TextStyles.textBoldDark16),
                              Gaps.vGap8,
                              Row(
                                  children: <Widget>[
                                    ImageLoadView(
                                        '${data?.teamInfo?.leftBadge}',
                                        width: 60,
                                        height: 60),
                                    Text('VS',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                    ImageLoadView(
                                        '${data?.teamInfo?.rightBadge}',
                                        width: 60,
                                        height: 60),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround),
                              Gaps.vGap8,
                              ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (_, index) => ItemMatchTeamStatsView(
                                      item: data?.teamStats[index],
                                      leftColor: Color(Utils.getColorHexFromStr(
                                          '${data?.teamInfo?.leftTeamColor}')),
                                      rightColor: Color(Utils.getColorHexFromStr(
                                          '${data?.teamInfo?.rightTeamColor}'))),
                                  itemCount: data?.teamStats?.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false)
                            ])),
                    data?.playerStats == null
                        ? SizedBox()
                        : MatchPlayerStatsView(
                            data: data?.playerStats?.left,
                            teamName: data?.teamInfo?.leftName,
                            teamColor: Color(Utils.getColorHexFromStr(
                                data?.teamInfo?.leftTeamColor4H5,
                                alpha: 'AA')),
                          ),
                    data?.playerStats == null
                        ? SizedBox()
                        : MatchPlayerStatsView(
                            data: data?.playerStats?.right,
                            teamName: data?.teamInfo?.rightName,
                            teamColor: Color(Utils.getColorHexFromStr(
                                data?.teamInfo?.rightTeamColor4H5,
                                alpha: 'AA')),
                          ),
                  ])),
              loaderState: state),
        ),
      ),
    );
  }

  void getMatchData(String mid) async {
    data = await ApiService.getMatchStats(mid);

    if (data != null) {
      state = LoaderState.Succeed;

      List<String> head = data.periodGoals.head;
      int length = head.length;

      for (int i = 0; i < length; i++) {
        list.add(
          PeriodGoalsBean(
              isPic: i == 0,
              title: head[i],
              leftValue: i == 0
                  ? "${data?.teamInfo?.leftBadge}"
                  : "${data?.periodGoals?.rows[0][i]}",
              rightValue: i == 0
                  ? "${data?.teamInfo?.rightBadge}"
                  : "${data?.periodGoals?.rows[1][i]}",
              action: data?.periodGoals?.quarter == head[i]),
        );
      }
    } else {
      state = LoaderState.NoAction;
    }
    setState(() {});
  }
}
