import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class PlayerDataPage extends StatefulWidget {
  final LeagueSeasonStat playerLeagueSeasonStat;
  final SeasonDataStat playerSeasonStat;

  PlayerDataPage({Key key, this.playerSeasonStat, this.playerLeagueSeasonStat})
      : super(key: key);

  @override
  createState() => _PlayerDataPageState();
}

class _PlayerDataPageState extends State<PlayerDataPage>
    with AutomaticKeepAliveClientMixin<PlayerDataPage> {
  LeagueSeasonStat get playerLeagueSeasonStat => widget.playerLeagueSeasonStat;

  SeasonDataStat get playerSeasonStat => widget.playerSeasonStat;

  var isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5.0),
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Text('数据总览'),
          ),
          Center(
            child: RadarWidget(
              layerNum: 5,
              data: {
                "得分": playerSeasonStat?.pointsSerial == '0'
                    ? 0.0
                    : 100 - double.parse(playerSeasonStat?.pointsSerial),
                "助攻": playerSeasonStat?.assistsSerial == '0'
                    ? 0.0
                    : 100 - double.parse(playerSeasonStat?.assistsSerial),
                "篮板": playerSeasonStat?.reboundsSerial == '0'
                    ? 0.0
                    : 100 - double.parse(playerSeasonStat?.reboundsSerial),
                "抢断": playerSeasonStat?.stealsSerial == '0'
                    ? 0.0
                    : 100 - double.parse(playerSeasonStat?.stealsSerial),
                "盖帽": playerSeasonStat?.blocksSerial == '0'
                    ? 0.0
                    : 100 - double.parse(playerSeasonStat?.blocksSerial)
              },
              pointColors: [
                Colors.redAccent,
                Colors.purpleAccent,
                Colors.lightBlue,
                Colors.green,
                Colors.pink
              ],
              sideStyle: SideStyle.circle,
              maxValue: 100.0,
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text('常规数据'),
                ToggleButtons(
                  children: <Widget>[Text('场均'), Text('总计')],
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        if (i == index) {
                          isSelected[i] = true;
                        } else {
                          isSelected[i] = false;
                        }
                      }
                    });
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              buildTableRow(
                  '数据', '球员数据', '联盟最高', '联盟平均', '联盟排名', Colors.grey[500]),
              buildTableRow(
                  '得分',
                  isSelected[0]
                      ? '${playerSeasonStat?.pointsPG ?? "0"}'
                      : '${playerSeasonStat?.points ?? "0"}',
                  '${playerLeagueSeasonStat?.pointsLeagueMax}',
                  '${playerLeagueSeasonStat?.pointsLeagueAvg}',
                  '${playerSeasonStat?.pointsSerial == '0' ? "-" : playerSeasonStat?.pointsSerial}',
                  Colors.white),
              buildTableRow(
                  '助攻',
                  isSelected[0]
                      ? '${playerSeasonStat?.assistsPG ?? "0"}'
                      : '${playerSeasonStat?.assists ?? "0"}',
                  '${playerLeagueSeasonStat?.assistsLeagueMax}',
                  '${playerLeagueSeasonStat?.assistsLeagueAvg}',
                  '${playerSeasonStat?.assistsSerial == '0' ? "-" : playerSeasonStat?.assistsSerial}',
                  Colors.grey[500]),
              buildTableRow(
                  '篮板',
                  isSelected[0]
                      ? '${playerSeasonStat?.reboundsPG ?? "0"}'
                      : '${playerSeasonStat?.rebounds ?? "0"}',
                  '${playerLeagueSeasonStat?.reboundsLeagueMax}',
                  '${playerLeagueSeasonStat?.reboundsLeagueAvg}',
                  '${playerSeasonStat?.reboundsSerial == '0' ? "-" : playerSeasonStat?.reboundsSerial}',
                  Colors.white),
              buildTableRow(
                  '抢断',
                  isSelected[0]
                      ? '${playerSeasonStat?.stealsPG ?? "0"}'
                      : '${playerSeasonStat?.steals ?? "0"}',
                  '${playerLeagueSeasonStat?.stealsLeagueMax}',
                  '${playerLeagueSeasonStat?.stealsLeagueAvg}',
                  '${playerSeasonStat?.stealsSerial == '0' ? "-" : playerSeasonStat?.stealsSerial}',
                  Colors.grey[500]),
              buildTableRow(
                  '盖帽',
                  isSelected[0]
                      ? '${playerSeasonStat?.blocksPG ?? "0"}'
                      : '${playerSeasonStat?.blocks ?? "0"}',
                  '${playerLeagueSeasonStat?.blockedLeagueMax}',
                  '${playerLeagueSeasonStat?.blockedLeagueAvg}',
                  '${playerSeasonStat?.blocksSerial == '0' ? "-" : playerSeasonStat?.blocksSerial}',
                  Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  TableRow buildTableRow(String title, String value, String max, String avg,
      String rank, Color bgColor) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$title'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: Text('$value'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: Text('$max'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: Text('$avg'),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: Text('$rank'),
        ),
      ],
      decoration: BoxDecoration(
        color: bgColor,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
