import 'package:flutter_app/bean/address.dart';
import 'package:flutter_app/utils/database.dart';
import 'package:sqflite/sqflite.dart';

class AddressProvider extends BaseDBProvider {
  /// DataBase table name
  static const String table_name = "address";

  static const String COLUMN_ID = "_id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_PHONE = "phone";
  static const String COLUMN_ADDRESS = "address";
  static const String COLUMN_CITY = "city";
  static const String COLUMN_COUNTY = "county";
  static const String COLUMN_PROVINCE = "province";
  static const String COLUMN_IS_DEFAULT = "is_default";
  static const String COLUMN_TAG = "tag";
  static const String COLUMN_ZIPCODE = "zipcode";

  @override
  String createSql() =>
      baseCreateSql(table_name, COLUMN_ID) +
      '''
       $COLUMN_NAME TEXT not null,
       $COLUMN_PHONE TEXT not null,
       $COLUMN_ADDRESS TEXT not null,
       $COLUMN_ZIPCODE TEXT,
       $COLUMN_IS_DEFAULT INTEGER not null,
       $COLUMN_TAG TEXT not null,
       $COLUMN_COUNTY TEXT not null,
       $COLUMN_CITY TEXT not null,
       $COLUMN_PROVINCE TEXT not null)
      ''';

  @override
  String tableName() => table_name;

  Future<int> insertOrReplaceToDB(Address address) async {
    if (address == null) return -1;
    if (address.id != -1) return await updateAddress(address);
    Database db = await getDB();
    Map<String, dynamic> map = address.toMap();
    int addressId = await db.insert(table_name, map);
    if (address.isDefault) {
      return await updateAddressDefault(addressId, address.isDefault)
          ? addressId
          : -1;
    } else {
      return addressId;
    }
  }

  Future<List<Address>> getAddressList() async {
    List<Address> addresses = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db.query(table_name);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Address address = Address.fromMap(map);
        addresses.add(address);
      }
    }
    return addresses;
  }

  Future<Address> getAddress(int id) async {
    bool _isExist = await isExist(id);
    if (!_isExist) {
      return null;
    }
    List<Address> addresses = List();
    Database db = await getDB();
    List<Map<String, dynamic>> maps =
        await db.query(table_name, where: "$COLUMN_ID = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      for (Map<String, dynamic> map in maps) {
        Address address = Address.fromMap(map);
        addresses.add(address);
      }

      return addresses[0];
    }

    return null;
  }

  Future<int> deleteAddress(int id) async {
    bool _isExist = await isExist(id);
    if (!_isExist) return -1;
    Database db = await getDB();

    return await db
        .delete(table_name, where: "$COLUMN_ID = ?", whereArgs: [id]);
  }

  Future<bool> isExist(int id) async {
    if (id == null) return false;
    Database db = await getDB();
    List<Map<String, dynamic>> maps =
        await db.query(table_name, where: "$COLUMN_ID = ?", whereArgs: [id]);
    return maps.isNotEmpty;
  }

  Future<int> updateAddress(Address address) async {
    int id = address?.id;
    if (address == null || id == null || id <= 0) return -1;

    bool _isExist = await isExist(id);
    if (!_isExist) return -1;
    Database db = await getDB();

    await updateAddressDefault(id, address.isDefault);

    Map<String, dynamic> map = address.toMap();
    return await db
        .update(table_name, map, where: "$COLUMN_ID = ?", whereArgs: [id]);
  }

  Future<bool> updateAddressDefault(int id, bool isDefault) async {
    bool _isExist = await isExist(id);
    if (!_isExist) return false;
    Database db = await getDB();

    if (isDefault) {
      Address address = await defaultAddress();

      if (address != null) {
        await db.update(table_name, {'${AddressProvider.COLUMN_IS_DEFAULT}': 0},
            where: "$COLUMN_ID = ?", whereArgs: [address.id]);
      }
    }

    return await db.update(
            table_name, {'${AddressProvider.COLUMN_IS_DEFAULT}': isDefault},
            where: "$COLUMN_ID = ?", whereArgs: [id]) ==
        1;
  }

  Future<Address> defaultAddress() async {
    Database db = await getDB();
    List<Map<String, dynamic>> maps = await db
        .query(table_name, where: "$COLUMN_IS_DEFAULT = ?", whereArgs: [1]);

    List<Address> addresses = List();

    if (maps.length > 0) {
      for (Map<String, dynamic> map in maps) {
        Address address = Address.fromMap(map);
        addresses.add(address);
      }

      return addresses[0];
    } else {
      return null;
    }
  }
}
