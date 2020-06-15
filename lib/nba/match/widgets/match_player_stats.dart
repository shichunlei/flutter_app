import 'package:flutter/material.dart';

import '../../../page_index.dart';
import '../../index.dart';

class MatchPlayerStatsView extends StatefulWidget {
  final String teamName;
  final Color teamColor;
  final List<PlayerMatchStats> data;

  MatchPlayerStatsView(
      {Key key,
      @required this.teamName,
      @required this.data,
      this.teamColor: Colors.white})
      : super(key: key);

  @override
  createState() => _MatchPlayerStatsViewState();
}

class _MatchPlayerStatsViewState extends State<MatchPlayerStatsView> {
  ScrollController _bottomController;
  ScrollController _topController = ScrollController();

  @override
  void initState() {
    super.initState();

    _bottomController = ScrollController()
      ..addListener(() {
        setState(() {
          _topController.animateTo(_bottomController.offset,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        });
      });
  }

  @override
  void dispose() {
    _bottomController?.dispose();
    _topController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 2.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('球员统计 - ${widget.teamName}',
                style: TextStyles.textBoldDark16),
          ),
          StickWidget(
            stickHeader: Container(
              color: widget.teamColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ItemMatchPlayerStatsLeftView(
                        playerName: '球员',
                        playerNo: '号码',
                        textColor: Colors.white,
                      ),
                      flex: 2),
                  Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        controller: _topController,
                        child: TitleWidget(),
                        scrollDirection: Axis.horizontal,
                      ),
                      flex: 3)
                ],
              ),
            ),
            stickContent: Row(children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) => Container(
                            child: ItemMatchPlayerStatsLeftView(
                              bgColor:
                                  index > 4 ? Colors.white : Colors.grey[300],
                              playerName: widget.data[index].row[1],
                              playerNo: widget.data[index].row[0],
                            ),
                          ),
                      itemCount: widget.data.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false),
                  flex: 2),
              Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    controller: _bottomController,
                    scrollDirection: Axis.horizontal,
                    child: ItemMatchPlayerStatsView(data: widget.data),
                  ),
                  flex: 3)
            ]),
          )
        ]));
  }
}
