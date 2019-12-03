import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class TeamSchedulePage extends StatefulWidget {
  final String id;

  TeamSchedulePage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _TeamSchedulePageState();
}

class _TeamSchedulePageState extends State<TeamSchedulePage>
    with AutomaticKeepAliveClientMixin<TeamSchedulePage> {
  List<Schedule> schedule = [];

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
        contentView: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (_, index) {
            return StickWidget(
                stickHeader: Container(
                  height: 35,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('${schedule[index].m}'),
                  alignment: Alignment.centerLeft,
                  color: Colors.red[100],
                ),
                stickContent: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (_, itemIndex) => ItemSchedule(
                        item: schedule[index].list[itemIndex], isTeam: true),
                    separatorBuilder: (_, __) => Gaps.vGap(1.0),
                    itemCount: schedule[index].list.length));
          },
          itemCount: schedule.length,
        ),
        loaderState: state);
  }

  void getDataByTeamId(String id) async {
    List<Schedule> list = await ApiService.getTeamSchedule(id: id);

    schedule.addAll(list);
    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
