import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/utils/date_format.dart';

import '../../page_index.dart';
import '../index.dart';

class BookDetailsPage extends StatefulWidget {
  final String id;
  final String imageUrl;

  BookDetailsPage({Key key, @required this.id, this.imageUrl})
      : super(key: key);

  @override
  createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  Color pageTopColorStart = readerMainColor;
  Color pageTopColorEnd = Color(0xff35374c);

  ScrollController _controller = ScrollController();

  /// 透明度 取值范围[0,1]
  double navAlpha = 0;

  Books book;

  /// 书评
  List<BookReviews> reviews = [];

  /// 书评总数
  int reviewsCount = 0;

  /// 短评
  List<DocsBean> docs = [];

  List<Books> interestedBooks = [];

  /// 页面状态
  LoaderState _status = LoaderState.Loading;

  BookShelfDBHelper bdHelper;

  String readerText = '开始阅读';

  @override
  void initState() {
    super.initState();

    bdHelper = BookShelfDBHelper();

    initPageTopColor();

    _controller.addListener(() {
      var offset = _controller.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 280) {
        setState(() {
          navAlpha = 1 - (280 - offset) / 280;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });

    getBookDetails(widget.id);
  }

  void initPageTopColor() async {
    pageTopColorStart = await Utils.getImageLightVibrantColor(widget.imageUrl,
        defaultColor: Color(0xff333712));

    pageTopColorEnd = await Utils.getImageDarkMutedColor(widget.imageUrl,
        defaultColor: Color(0xff35374c));

    setState(() {});
  }

  void getBookDetails(String id) async {
    book = await ApiService.getBookDetails(id);

    BookResult result = await ApiService.getBookReview(id, limit: 3);
    reviews = result.reviews;

    reviewsCount = result.total;

    docs = await ApiService.getBookShortReview(id, limit: 2);

    interestedBooks = await ApiService.getBookByRecommend(id);

    final state = Store.value<BookModel>(context);

    state
      ..updateIsExist(id)
      ..getChapters(id);

    if (state.isExist) {
      readerText = '继续阅读';
    }

    setState(() {
      _status = LoaderState.Succeed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          LoaderContainer(
              contentView: Column(children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    padding: EdgeInsets.zero,
                    child: Column(children: <Widget>[
                      /// 头部
                      BookDetailsHeaderView(
                          pageTopColorStart: pageTopColorStart,
                          pageTopColorEnd: pageTopColorEnd,
                          book: book),

                      /// 简介
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          child: Column(children: <Widget>[
                            Text('简介',
                                style:
                                    TextStyle(fontSize: 22, color: grey3Color)),
                            Gaps.vGap5,

                            /// 标签
                            Wrap(
                              children: tags(),
                              spacing: 5,
                              runSpacing: 3,
                            ),
                            Gaps.vGap5,
                            Text('${book?.longIntro}',
                                style: TextStyles.textGrey14),
                          ], crossAxisAlignment: CrossAxisAlignment.start)),

                      /// 目录
                      SelectTextItem(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          title: '目录\t\t\t\t',
                          content:
                              '[${book != null ? (book.isSerial ? "更新:${friendlyDateTime(book?.updated)}" : "完结") : ""}]\t${book?.lastChapter}',
                          onTap: () {
                            final state = Store.value<BookModel>(context);
                            int readingChapterIndex = 0;
                            if (state.isExist) {
                              readingChapterIndex = state.chapterIndex;
                            }
                            state.setBook(book);
                            pushNewPage(
                                context,
                                ChaptersPage(
                                    id: widget.id,
                                    name: book?.title,
                                    readingChapterIndex: readingChapterIndex));
                          }),

                      Line(lineHeight: 5, color: Colors.grey[200]),

                      /// 热门短评
                      DetailsDocView(
                          docs: docs, id: widget.id, onPressed: () {}),

                      Line(lineHeight: 5, color: Colors.grey[200]),

                      /// 热门书评
                      DetailsReviewView(
                          reviews: reviews,
                          id: widget.id,
                          reviewsCount: reviewsCount,
                          onPressed: () {}),

                      Line(lineHeight: 5, color: Colors.grey[200]),

                      /// 你可能感兴趣的
                      DetailsInterestedView(
                          books: interestedBooks, onPressed: () {}),

                      /// 包含本书的书单

                      Line(lineHeight: 5, color: Colors.grey[200]),

                      /// 版权声明
                      Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text('${book?.copyrightDesc}',
                              style: TextStyles.textGrey16)),

                      Line(lineHeight: 5, color: Colors.grey[200])
                    ]),
                  ),
                ),

                /// 底部
                buildBottomView()
              ]),
              loaderState: _status),
          Container(
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Color.fromARGB(
                  (navAlpha * 255).toInt(),
                  pageTopColorStart.red,
                  pageTopColorStart.green,
                  pageTopColorStart.blue,
                ),
                title: Text(
                  '${book?.title}',
                ),
              ),
              height: Utils.navigationBarHeight)
        ]));
  }

  Widget buildBottomView() {
    return Store.connect<BookModel>(builder: (_, BookModel snapshot, __) {
      return Container(
          height: 50.0,
          child: Row(children: <Widget>[
            /// 添加到书架/从暑假删除按钮
            Expanded(
                child: Material(
                    color: Colors.white,
                    child: InkWell(
                        onTap: () {
                          if (snapshot.isExist) {
                            /// 不追了，在书架删除
                            snapshot.deleteBook(context, widget.id);
                          } else {
                            /// 加追，在书架添加该书
                            Books _book = Books(
                                id: widget.id,
                                title: book?.title,
                                cover: widget.imageUrl,
                                progress: 0,
                                offset: 0.0,
                                chapterIndex: 0,
                                totalChapter: snapshot.totalChapter,
                                chapterLink: snapshot.chapters[0].link);

                            snapshot.insertOrReplaceToDB(context, _book);
                          }
                        },
                        child: Align(
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                              Icon(snapshot.isExist ? Icons.remove : Icons.add,
                                  color: readerMainColor),
                              Gaps.hGap5,
                              Text(snapshot.isExist ? '不追了' : '追更新',
                                  style: TextStyles.textReader16)
                            ]))))),

            /// 开始阅读按钮
            Expanded(
                child: Material(
                    color: readerMainColor,
                    child: InkWell(
                        onTap: () async {
                          setState(() => readerText = '读取中...');
                          snapshot.setBook(book);
                          String chapterLink = '';

                          /// 判断书籍是否在书架中
                          if (snapshot.isExist) {
                            chapterLink =
                                snapshot.chapters[snapshot.chapterIndex].link;
                            if (chapterLink == '' || null == chapterLink) {
                              chapterLink =
                                  snapshot.chapters[snapshot.chapterIndex].link;

                              debugPrint(
                                  'chapterLink===================$chapterLink');
                              if (chapterLink != '' && null != chapterLink) {
                                snapshot.updateBook(widget.id,
                                    link: chapterLink,
                                    progress: snapshot.chapterIndex /
                                        snapshot.totalChapter);

                                setState(() => readerText = '继续阅读');
                                pushNewPage(
                                    context, ReaderPage(link: chapterLink));
                              }
                            } else {
                              setState(() => readerText = '继续阅读');
                              pushNewPage(
                                  context, ReaderPage(link: chapterLink));
                            }
                          } else {
                            chapterLink =
                                snapshot.chapters[snapshot.chapterIndex].link;
                            debugPrint(
                                'chapterLink===================$chapterLink');
                            if (chapterLink != '' && null != chapterLink) {
                              setState(() => readerText = '开始阅读');
                              pushNewPage(
                                  context, ReaderPage(link: chapterLink));
                            }
                          }
                        },
                        child: Container(
                            child:
                                Text(readerText, style: TextStyles.textWhite16),
                            alignment: Alignment.center)))),

            /// 下载按钮
            Expanded(
                child: Material(
                    color: Colors.white,
                    child: InkWell(
                        onTap: () {
                          Toast.show(context, '下载');
                        },
                        child: Align(
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                              Icon(Icons.file_download, color: readerMainColor),
                              Gaps.hGap5,
                              Text('下载', style: TextStyles.textReader16)
                            ])))))
          ]));
    });
  }

  List<Widget> tags() {
    List<Widget> widgets = [];
    if (book != null)
      book.tags.forEach(
        (tag) => widgets.add(
          TagView(
            tag: tag,
            bgColor: Utils.strToColor(tag),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            textColor: Colors.white,
          ),
        ),
      );

    return widgets;
  }
}
