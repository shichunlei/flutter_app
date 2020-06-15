import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

enum PageJumpType { stay, firstPage, lastPage }

class BookReaderPage extends StatefulWidget {
  final String link;

  BookReaderPage({Key key, @required this.link}) : super(key: key);

  @override
  createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ChapterInfo chapterInfo;

  LoaderState _status = LoaderState.Loading;

  int _currentPage = 0;

  double offsetX = 0.0;

  bool isMenuVisible = false;

  /// 标题栏+状态栏高度
  double navigationBarHeight = Utils.navigationBarHeight;

  /// 状态栏高度
  double topSafeHeight = Utils.topSafeHeight;

  Brightness brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    Utils.statusBarEnable(false);

    getChapterInfo(widget.link, PageJumpType.stay);
  }

  @override
  void deactivate() {
    Utils.statusBarEnable(true);
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Utils.statusBarEnable(isMenuVisible);

    return Theme(
      data: ThemeData(brightness: brightness),
      child: Scaffold(
        key: _scaffoldKey,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          /// 设置状态栏字体颜色
          value: brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: LoaderContainer(
            contentView: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                IndexedStack(
                  sizing: StackFit.expand,
                  children: chapterInfo == null
                      ? <Widget>[]
                      : chapterInfo.pageOffsets.map((item) {
                          return GestureDetector(
                            child: Container(
                              height: Utils.height,
                              width: Utils.width,
                              padding: EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                  top: Utils.topSafeHeight),
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: stringAtPageIndex(_currentPage),
                                      style: TextStyle(fontSize: 18.0))
                                ]),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            onTapUp: (TapUpDetails details) {
                              if (isMenuVisible) {
                                setState(() {
                                  isMenuVisible = !isMenuVisible;
                                });
                              } else {
                                if (details.localPosition.dx / Utils.width >
                                    0.5) {
                                  nextPage();
                                } else {
                                  previousPage();
                                }
                              }
                            },
                            onDoubleTap: () {
                              // 双击弹出菜单
                              debugPrint('弹出菜单');
                              setState(() {
                                isMenuVisible = !isMenuVisible;
                              });
                            },
                            onHorizontalDragStart: (DragStartDetails details) {
                              setState(() {
                                offsetX = 0.0;
                              });
                            },
                            onHorizontalDragUpdate:
                                (DragUpdateDetails details) {
                              setState(() {
                                offsetX = details.delta.dx;
                              });
                            },
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (offsetX > 0.0) {
                                debugPrint(
                                    'onHorizontalDragEnd================前一页/章');
                                previousPage();
                              } else if (offsetX < 0.0) {
                                nextPage();
                                debugPrint(
                                    'onHorizontalDragEnd================后一页/章');
                              }
                            },
                          );
                        }).toList(),
                  index: _currentPage,
                ),
                // 标题栏+状态栏
                Positioned(
                  child: Material(
                    elevation: 10.0,
                    child: Container(
                      height: navigationBarHeight,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Utils.isIOS
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${chapterInfo?.title}',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_horiz),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(5, topSafeHeight, 5, 0),
                    ),
                  ),
                  left: 0,
                  right: 0,
                  top: isMenuVisible ? 0 : -navigationBarHeight,
                ),
                // 底部菜单
                Positioned(
                  child: Material(
                    child: Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.list),
                                onPressed: () {
                                  setState(() {
                                    isMenuVisible = false;
                                    if (!_scaffoldKey
                                        .currentState.isDrawerOpen) {
                                      _scaffoldKey.currentState.openDrawer();
                                    }
                                  });
                                }),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(brightness == Brightness.light
                                    ? Icons.brightness_2
                                    : Icons.wb_sunny),
                                onPressed: () {
                                  setState(() {
                                    if (brightness == Brightness.dark) {
                                      brightness = Brightness.light;
                                    } else {
                                      brightness = Brightness.dark;
                                    }
                                    // isMenuVisible = false;
                                  });
                                }),
                          ),
                          Expanded(
                            child: Store.connect<BookModel>(builder:
                                (BuildContext context, BookModel snapshot,
                                    Widget child) {
                              return IconButton(
                                  icon: Icon(snapshot.isExist
                                      ? Icons.bookmark
                                      : Icons.bookmark_border),
                                  onPressed: () {
                                    if (snapshot.isExist) {
                                      /// 不追了，在书架删除
                                      snapshot.deleteBook(
                                          context, snapshot.currentBook.id);
                                    } else {
                                      /// 加追，在书架添加该书
                                      Books _book = Books(
                                          id: snapshot.currentBook.id,
                                          title: snapshot.currentBook.title,
                                          cover: snapshot.currentBook.cover,
                                          progress:
                                              (snapshot.chapterIndex + 1) /
                                                  snapshot.totalChapter,
                                          offset: 0.0,
                                          chapterIndex: snapshot.chapterIndex,
                                          totalChapter: snapshot.totalChapter,
                                          chapterLink: snapshot
                                              .chapters[snapshot.chapterIndex]
                                              ?.link);

                                      snapshot.insertOrReplaceToDB(
                                          context, _book);
                                    }
                                    // isMenuVisible = false;
                                  });
                            }),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.settings),
                                onPressed: () {
                                  setState(() {
                                    isMenuVisible = false;
                                  });
                                }),
                          ),
                          Expanded(
                            child: IconButton(
                                icon: Icon(Icons.file_download),
                                onPressed: () {
                                  setState(() {
                                    isMenuVisible = false;
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                    elevation: 10.0,
                  ),
                  left: 0,
                  right: 0,
                  bottom: isMenuVisible ? 0 : -120,
                )
              ],
            ),
            loaderState: _status,
          ),
        ),
        drawer: Drawer(
          child: Store.connect<BookModel>(builder:
              (BuildContext context, BookModel snapshot, Widget child) {
            return ListView.builder(
              itemBuilder: (_, index) {
                return ItemChapter(
                  checked: index == snapshot.chapterIndex,
                  chapter: snapshot.chapters[index],
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _status = LoaderState.Loading;
                    });
                    getChapterInfo(
                        snapshot.chapters[index].link, PageJumpType.stay);
                  },
                );
              },
              itemCount: snapshot.chapters.length,
              padding: EdgeInsets.only(top: topSafeHeight),
            );
          }),
        ),
      ),
    );
  }

  void getChapterInfo(String link, PageJumpType type) async {
    chapterInfo = await ApiService.getBookChapterInfo("$link");

    if (chapterInfo?.cpContent == '请下载最新的追书神器app阅读本作品。') {
      _status = LoaderState.Failed;
    } else {
      _status = LoaderState.Succeed;
    }

    setState(() {
      if (type == PageJumpType.firstPage) {
        _currentPage = 0;
      } else if (type == PageJumpType.lastPage) {
        _currentPage = pageCount - 1;
      } else {
        _currentPage = 0;
      }
    });
  }

  // 下一章
  void nextChapter() {
    var snapshot = Store.value<BookModel>(context);
    int currentChapterIndex = snapshot.chapterIndex;
    debugPrint('======第${currentChapterIndex + 1}章');
    if (currentChapterIndex + 1 == snapshot.totalChapter) {
      // 本书最后一章了，后面没有章节了
      Toast.show(context, '本书最后一章了，后面没有章节了');
      debugPrint('本书最后一章了，后面没有章节了');
    } else {
      // 请求下一章节内容
      int _index = currentChapterIndex + 1;
      if (snapshot.chapters[_index].isVip) {
        Toast.show(context, 'VIP章节需要付费阅读');
      } else {
        snapshot.updateBook(snapshot.currentBook.id,
            chapterIndex: _index,
            link: snapshot.chapters[_index].link,
            progress: _index / snapshot.chapters.length);

        setState(() {
          _status = LoaderState.Loading;
        });
        getChapterInfo(snapshot.chapters[_index].link, PageJumpType.firstPage);
      }
    }
  }

  // 上一章
  void previousChapter() {
    var snapshot = Store.value<BookModel>(context);
    int currentChapterIndex = snapshot.chapterIndex;
    debugPrint('======第${currentChapterIndex + 1}章');
    if (currentChapterIndex == 0) {
      // 这是第一章，前面没有章节了
      Toast.show(context, '这是第一章，前面没有章节了');
    } else {
      // 不是第一章，请求前一章内容
      int _index = currentChapterIndex - 1;
      snapshot.updateBook(snapshot.currentBook.id,
          chapterIndex: _index,
          link: snapshot.chapters[_index].link,
          progress: _index / snapshot.chapters.length);

      setState(() {
        _status = LoaderState.Loading;
      });
      getChapterInfo(snapshot.chapters[_index].link, PageJumpType.lastPage);
    }
  }

  // 下一页
  void nextPage() {
    if (_currentPage == pageCount - 1) {
      // 本章最后一页了
      nextChapter();
    } else {
      // 下一页内容
      setState(() {
        _currentPage++;
        debugPrint('======第${_currentPage + 1}页');
      });
    }
  }

  // 上一页
  void previousPage() {
    if (_currentPage == 0) {
      // 本章第一页
      previousChapter();
    } else {
      // 上一页内容
      setState(() {
        _currentPage--;
        debugPrint('======第${_currentPage + 1}页');
      });
    }
  }

  String stringAtPageIndex(int index) {
    if (chapterInfo == null) {
      return "";
    }
    var offset = chapterInfo?.pageOffsets[index];
    var content =
        chapterInfo.cpContent.substring(offset['start'], offset['end']);

    return content;
  }

  // 获取该章节一共分为多少页
  int get pageCount => chapterInfo == null ? 0 : chapterInfo.pageOffsets.length;
}
