import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'details.dart';
import 'item_list.dart';

class JuZiMiListPage extends StatefulWidget {
  final String type;

  JuZiMiListPage({Key key, this.type}) : super(key: key);

  @override
  createState() => _JuZiMiListPageState();
}

class _JuZiMiListPageState extends State<JuZiMiListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LoaderState _status = LoaderState.Loading;

  int page = 0;

  bool isLoadComplete = false;

  List<JuZiMi> list = [];

  @override
  void initState() {
    super.initState();

    getJuZiMiDate(widget.type, page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      contentView: EasyRefresh(
          onRefresh: () async {
            page = 0;
            getJuZiMiDate(widget.type, page, RefreshType.REFRESH);
          },
          onLoad: isLoadComplete
              ? null
              : () async {
                  page = page + 1;
                  getJuZiMiDate(widget.type, page, RefreshType.LOAD_MORE);
                },
          child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) => ItemList(
                    item: list[index],
                    onPressed: () => pushNewPage(
                      context,
                      JuZiMiDetails(
                        type: list[index].type,
                        id: list[index].id,
                      ),
                    ),
                  ),
              separatorBuilder: (_, index) => Gaps.vGap5,
              itemCount: list.length)),
      loaderState: _status,
    );
  }

  void getJuZiMiDate(String type, int page, RefreshType refreshType) async {
    List<JuZiMi> _list = await ApiService.getJuZiMiListByType(type, page);

    if (refreshType == RefreshType.DEFAULT ||
        refreshType == RefreshType.REFRESH) {
      list.clear();
      isLoadComplete = false;
    }

    if (page == 0 && _list.length == 0) {
      _status = LoaderState.NoData;
    } else {
      _status = LoaderState.Succeed;
    }

    if (_list.length < 15) {
      isLoadComplete = true;
    }

    list.addAll(_list);

    setState(() {});
  }
}
