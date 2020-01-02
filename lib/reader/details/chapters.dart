import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ChaptersPage extends StatefulWidget {
  final String name;

  ChaptersPage({Key key, @required this.name}) : super(key: key);

  @override
  createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage>
    with SingleTickerProviderStateMixin {
  LoaderState _status = LoaderState.Loading;

  List<Chapters> chapters = [];

  ScrollController _scrollController;

  Timer _timer;

  bool _isVisible = false;

  IconData _sIcon = Icons.arrow_upward;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      final state = Store.value<BookModel>(context, listen: false);

      var chapterIndex = state.chapterIndex;

      _scrollController.addListener(() {
        if (_scrollController.offset ==
            chapterIndex * Dimens.chapterItemHeight) {
          _isVisible = false;
        } else {
          if (_scrollController.offset >
              chapterIndex * Dimens.chapterItemHeight) {
            _sIcon = Icons.arrow_upward;
          } else if (_scrollController.offset <
              chapterIndex * Dimens.chapterItemHeight) {
            _sIcon = Icons.arrow_downward;
          }
          _isVisible = true;
        }

        setState(() {});
      });

      chapters = state.chapters;

      if (chapters.length > 0) {
        setState(() {
          _status = LoaderState.Succeed;
        });
        animateTo(chapterIndex);
      } else {
        setState(() {
          _status = LoaderState.NoData;
        });
      }
    });
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
    return LightTheme(
      child: Scaffold(
        appBar: AppBar(
            title: Text('${widget.name}',
                style: TextStyle(color: Colors.black54))),
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
                          snapshot.updateBook(snapshot.currentBook.id,
                              chapterIndex: index,
                              link: chapters[index].link,
                              progress: index / chapters.length,
                              totalChapter: chapters.length);

                          pushNewPage(context,
                              BookReaderPage(link: chapters[index].link));
                        }
                      }),
                  itemCount: chapters.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.line);
            }),
            loaderState: _status),
        floatingActionButton: Opacity(
            child: FloatingActionButton(
                onPressed: () => animateTo(
                    Store.value<BookModel>(context, listen: false)
                        .chapterIndex),
                mini: true,
                child: Icon(_sIcon, color: Colors.white),
                backgroundColor: readerMainColor),
            opacity: _isVisible ? 1.0 : 0.0),
      ),
    );
  }

  void animateTo(int index) {
    _timer = Timer(Duration(milliseconds: 300), () {
      _scrollController.animateTo(index * Dimens.chapterItemHeight,
          duration: Duration(seconds: 1), curve: Curves.ease);
    });
  }
}
