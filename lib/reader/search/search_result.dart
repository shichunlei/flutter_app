import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class SearchResultPage extends StatefulWidget {
  final String keyword;

  SearchResultPage({Key key, this.keyword}) : super(key: key);

  @override
  createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  LoaderState _status = LoaderState.NoAction;

  List<Books> _books = [];

  int page = 0;
  int limit = 20;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    search(widget.keyword);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          appBar: AppBar(
              title: Text('跟“${widget.keyword}“有关的书籍',
                  style: TextStyle(color: Colors.black54))),
          body: LoaderContainer(
              contentView: EasyRefresh(
                  onLoad: isLoadComplete
                      ? null
                      : () async => search(widget.keyword),
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 3),
                      itemBuilder: (_, index) => ItemBook(
                          book: _books[index],
                          onPressed: () => pushNewPage(
                              context,
                              BookDetailsPage(
                                  id: _books[index].id,
                                  imageUrl: _books[index].cover))),
                      itemCount: _books.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Gaps.vGap3)),
              loaderState: _status)),
    );
  }

  void search(String query) async {
    List<Books> list = await ApiService.getSearchBook(query,
        start: (page * limit) + 1, limit: limit);

    if (list.length < limit) {
      isLoadComplete = true;
    }
    page++;
    _books.addAll(list);

    if (_books.length == 0) {
      _status = LoaderState.NoData;
    } else {
      _status = LoaderState.Succeed;
    }

    setState(() {});
  }
}
