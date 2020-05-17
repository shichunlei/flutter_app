import 'package:flutter_app/bean/baixing.dart';
import 'package:flutter_app/utils/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quiver/strings.dart' as strings;

class GoodsProvider extends BaseDBProvider {
  /// DataBase table name
  static const String table_name = "products";

  static const String COLUMN_ID = "_id";
  static const String COLUMN_IMAGE = "image";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_PRICE = "price";
  static const String COLUMN_ORI_PRICE = "ori_price";
  static const String COLUMN_NUM = "number";
  static const String COLUMN_GOODS_ID = "goods_id";
  static const String COLUMN_SHOP_ID = "shop_id";
  static const String COLUMN_IS_CHECK = "is_checked";

  @override
  String createSql() =>
      baseCreateSql(table_name, COLUMN_ID) +
      '''
       $COLUMN_GOODS_ID TEXT not null,
       $COLUMN_NAME TEXT not null,
       $COLUMN_PRICE REAL not null,
       $COLUMN_ORI_PRICE REAL not null,
       $COLUMN_NUM INTEGER not null,
       $COLUMN_IS_CHECK INTEGER not null,
       $COLUMN_SHOP_ID TEXT not null,
        $COLUMN_IMAGE TEXT not null)
      ''';

  @override
  String tableName() => table_name;

  Future<List<Goods>> getGoodsList() async {
    List<Goods> products = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(table_name);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Goods goods = Goods.fromJson(map);
        products.add(goods);
      }
    }
    return products;
  }

  Future<Goods> getGoods(String goodsId) async {
    if (!await isExist(goodsId)) {
      return null;
    }
    List<Goods> products = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_GOODS_ID = ?", whereArgs: [goodsId]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Goods goods = Goods.fromJson(map);
        products.add(goods);
      }
    }
    return products[0];
  }

  Future<List<Goods>> getCheckedGoodsList() async {
    List<Goods> products = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_IS_CHECK = ?", whereArgs: [1]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Goods goods = Goods.fromJson(map);
        products.add(goods);
      }
    }
    return products;
  }

  Future<int> insertOrReplaceToDB(Goods goods) async {
    String goodsId = goods?.goodsId;
    if (goods == null || strings.isEmpty(goodsId) == null) return null;
    Database db = await getDB();
    Map<String, dynamic> map = goods.toMap();
    if (await isExist(goodsId)) {
      return await db.update(table_name, map,
          where: "$COLUMN_GOODS_ID = ?", whereArgs: [goodsId]);
    }
    return await db.insert(table_name, map);
  }

  Future<bool> isExist(String goodsId) async {
    if (goodsId == null) return false;
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_GOODS_ID = ?", whereArgs: [goodsId]);
    return maps.isNotEmpty;
  }

  Future<void> deleteGoods(String goodsId) async {
    Database db = await getDB();
    if (await isExist(goodsId)) {
      db.delete(table_name,
          where: "$COLUMN_GOODS_ID = ?", whereArgs: [goodsId]);
    }
  }
}
