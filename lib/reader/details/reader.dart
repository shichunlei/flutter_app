import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

enum ReaderTheme { moon, sun }

class ReaderPage extends StatefulWidget {
  final String link;

  ReaderPage({Key key, @required this.link}) : super(key: key);

  @override
  createState() => _ReaderPageState();
}

class _ReaderPageState extends State<ReaderPage>
    with SingleTickerProviderStateMixin {
  ChapterInfo chapterInfo;

  ScrollController _scrollController;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getChapterInfo(widget.link);
  }

  void getChapterInfo(String link) async {
    chapterInfo = await ApiService.getBookChapterInfo("$link");

    if (chapterInfo.cpContent == '请下载最新的追书神器app阅读本作品。') {
      _status = LoaderState.Failed;
    } else {
      _status = LoaderState.Succeed;
    }

    setState(() {});
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect2<ReaderSettingModel, BookModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot,
            BookModel mBookShelf, Widget child) {
      return Scaffold(
          key: snapshot.scaffoldKey,
          backgroundColor: snapshot.bgColor,
          body: Stack(children: <Widget>[
            /// 内容部分
            buildContentView(),

            /// AppBar
            DetailsAppBarView(title: '${chapterInfo?.title ?? ""}'),

            /// 底部弹窗
            DetailsBottomView()
          ]),
          drawer: Drawer(
              child: Container(
                  padding: EdgeInsets.only(top: 40, bottom: 10),
                  color: snapshot.drawerBgColor,
                  child: Column(children: <Widget>[
                    Text('${mBookShelf.currentBook.title ?? ""}',
                        style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                    Expanded(
                        child: ListView.builder(
                            itemBuilder: (_, index) => ItemChapter(
                                chapter: mBookShelf.chapters[index],
                                checked: mBookShelf.chapterIndex == index &&
                                    !mBookShelf.chapters[index].isVip,
                                onPressed: () {
                                  if (mBookShelf.chapters[index].isVip) {
                                    Toast.show(context, '需要开通VIP才能阅读');
                                  } else {
                                    mBookShelf.updateBook(
                                        mBookShelf.currentBook.id,
                                        chapterIndex: index,
                                        link: mBookShelf.chapters[index].link,
                                        progress:
                                            index / mBookShelf.totalChapter);

                                    setState(() {
                                      _status = LoaderState.Loading;
                                    });
                                    getChapterInfo(
                                        mBookShelf.chapters[index].link);
                                  }
                                  if (snapshot
                                      .scaffoldKey.currentState.isDrawerOpen) {
                                    Navigator.pop(context);
                                  }
                                }),
                            itemCount: mBookShelf.chapters.length))
                  ]))));
    });
  }

  Widget buildContentView() {
    return Store.connect<ReaderSettingModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot, Widget child) {
      return GestureDetector(
        child: LoaderContainer(
            errorTip: '请下载最新的追书神器app阅读本作品。',
            reloadText: '去下载',
            onReload: () {
              /// TODO 跳转到应用市场，下载追书神器APP
            },
            contentView: SingleChildScrollView(
              padding:
                  EdgeInsets.fromLTRB(10, 16 + Utils.topSafeHeight, 10, 10),
              controller: _scrollController,
              child: Column(children: <Widget>[
                Text('${chapterInfo?.title}',
                    style: TextStyle(
                        fontSize: (snapshot.textSize + 2),
                        color: Color(0xFFCD950C))),
                Gaps.vGap15,
                Text('${chapterInfo?.cpContent}',
                    style: TextStyle(
                        fontSize: snapshot.textSize,
                        color: colorGreyA,
                        height: snapshot.spaceValue)),
                Gaps.vGap12,

                /// 底部切换章节的VIEW
                buildRow(),
              ]),
            ),
            loaderState: _status),
        onTap: () => snapshot.changeSettingView(),
      );
    });
  }

  Widget buildRow() {
    return Store.connect<BookModel>(
        builder: (BuildContext context, BookModel snapshot, Widget child) {
      int currentIndex = snapshot.chapterIndex;
      debugPrint('currentIndex==============$currentIndex');

      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Button(
                onPressed: currentIndex == 0
                    ? null
                    : () {
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
                      },
                child: Text("上一章", style: TextStyle(fontSize: 18)),
                width: 100,
                height: 40,
                borderRadius: 20,
                color: readerMainColor,
                disabledColor: readerMainDisColor),
            Button(
                onPressed: snapshot.totalChapter == currentIndex
                    ? null
                    : () {
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
                      },
                child: Text("下一章", style: TextStyle(fontSize: 18)),
                width: 100,
                height: 40,
                borderRadius: 20,
                color: readerMainColor,
                disabledColor: readerMainDisColor)
          ]);
    });
  }
}
