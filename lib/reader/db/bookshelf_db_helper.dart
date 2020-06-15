import 'package:flutter/material.dart';
import 'package:flutter_app/bean/books.dart';
import 'package:sqflite/sqflite.dart';

import '../../page_index.dart';

class BookShelfDBHelper extends BaseDBProvider {
  /// DataBase table name
  static const String table_name = "novel_bookshelf";

  static const String COLUMN_ID = "_id";
  static const String COLUMN_BOOK_ID = "bookId";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_CHAPTER_INDEX = "chaptersIndex";
  static const String COLUMN_IMAGE = "image";
  static const String COLUMN_LINK = "link";
  static const String COLUMN_READ_PROGRESS = "progress";
  static const String COLUMN_OFFSET = "offset";
  static const String COLUMN_TOTAL_CHAPTER = "totalChapter";

  @override
  String createSql() =>
      baseCreateSql(table_name, COLUMN_ID) +
      '''
       $COLUMN_BOOK_ID TEXT not null,
       $COLUMN_TITLE TEXT not null,
       $COLUMN_IMAGE TEXT not null,
       $COLUMN_CHAPTER_INDEX INTEGER not null,
       $COLUMN_TOTAL_CHAPTER INTEGER not null,
       $COLUMN_LINK TEXT,
       $COLUMN_READ_PROGRESS DOUBLE not null,
       $COLUMN_OFFSET DOUBLE not null)
      ''';

  @override
  String tableName() => table_name;

  /// 根据[bookId]查询某书是否在书架
  /// @return true or false
  ///
  Future<bool> isExist(String bookId) async {
    if (bookId == null) return false;
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_BOOK_ID = ?", whereArgs: [bookId]);
    return maps.isNotEmpty;
  }

  /// 根据[bookId]查询某书详情
  /// @return book
  ///
  Future<Books> getBook(String bookId) async {
    bool _isExist = await isExist(bookId);
    if (!_isExist) return null;

    List<Books> books = [];
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_BOOK_ID = ?", whereArgs: [bookId]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Books book = Books.fromMap(map);
        books.add(book);
      }

      return books.first;
    } else {
      return null;
    }
  }

  /// 根据[_id]查询某书详情
  /// @return book
  ///
  Future<Books> getBookById(int _id) async {
    List<Books> books = [];
    Database db = await getDB();
    List<Map<String, dynamic>> maps =
        await db.query(table_name, where: "$COLUMN_ID = ?", whereArgs: [_id]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Books book = Books.fromMap(map);
        books.add(book);
      }
      return books.first;
    } else {
      return null;
    }
  }

  /// 查询书架上所有小说
  /// @return list
  ///
  Future<List<Books>> getAllBooks() async {
    List<Books> books = [];
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(table_name);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Books book = Books.fromMap(map);
        books.add(book);
      }
    }
    debugPrint('getAllBooks()----------------------${books.length}');
    return books;
  }

  /// 添加小说[book]到书架
  /// @return _id
  ///
  Future<int> insertOrReplaceToDB(Books book) async {
    if (book == null) return -1;
    String id = book?.id;
    if (book == null || id == null) return -1;
    bool _isExist = await isExist(id);
    if (!_isExist) {}
    Database db = await getDB();
    return await db.insert(table_name, book.toMap());
  }

  /// 跟新书架上的小说信息[book]
  /// @return true or false
  ///
  Future<bool> updateBook(Books book) async {
    String id = book?.id;
    if (book == null || id == null) return false;

    bool _isExist = await isExist(id);
    if (!_isExist) return false;
    Database db = await getDB();

    int result = await db.update(table_name, book.toMap(),
        where: "$COLUMN_BOOK_ID = ?", whereArgs: [id]);

    return result == 1;
  }

  /// 根据[bookId]删除书架上的小说
  /// @return true or false
  ///
  Future<bool> deleteBook(String bookId) async {
    bool _isExist = await isExist(bookId);
    if (!_isExist) return false;
    Database db = await getDB();

    int result = await db
        .delete(table_name, where: "$COLUMN_BOOK_ID = ?", whereArgs: [bookId]);

    return result == 1;
  }

  /// 删除书架上的所有小说
  /// @return true or false
  ///
  Future<bool> deleteAllBook() async {
    Database db = await getDB();
    int result = await db.delete(table_name);
    return result == 1;
  }
}
