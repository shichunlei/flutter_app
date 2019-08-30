import '../../page_index.dart';

class BookShelfDBHelper extends BaseDBProvider {
  /// DataBase table name
  static final String table_name = "novel_chapter";

  @override
  String createSql() {
    return null;
  }

  @override
  String tableName() => table_name;
}
