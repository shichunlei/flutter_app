import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class BookListsPage extends StatefulWidget {
  final String gender;

  BookListsPage({Key key, this.gender}) : super(key: key);

  @override
  createState() => _BookListsPageState();
}

class _BookListsPageState extends State<BookListsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  LoaderState _status = LoaderState.Loading;

  List<BookList> _booklist = [];

  bool isLoadComplete = false;

  int page = 0;
  int limit = 20;

  int total;

  @override
  void initState() {
    super.initState();

    page = 0;
    getBookList(widget.gender, page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        loaderState: _status,
        contentView: EasyRefresh(
            onRefresh: () async {
              page = 0;
              getBookList(widget.gender, page, RefreshType.REFRESH);
            },
            onLoad: isLoadComplete
                ? null
                : () async {
                    page = page + 1;
                    getBookList(widget.gender, page, RefreshType.LOAD_MORE);
                  },
            child: ListView.separated(
                itemCount: _booklist.length,
                itemBuilder: (_, int position) => ItemBookList(
                    booklist: _booklist[position],
                    onPressed: () => pushNewPage(context,
                        BookListInfoPage(booklistId: _booklist[position]?.id))),
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap3)));
  }

  void getBookList(String gender, int page, RefreshType type) async {
    if (type == RefreshType.DEFAULT || type == RefreshType.REFRESH) {
      _booklist.clear();
      isLoadComplete = false;
    }

    List<BookList> _list = await ApiService.getBookLists(gender,
        start: page * limit, limit: limit);

    if (page == 0 && _list.length == 0) {
      _status = LoaderState.NoData;
    } else {
      _status = LoaderState.Succeed;
    }

    if (_list.length < limit) {
      isLoadComplete = true;
    }

    _booklist.addAll(_list);
    if (mounted) {
      setState(() {});
    }
  }
}
