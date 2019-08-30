import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ChaptersPage extends StatefulWidget {
  final String id;
  final String name;
  final int readingChapterIndex;

  ChaptersPage(
      {Key key, @required this.id, this.name, this.readingChapterIndex: 0})
      : super(key: key);

  @override
  createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage>
    with SingleTickerProviderStateMixin {
  LoaderState _status = LoaderState.Loading;

  List<Chapters> chapters = [];

  ScrollController _scrollController;

  int checkIndex = 0;

  Timer _timer;

  bool _isVisible = true;

  IconData _sIcon = Icons.arrow_upward;

  @override
  void initState() {
    super.initState();
    checkIndex = widget.readingChapterIndex;

    _scrollController = ScrollController();

    Store.connect<BookModel>(builder: (_, BookModel snapshot, __) {
      _scrollController.addListener(() {
        if (_scrollController.offset ==
            snapshot.chapterIndex * Dimens.chapterItemHeight) {
          _isVisible = false;
        } else {
          if (_scrollController.offset >
              snapshot.chapterIndex * Dimens.chapterItemHeight) {
            _sIcon = Icons.arrow_upward;
          } else if (_scrollController.offset <
              snapshot.chapterIndex * Dimens.chapterItemHeight) {
            _sIcon = Icons.arrow_downward;
          }
          _isVisible = true;
        }

        setState(() {});
      });
    });

    getBookChapters(widget.id);
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            brightness: Brightness.light,
            title:
                Text('${widget.name}', style: TextStyle(color: Colors.black54)),
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: lightIconTheme),
        body: LoaderContainer(
            contentView:
                Store.connect<BookModel>(builder: (_, BookModel snapshot, __) {
              return ListView.separated(
                  padding: EdgeInsets.only(top: 3),
                  controller: _scrollController,
                  itemBuilder: (_, index) => ItemChapter(
                      chapter: chapters[index],
                      checked: snapshot.chapterIndex == index &&
                          !chapters[index].isVip,
                      onPressed: () {
                        if (chapters[index].isVip) {
                          Toast.show(context, '需要开通VIP才能阅读');
                        } else {
                          snapshot.updateBook(widget.id,
                              chapterIndex: index,
                              link: chapters[index].link,
                              progress: index / chapters.length,
                              totalChapter: chapters.length);

                          pushNewPage(
                              context, ReaderPage(link: chapters[index].link));
                        }
                      }),
                  itemCount: chapters.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.line);
            }),
            loaderState: _status),
        floatingActionButton: Opacity(
            child: FloatingActionButton(
                onPressed: () =>
                    animateTo(Store.value<BookModel>(context).chapterIndex),
                mini: true,
                child: Icon(_sIcon),
                backgroundColor: readerMainColor),
            opacity: _isVisible ? 1.0 : 0.0));
  }

  void getBookChapters(String id) async {
    BtocResult result = await ApiService.getBookBtocSource(id);
    if (result != null) {
      chapters = await ApiService.getBookChapters(result.id);

      setState(() {
        _status = LoaderState.Succeed;
      });
      animateTo(checkIndex);
    }
  }

  void animateTo(int index) {
    _timer = Timer(Duration(milliseconds: 300), () {
      _scrollController.animateTo(index * Dimens.chapterItemHeight,
          duration: Duration(seconds: 1), curve: Curves.ease);
    });
  }
}
