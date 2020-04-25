import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class BookListInfoPage extends StatefulWidget {
  final String booklistId;

  BookListInfoPage({Key key, this.booklistId}) : super(key: key);

  @override
  createState() => _BookListInfoPageState();
}

class _BookListInfoPageState extends State<BookListInfoPage> {
  LoaderState _status = LoaderState.Loading;

  BookList booklist;

  List<Books> _books = [];

  Map<String, List<Books>> _booksMap = Map();

  String _selectedMaterial = '';

  @override
  void initState() {
    super.initState();

    getBookListInfo(widget.booklistId);
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
              title: Text('书单详情', style: TextStyle(color: Colors.black54))),
          body: LoaderContainer(
              contentView: SingleChildScrollView(
                child: Column(children: <Widget>[
                  /// 书单信息
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Column(children: <Widget>[
                        Text('${booklist?.title}',
                            style: TextStyles.textDark16),
                        Gaps.vGap5,
                        Wrap(
                            spacing: 5,
                            children: booklist != null
                                ? booklist.tags
                                    .map((tag) => TagView(
                                          tag: '$tag',
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          bgColor: Utils.strToColor(tag),
                                          textColor: Colors.white,
                                        ))
                                    .toList()
                                : []),
                        Gaps.vGap5,
                        Text('${booklist?.desc}', style: TextStyles.textGrey14),
                        Gaps.vGap5,
                        Row(children: <Widget>[
                          ImageLoadView('${booklist?.author?.avatar}',
                              width: 35, height: 35, shape: BoxShape.circle),
                          Gaps.hGap5,
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text('${booklist?.author?.nickname}',
                                      style: TextStyles.textGrey12),
                                  Gaps.hGap5,
                                  TagView(tag: 'lv.${booklist?.author?.lv}')
                                ]),
                                Text('创建于${booklist?.created}',
                                    style: TextStyles.textGreyC12)
                              ])
                        ]),
                      ], crossAxisAlignment: CrossAxisAlignment.start)),
                  Gaps.vGap8,

                  /// 书单书籍
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.white,
                      width: double.infinity,
                      child: Wrap(children: _buildTab(), spacing: 5)),
                  Gaps.vGap8,

                  ListView.separated(
                      itemBuilder: (_, index) => ItemBookListBook(
                          book: _books[index],
                          onPressed: () => pushNewPage(
                              context,
                              BookDetailsPage(
                                  id: _books[index].book.id,
                                  imageUrl: _books[index].book.cover))),
                      itemCount: _books.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      separatorBuilder: (context, index) => Gaps.vGap3)
                ], crossAxisAlignment: CrossAxisAlignment.start),
              ),
              loaderState: _status)),
    );
  }

  void getBookListInfo(String booklistId) async {
    booklist = await ApiService.getBookListInfo(booklistId);

    List<Books> books = booklist.books;

    _books = books;

    _booksMap["全部(${books.length})"] = booklist.books;

    _selectedMaterial = "全部(${books.length})";

    List<String> keys = [];
    books.forEach((book) {
      debugPrint('=========${book.book.majorCate}');
      if (!keys.contains(book.book.majorCate)) {
        keys.add(book.book.majorCate);
      }
    });

    debugPrint('=========${keys.toString()}');

    keys.forEach((key) {
      debugPrint('========$key');
      List<Books> _list = [];
      books.forEach((book) {
        if (book.book.majorCate == key) {
          _list.add(book);
        }
      });

      if (_list.length > 2) {
        _booksMap["$key(${_list.length})"] = _list;
      }
    });

    setState(() {
      _status = LoaderState.Succeed;
    });
  }

  List<Widget> _buildTab() {
    List<Widget> widgets = [];

    if (_booksMap.isNotEmpty) {
      _booksMap.forEach((key, value) {
        widgets.add(ChoiceChip(
            elevation: 0,
            label: Text('$key'),
            onSelected: (bool isChoice) {
              if (isChoice) {
                setState(() {
                  _selectedMaterial = key;

                  _books = _booksMap[_selectedMaterial];
                });
              }
            },
            selected: _selectedMaterial == key));
      });
    }
    return widgets;
  }
}
