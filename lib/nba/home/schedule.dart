import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import '../index.dart';

class SchedulePage extends StatefulWidget {
  SchedulePage({Key key}) : super(key: key);

  @override
  createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with AutomaticKeepAliveClientMixin<SchedulePage> {
  String startDate, endDate;

  DateTime day = DateTime.now();

  List<Schedule> schedule = [];

  LoaderState state = LoaderState.Loading;

  int page = 0, page1 = 0, page2 = 0;

  @override
  void initState() {
    super.initState();

    getScheduleData(page, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        contentView: EasyRefresh(
          header: MaterialHeader(),
          footer: BallPulseFooter(),
          onLoad: () async {
            page1 = page1 + 1;
            page = page1;

            getScheduleData(page, RefreshType.LOAD_MORE);
          },
          onRefresh: () async {
            page2 = page2 - 1;
            page = page2;
            getScheduleData(page, RefreshType.REFRESH);
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (_, index) => StickWidget(
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
                        item: schedule[index].list[itemIndex], isTeam: false),
                    separatorBuilder: (_, __) => Gaps.vGap(1.0),
                    itemCount: schedule[index].list.length)),
            itemCount: schedule.length,
          ),
        ),
        loaderState: state);
  }

  void getScheduleData(int page, RefreshType type) async {
    startDate = formatDateByMs(
        day.millisecondsSinceEpoch + page * 7 * 24 * 60 * 60 * 1000,
        formats: [yyyy, '-', mm, '-', dd]);

    endDate = formatDateByMs(
        day.millisecondsSinceEpoch + (page * 7 + 6) * 24 * 60 * 60 * 1000,
        formats: [yyyy, '-', mm, '-', dd]);

    List<Schedule> list =
        await ApiService.getNBASchedule(startTime: startDate, endTime: endDate);
    if (type == RefreshType.DEFAULT) {
      if (list.length == 0) {
        state = LoaderState.NoData;
      } else {
        state = LoaderState.Succeed;
      }
      schedule.clear();
      schedule.addAll(list);
    } else if (type == RefreshType.LOAD_MORE) {
      if (list.length > 0) {
        schedule.addAll(list);
      }
      state = LoaderState.Succeed;
    } else if (type == RefreshType.REFRESH) {
      if (list.length > 0) {
        schedule.insertAll(0, list);
      }
      state = LoaderState.Succeed;
    }
    if (mounted) {
      setState(() {
        this.page = 0;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
