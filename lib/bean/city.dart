import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';

class City extends ISuspensionBean {
  String cid;
  String location;
  String tz;
  String cnty;
  String type;
  String lon;
  String lat;
  String parentCity;
  String adminArea;

  String firstLetter;

  City({
    this.cid,
    this.location,
    this.tz,
    this.cnty,
    this.type,
    this.lon,
    this.lat,
    this.parentCity,
    this.adminArea,
    this.firstLetter,
  });

  static City fromMap(Map<String, dynamic> map) {
    City city = City();
    city.type = map['type'];
    city.cid = map['cid'];
    city.location = map['location'];
    city.adminArea = map['admin_area'];
    city.parentCity = map['parent_city'];
    city.lon = map['lon'];
    city.cnty = map['cnty'];
    city.tz = map['tz'];
    String tag = PinyinHelper.getPinyinE(map['location'])[0].toUpperCase();
    if (RegExp("[A-Z]").hasMatch(tag)) {
      city.firstLetter = tag;
    } else {
      city.firstLetter = "#";
    }
    return city;
  }

  static List<City> fromMapList(dynamic mapList) {
    List<City> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String getSuspensionTag() {
    return firstLetter;
  }
}
