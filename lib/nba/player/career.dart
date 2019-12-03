import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class PlayerCareerPage extends StatefulWidget {
  final String id;

  PlayerCareerPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _PlayerCareerPageState();
}

class _PlayerCareerPageState extends State<PlayerCareerPage>
    with AutomaticKeepAliveClientMixin<PlayerCareerPage> {
  LoaderState state = LoaderState.Loading;

  List<SeasonDataStat> careerData = [];

  ScrollController _topController = ScrollController();
  ScrollController _bottomController;

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

    getCareerData(widget.id);
  }

  @override
  void dispose() {
    _bottomController.dispose();
    _topController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
      loaderState: state,
      loadingView:
          SizedBox(width: double.infinity, height: 300, child: LoadingView()),
      emptyView: SizedBox(
          width: double.infinity,
          height: 300,
          child: EmptyPage(text: '暂无比赛数据')),
      contentView: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              width: double.infinity,
              child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: PlayerCareerTitle(),
                  scrollDirection: Axis.horizontal,
                  controller: _topController),
            ),
            Container(
              height: careerData.length * 40.0,
              width: double.infinity,
              child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: PlayerCareerBody(list: careerData),
                  scrollDirection: Axis.horizontal,
                  controller: _bottomController),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void getCareerData(String id) async {
    List<SeasonDataStat> list = await ApiService.getPlayerCareer(id);

    careerData.clear();
    careerData.addAll(list.reversed);

    if (list.length > 0) {
      state = LoaderState.Succeed;
    } else {
      state = LoaderState.NoData;
    }
    if (mounted) {
      setState(() {});
    }
  }
}
