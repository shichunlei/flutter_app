import 'package:flutter_app/utils/database.dart';
import 'package:flutter_app/bean/article.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart' as strings;

import 'dart:async';

class ArticleProvider extends BaseDBProvider {
  /// DataBase table name
  static const String table_name = "article";

  static final String columnId = "_id";
  static final String columnDate = "date";
  static final String columnDigest = "digest";
  static final String columnTitle = "title";
  static final String columnAuthor = "author";

  @override
  String createSql() =>
      baseCreateSql(table_name, columnId) +
      '''
        $columnAuthor text not null,
        $columnTitle text not null,
        $columnDate text not null,
        $columnDigest text not null)
      ''';

  @override
  String tableName() => table_name;

  Future<bool> isCollection(String date) async {
    if (date == null) return false;
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(table_name,
        columns: [
          columnId,
          columnAuthor,
          columnTitle,
          columnDate,
          columnDigest,
        ],
        where: "$columnDate = ?",
        whereArgs: [date]);
    return maps.isNotEmpty;
  }

  Future<int> insertOrReplaceToDB(Article article) async {
    String date = article?.curr;
    if (article == null || strings.isEmpty(date) == null) return null;
    Database db = await getDB();
    bool provider = await isCollection(date);
    Map<String, dynamic> map = article.toMap();
    if (provider) {
      return await db
          .update(table_name, map, where: "$columnDate = ?", whereArgs: [date]);
    }
    return await db.insert(table_name, map);
  }

  Future<List<Article>> getStarredList() async {
    List<Article> articles = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(table_name, columns: [
      columnId,
      columnAuthor,
      columnTitle,
      columnDate,
      columnDigest,
    ]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Article article = Article.fromMap(map);
        articles.add(article);
      }
    }
    return articles;
  }

  Future<void> cancelStarred(String date) async {
    bool provider = await isCollection(date);
    Database db = await getDB();
    if (provider) {
      db.delete(table_name, where: "$columnDate = ?", whereArgs: [date]);
    }
  }
}
