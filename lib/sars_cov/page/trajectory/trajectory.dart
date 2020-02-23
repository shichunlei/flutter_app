import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import '../../../page_index.dart';
import 'ui/area_choice_view.dart';
import 'ui/item_trajectory.dart';

class TrajectoryPage extends StatefulWidget {
  TrajectoryPage({Key key}) : super(key: key);

  @override
  createState() => _TrajectoryPageState();
}

class _TrajectoryPageState extends State<TrajectoryPage> {
  ScrollController controller;

  double opacity = 0.0;
  double expandedHeight;

  int page = 1;
  int num = 10;

  bool isLoadComplete = false;

  String province = '';
  String city = '';
  String county = '';

  List<Trajectory> trajectories = [];

  LoaderState state = LoaderState.Loading;

  String lastTime = '';

  @override
  void initState() {
    super.initState();

    expandedHeight = Utils.width / 750 * 268 - Utils.topSafeHeight;

    controller = ScrollController()
      ..addListener(() {
        var offset = controller.offset;
        print(offset);
        if (offset < 0) {
          if (opacity != 0) setState(() => opacity = 0);
        } else if (offset < expandedHeight && offset >= 0) {
          setState(
              () => opacity = 1 - (expandedHeight - offset) / expandedHeight);
        } else {
          if (opacity != 1) setState(() => opacity = 1);
        }
      });

    getSARSCovTrajectoryData(RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        contentView: EasyRefresh.custom(
          scrollController: controller,
          footer: BallPulseFooter(),
          header: MaterialHeader(),
          onRefresh: () async {
            page = 1;
            getSARSCovTrajectoryData(RefreshType.REFRESH);
          },
          onLoad: isLoadComplete
              ? null
              : () async {
                  page++;
                  getSARSCovTrajectoryData(RefreshType.LOAD_MORE);
                },
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              title: Text(
                '确诊病患活动轨迹速查',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, opacity)),
              ),
              expandedHeight: expandedHeight,
              backgroundColor: Color(0xff291747),
              flexibleSpace: FlexibleSpaceBar(
                background: ImageLoadView(
                  'https://mat1.gtimg.com/rain/bailing20/857b3f7a97c6.banner.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: AreaChoiceView(),
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text('数据更新时间：$lastTime'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ItemTrajectory(item: trajectories[index]),
                childCount: trajectories.length,
              ),
            ),
          ],
        ),
        loaderState: state,
      ),
    );
  }

  void getSARSCovTrajectoryData(RefreshType refreshType) async {
    if (refreshType != RefreshType.LOAD_MORE) {
      trajectories.clear();
      isLoadComplete = false;
    }

    List<Trajectory> list = await ApiService.getSARSCovTrajectoryData(
        province: province, city: city, county: county, page: page, num: num);

    if (list.length < num) {
      debugPrint('加载完成。。。');
      isLoadComplete = true;
    }
    trajectories.addAll(list);

    lastTime = trajectories.first.lastTime;

    if (mounted)
      setState(() {
        state = LoaderState.Succeed;
      });
  }
}
