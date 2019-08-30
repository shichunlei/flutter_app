import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
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

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isLoadComplete = false;

  int page = 0;
  int limit = 20;

  int total;

  @override
  void initState() {
    super.initState();

    getBookList(widget.gender);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
        loaderState: _status,
        contentView: EasyRefresh(
            refreshFooter: BallPulseFooter(
                key: _footerKey,
                color: readerMainColor,
                backgroundColor: Colors.white),
            loadMore:
                isLoadComplete ? null : () async => getBookList(widget.gender),
            child: ListView.separated(
                itemCount: _booklist.length,
                itemBuilder: (_, int position) => ItemBookList(
                    booklist: _booklist[position],
                    onPressed: () => pushNewPage(context,
                        BookListInfoPage(booklistId: _booklist[position]?.id))),
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap3)));
  }

  void getBookList(String gender) async {
    List<BookList> _list = await ApiService.getBookLists(gender);

    if (_list.length < limit) {
      isLoadComplete = true;
    } else {
      page++;
    }

    _booklist.addAll(_list);

    setState(() {
      _status = LoaderState.Succeed;
    });
  }
}
