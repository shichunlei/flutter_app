import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';

import '../../page_index.dart';
import '../index.dart';

class ColumnsPage extends StatefulWidget {
  ColumnsPage({Key key}) : super(key: key);

  @override
  createState() => _ColumnsPageState();
}

class _ColumnsPageState extends State<ColumnsPage> {
  String lastKey = '0';

  ResponseBean dataBean;
  List<ColumnBean> columns = [];

  LoaderState _status = LoaderState.Loading;

  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();

    getColumnsData(lastKey, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('栏目中心'), elevation: 0.0),
        body: _buildBodyView());
  }

  void getColumnsData(String lastKey, RefreshType type) async {
    dataBean = await ApiService.getQDailyColumnList(lastKey);
    if (type == RefreshType.DEFAULT || type == RefreshType.REFRESH) {
      columns.clear();
    }

    if (dataBean == null) {
      // 请求失败
      _status = LoaderState.Failed;
    } else {
      this.lastKey = dataBean.lastKey;

      print('${this.lastKey}=============');

      if (type == RefreshType.REFRESH) {
        _controller.resetLoadState();
        _controller.finishRefresh(success: true);
      }
      if (type == RefreshType.LOAD_MORE) {
        _controller.finishLoad(success: true, noMore: !dataBean.hasMore);
      }
      columns.addAll(dataBean.columns);
      if (lastKey == '0' && columns.length == 0) {
        _status = LoaderState.NoData;
      } else {
        _status = LoaderState.Succeed;
      }
    }
    setState(() {});
  }

  Widget _buildBodyView() {
    return LoaderContainer(
      contentView: EasyRefresh(
          controller: _controller,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          taskIndependence: true,
          header: PhoenixHeader(),
          footer: BallPulseFooter(),
          onLoad: () async => getColumnsData(lastKey, RefreshType.LOAD_MORE),
          onRefresh: () async => getColumnsData('0', RefreshType.REFRESH),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => ItemColumn(
                  column: columns[index],
                  onTap: () => pushNewPage(
                      context,
                      SpecialPage(
                          columnId: columns[index].id,
                          image: columns[index].imageLarge,
                          imageTag: 'cloumn-image-${columns[index].id}'))),
              itemCount: columns.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Gaps.vGap5)),
      loaderState: _status,
    );
  }
}
