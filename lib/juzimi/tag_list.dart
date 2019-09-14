import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'details.dart';
import 'item_list.dart';

class JuZiMiTagListPage extends StatefulWidget {
  final int id;

  JuZiMiTagListPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _JuZiMiTagListPageState();
}

class _JuZiMiTagListPageState extends State<JuZiMiTagListPage> {
  LoaderState _status = LoaderState.Loading;

  int page = 0;

  bool isLoadComplete = false;

  List<JuZiMi> list = [];

  @override
  void initState() {
    super.initState();

    getJuZiMiDate(widget.id, page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: ImageLoadView(
              'http://www.cnjxn.com/storage/2019/08/26/pEDsWrvnNU01QVuBQqIqQqc3TaZ8gQZjEFoopOpD.jpeg'),
          centerTitle: true,
        ),
        body: LoaderContainer(
          contentView: EasyRefresh(
              onRefresh: () async {
                page = 0;
                getJuZiMiDate(widget.id, page, RefreshType.REFRESH);
              },
              onLoad: isLoadComplete
                  ? null
                  : () async {
                      page = page + 1;
                      getJuZiMiDate(widget.id, page, RefreshType.LOAD_MORE);
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
        ),
      ),
    );
  }

  void getJuZiMiDate(int id, int page, RefreshType refreshType) async {
    List<JuZiMi> _list = await ApiService.getJuZiMiListByTag(id, page);

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
