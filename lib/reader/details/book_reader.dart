import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class BookReaderPage extends StatefulWidget {
  final String link;

  BookReaderPage({Key key, @required this.link}) : super(key: key);

  @override
  createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  ChapterInfo chapterInfo;

  LoaderState _status = LoaderState.Loading;

  int _currentPage = 0;

  double offsetX = 0.0;

  final screenWidth = Utils.width;

  @override
  void initState() {
    super.initState();

    getChapterInfo(widget.link);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<BookModel>(
        builder: (BuildContext context, BookModel snapshot, Widget child) {
      // 章节索引
      int currentIndex = snapshot.chapterIndex;
      debugPrint('currentIndex==============$currentIndex');

      return Scaffold(
        backgroundColor: colorMintCream,
        body: LoaderContainer(
          contentView: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: stringAtPageIndex(_currentPage),
                      style: TextStyle(fontSize: 18.0, color: Colors.black))
                ]),
                textAlign: TextAlign.justify,
              ),
            ),
            onHorizontalDragStart: (DragStartDetails details) {
              debugPrint('onHorizontalDragStart==============$details');
              setState(() {
                offsetX = 0.0;
              });
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                offsetX = details.delta.dx;
              });
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (offsetX > 0.0) {
                debugPrint('onHorizontalDragEnd================>0.0');
                if (_currentPage == 0) {
                  if (currentIndex == 0) {
                    // 这是第一章，前面没有章节了
                    Toast.show(context, '这是第一章，前面没有章节了');
                    print('这是第一章，前面没有章节了');
                  } else {
                    // 不是第一章，请求前一章内容
                    int _index = currentIndex - 1;
                    currentIndex = _index;
                    snapshot.updateBook(snapshot.currentBook.id,
                        chapterIndex: _index,
                        link: snapshot.chapters[_index].link,
                        progress: _index / snapshot.chapters.length);

                    debugPrint('currentIndex=======-----=======$_index');
                    setState(() {
                      _status = LoaderState.Loading;
                    });
                    getChapterInfo(snapshot.chapters[_index].link);
                  }
                } else {
                  // 上一页内容
                  setState(() {
                    _currentPage = _currentPage - 1;
                  });
                }
              } else if (offsetX < 0.0) {
                if (_currentPage == pageCount - 1) {
                  // 本章最后一页了
                  if (currentIndex == snapshot.totalChapter) {
                    // 本书最后一章了，后面没有章节了
                    Toast.show(context, '本书最后一章了，后面没有章节了');
                    print('本书最后一章了，后面没有章节了');
                  } else {
                    // 请求下一章节内容
                    int _index = currentIndex + 1;
                    if (snapshot.chapters[_index].isVip) {
                      Toast.show(context, 'VIP章节需要付费阅读');
                    } else {
                      currentIndex = _index;

                      debugPrint(
                          'currentIndex=======+++++=======$currentIndex');
                      snapshot.updateBook(snapshot.currentBook.id,
                          chapterIndex: _index,
                          link: snapshot.chapters[_index].link,
                          progress: _index / snapshot.chapters.length);

                      setState(() {
                        _status = LoaderState.Loading;
                      });
                      getChapterInfo(snapshot.chapters[_index].link);
                    }
                  }
                } else {
                  // 下一页内容
                  setState(() {
                    _currentPage = _currentPage + 1;
                  });
                }
                debugPrint('onHorizontalDragEnd================<0.0');
              }
              debugPrint('onHorizontalDragEnd================$details');
            },
          ),
          loaderState: _status,
        ),
      );
    });
  }

  void getChapterInfo(String link) async {
    chapterInfo = await ApiService.getBookChapterInfo("$link");

    if (chapterInfo.cpContent == '请下载最新的追书神器app阅读本作品。') {
      _status = LoaderState.Failed;
    } else {
      _status = LoaderState.Succeed;
    }

    setState(() {
      _currentPage = 0;
    });
  }

  String stringAtPageIndex(int index) {
    if (chapterInfo == null) {
      return "";
    }
    var offset = chapterInfo?.pageOffsets[index];
    return chapterInfo.cpContent.substring(offset['start'], offset['end']);
  }

  // 获取该章节一共分为多少页
  int get pageCount => chapterInfo == null ? 0 : chapterInfo.pageOffsets.length;
}
