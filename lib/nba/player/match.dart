import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class PlayerMatchPage extends StatefulWidget {
  final String id;

  PlayerMatchPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _PlayerMatchPageState();
}

class _PlayerMatchPageState extends State<PlayerMatchPage>
    with AutomaticKeepAliveClientMixin<PlayerMatchPage> {
  List<PlayerMatch> list = [];

  LoaderState state = LoaderState.Loading;

  ScrollController _controller = ScrollController();
  ScrollController _bottomController;
  ScrollController _topController = ScrollController();

  int seasonIndex = 0;

  String seasonTitle;

  @override
  void initState() {
    super.initState();

    seasonTitle = listSeason[seasonIndex].name;

    _bottomController = ScrollController()
      ..addListener(() {
        setState(() {
          _topController.animateTo(_bottomController.offset,
              duration: Duration(milliseconds: 100), curve: Curves.linear);
        });
      });

    getMatchData(widget.id,
        year: listSeason[seasonIndex].year, type: listSeason[seasonIndex].type);
  }

  @override
  void dispose() {
    _bottomController.dispose();
    _controller.dispose();
    _topController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: <Widget>[
                InkWell(
                  onTap: () => _showModalBottomSheet(context),
                  child: Row(
                    children: <Widget>[
                      Text('$seasonTitle'),
                      Gaps.hGap5,
                      Icon(Icons.arrow_drop_down)
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                ),
                Text('${list.length}场')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          StickWidget(
            stickHeader: _buildTitle(),
            stickContent: LoaderContainer(
              contentView: _buildBody(),
              loaderState: state,
              loadingView: SizedBox(
                width: double.infinity,
                height: 300,
                child: LoadingView(),
              ),
              emptyView: SizedBox(
                width: double.infinity,
                height: 300,
                child: EmptyPage(text: '暂无比赛数据'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void getMatchData(id, {int year: 2019, int type: 1}) async {
    List<PlayerMatch> _list =
        await ApiService.getPlayerMatch(id, year: year, type: type);

    list.clear();
    list.addAll(_list.reversed);

    if (list.length > 0) {
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.NoData;
    }
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildTitle() {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text('日期'),
              ),
              flex: 1),
          Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                controller: _topController,
                child: PlayerMatchTitle(),
              ),
              flex: 3)
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => Container(
                width: double.infinity,
                color: index % 2 == 0 ? Colors.white : Colors.grey[300],
                height: 40,
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            '${formatDateByStr(list[index].startTime, formats: [
                          mm,
                          '月',
                          dd,
                          '日'
                        ])}',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text:
                            '\t${list[index].opponent == '' ? "-" : list[index].isWin ? "胜" : "负"}',
                        style: TextStyle(
                            color: list[index].opponent == ''
                                ? Colors.black
                                : list[index].isWin
                                    ? Colors.green
                                    : Colors.red)),
                  ],
                ))),
            itemCount: list.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
          ),
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            controller: _bottomController,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1120,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) => ItemPlayerMatchView(
                  item: list[index],
                  bgColor: index % 2 == 0 ? Colors.white : Colors.grey[300],
                ),
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return ListView.builder(
            itemBuilder: (_, index) => ListTile(
              title: Text('${listSeason[index].name}'),
              onTap: () {
                print('tapped item ${index + 1}');
                Navigator.pop(context);
                seasonIndex = index;
                setState(() {
                  state = LoaderState.Loading;
                  seasonTitle = listSeason[seasonIndex].name;
                });
                getMatchData(widget.id,
                    year: listSeason[seasonIndex].year,
                    type: listSeason[seasonIndex].type);
              },
              selected: index == seasonIndex,
            ),
            itemCount: listSeason.length,
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
