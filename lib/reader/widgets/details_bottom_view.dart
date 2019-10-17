import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../index.dart';

class DetailsBottomView extends StatelessWidget {
  DetailsBottomView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Store.connect2<ReaderSettingModel, BookModel>(builder:
        (BuildContext context, ReaderSettingModel snapshot,
            BookModel mBookShelf, Widget child) {
      return Positioned(
          child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              height: snapshot.bottomBarHeight,
              color: Color(0xFA303030),
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /// 字号调整
                        ChangeTextSizeView(),
                        Gaps.vGap10,

                        /// 行间距调整
                        ChangeTextSpaceView(),
                        Gaps.vGap20,

                        /// 设置
                        buildSettingButton(context, snapshot, mBookShelf)
                      ],
                    )),
              ),
              width: double.infinity),
          bottom: 0,
          left: 0,
          right: 0);
    });
  }

  Widget buildSettingButton(
      BuildContext context, ReaderSettingModel snapshot, BookModel mBookShelf) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.list, color: Colors.white),
              onPressed: () {
                snapshot.hiddenSettingView();
                snapshot.scaffoldKey.currentState.openDrawer();
              }),
          IconButton(
              icon: Icon(snapshot.themeIcon, color: Colors.white),
              onPressed: () => snapshot.changeTheme()),
          IconButton(
              icon: Icon(Feather.bookmark, color: Colors.white),
              onPressed: () async {
                snapshot.hiddenSettingView();

                if (mBookShelf.isExist) {
                  Toast.show(context, '已经加入书架了');
                } else {
                  Books _book = Books(
                      id: mBookShelf.currentBook.id,
                      title: mBookShelf.currentBook.title,
                      cover: mBookShelf.currentBook.cover,
                      progress:
                          mBookShelf.chapterIndex / mBookShelf.totalChapter,
                      offset: 0.0,
                      chapterIndex: mBookShelf.chapterIndex,
                      totalChapter: mBookShelf.totalChapter,
                      chapterLink:
                          mBookShelf.chapters[mBookShelf.chapterIndex].link);

                  mBookShelf.insertOrReplaceToDB(context, _book);
                }
              }),
          IconButton(
              icon: Icon(Feather.settings, color: Colors.white),
              onPressed: () {
                snapshot.hiddenSettingView();
              }),
          IconButton(
              icon: Icon(Feather.download, color: Colors.white),
              onPressed: () {
                snapshot.hiddenSettingView();
              })
        ]);
  }
}
