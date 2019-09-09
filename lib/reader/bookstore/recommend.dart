import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class RecommendPage extends StatefulWidget {
  final String major;
  final String gender;

  RecommendPage({Key key, this.major, this.gender}) : super(key: key);

  @override
  createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  List<Books> _books = [];
  LoaderState _status = LoaderState.Loading;

  bool isLoadComplete = false;

  int page = 0;
  int limit = 20;

  @override
  void initState() {
    super.initState();

    getBooksData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
        contentView: EasyRefresh(
            onLoad: isLoadComplete ? null : () async => getBooksData(),
            child: ListView.separated(
                itemBuilder: (_, int position) => ItemBook(
                    book: _books[position],
                    onPressed: () => pushNewPage(
                        context,
                        BookDetailsPage(
                            id: _books[position].id,
                            imageUrl: _books[position].cover))),
                itemCount: _books.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap3)),
        loaderState: _status);
  }

  void getBooksData() async {
    List<Books> _list = await ApiService.getBookByCategories(
        widget.gender, widget.major,
        start: page * limit, limit: limit);

    if (_list.length < limit) {
      isLoadComplete = true;
    } else {
      page++;
    }

    _books.addAll(_list);

    setState(() {
      _status = LoaderState.Succeed;
    });
  }
}
