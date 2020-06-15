import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class PictureBookPage extends StatefulWidget {
  final String major;

  PictureBookPage({Key key, this.major}) : super(key: key);

  @override
  createState() => _PictureBookPageState();
}

class _PictureBookPageState extends State<PictureBookPage>
    with AutomaticKeepAliveClientMixin {
  List<Books> _books = [];

  LoaderState _status = LoaderState.Loading;

  @override
  bool get wantKeepAlive => true;

  bool isLoadComplete = false;

  int page = 0;
  int limit = 21;

  @override
  void initState() {
    super.initState();

    getBooksData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoaderContainer(
        loaderState: _status,
        contentView: EasyRefresh(
            onLoad: isLoadComplete ? null : () async => getBooksData(),
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (_, index) {
                  return ItemPictureBook(
                      book: _books[index],
                      onPressed: () => pushNewPage(
                          context,
                          BookDetailsPage(
                              id: _books[index].id,
                              imageUrl: _books[index].cover)),
                      width: (Utils.width - 20) / 3);
                },
                itemCount: _books.length,
                physics: NeverScrollableScrollPhysics())));
  }

  void getBooksData() async {
    List<Books> _list = await ApiService.getBookByCategories(
        'picture', widget.major,
        start: page * limit, limit: limit);

    if (_list.length < limit) {
      isLoadComplete = true;
    } else {
      page++;
    }

    _books.addAll(_list);

    if (mounted) {
      setState(() {
        _status = LoaderState.Succeed;
      });
    }
  }
}
