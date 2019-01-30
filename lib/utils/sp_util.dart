import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static getString(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    var _value = spf.getString(key) ?? "";
    return _value;
  }

  static saveString(String key, value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setString(key, value);
  }

  static getInt(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.getInt(key) ?? -1;
  }

  static saveInt(String key, int value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setInt(key, value);
  }

  static getBool(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    var _value = spf.getBool(key) ?? false;
    return _value;
  }

  static saveBool(String key, bool value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setBool(key, value);
  }

  static getDouble(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.getDouble(key) ?? 0.0;
  }

  static saveDouble(String key, double value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setDouble(key, value);
  }

  static getList(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    return spf.getStringList(key) ?? [];
  }

  static saveList(String key, List<String> value) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.setStringList(key, value);
  }

  static remove(String key) async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.remove(key);
  }

  static clear() async {
    SharedPreferences spf = await SharedPreferences.getInstance();
    spf.clear();
  }
}
