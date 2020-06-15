import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class BookModel extends ChangeNotifier {
  BookShelfDBHelper dbHelper;

  BookModel() {
    dbHelper = BookShelfDBHelper();
  }

  /// 得到书架上所有的书籍
  Future<List<Books>> getBooks() async {
    List<Books> books = await dbHelper.getAllBooks();

    return books;
  }

  /// 删除书架上ID为[bookId]的书籍
  ///
  Future deleteBook(BuildContext context, String bookId) async {
    if (await dbHelper.deleteBook(bookId)) {
      getBook(bookId);

      /// 更新ID为[bookId]的书籍在书架中的状态
      updateIsExist(bookId);
      Toast.show(context, '已在书架移除');
    } else {
      Toast.show(context, '移除失败');
    }
  }

  /// 删除书架上的全部书籍
  ///
  Future deleteAllBook(BuildContext context) async {
    if (await dbHelper.deleteAllBook()) {
      getBooks();
      refresh();
      Toast.show(context, '移除成功');
    } else {
      Toast.show(context, '移除失败');
    }
  }

  Books _book;

  /// 得到书籍ID为[bookId]的书籍信息
  ///
  Future getBook(String bookId) async {
    _book = await dbHelper.getBook(bookId);

    if (null != _book) {
      _chapterIndex = _book.chapterIndex;
    }

    getBooks();
    refresh();
  }

  /// 加入书架
  ///
  Future insertOrReplaceToDB(BuildContext context, Books book) async {
    int _id = await dbHelper.insertOrReplaceToDB(book);

    if (_id > 0) {
      /// 更新ID为[bookId]的书籍在书架中的状态
      updateIsExist(book.id);

      Toast.show(context, '添加书架成功');
    } else {
      Toast.show(context, '添加书架失败');
    }
  }

  /// 当前阅读的章节下标
  ///
  int _chapterIndex = 0;

  int get chapterIndex => _chapterIndex;

  /// 更新书籍ID为[id]的书籍
  ///
  Future updateBook(
    String id, {
    double progress,
    int chapterIndex: 0,
    @required String link,
    double offset,
    int totalChapter,
  }) async {
    _book = await dbHelper.getBook(id);

    _chapterIndex = chapterIndex;

    /// 已加入书架
    if (null != _book) {
      Books book = Books(
        id: id,
        title: _book.title,
        cover: _book.cover,
        progress: progress ??= _book.progress,
        chapterIndex: chapterIndex ??= _book.chapterIndex,
        chapterLink: link ??= _book.chapterLink,
        offset: offset ??= _book.offset,
        totalChapter: totalChapter ??= _book.totalChapter,
      );

      bool result = await dbHelper.updateBook(book);

      if (result) {
        getBook(id);
      }
    }

    refresh();
  }

  /// 当前书籍的章节总数
  int _totalChapter = 0;

  int get totalChapter => _totalChapter;

  List<Chapters> _chapters = [];

  List<Chapters> get chapters => _chapters;

  /// 得到当前书籍的所有章节
  Future getChapters(String bookId) async {
    BtocResult result = await ApiService.getBookBtocSource(bookId);
    if (result != null) {
      _chapters = await ApiService.getBookChapters(result.id);

      debugPrint('getChapters($bookId)=========');

      _totalChapter = _chapters.length;
    }
  }

  /// 当前书籍是否在书架中
  bool _isExist = false;

  bool get isExist => _isExist;

  Future updateIsExist(String bookId) async {
    _isExist = await dbHelper.isExist(bookId);
    debugPrint('getIsExist($bookId)=========$_isExist');

    /// 存在
    if (_isExist) {
      getBook(bookId);
    } else {
      _chapterIndex = 0;
    }

    refresh();
  }

  /// 当前书籍
  Books _currentBook;

  Books get currentBook => _currentBook;

  setBook(Books book) {
    _currentBook = book;
    refresh();
  }

  void refresh() {
    notifyListeners();
  }
}
