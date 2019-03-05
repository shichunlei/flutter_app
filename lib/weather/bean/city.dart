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
  String parent_city;
  String admin_area;

  String tagIndex;
  String namePinyin;

  City({
    this.cid,
    this.location,
    this.tz,
    this.cnty,
    this.type,
    this.lon,
    this.lat,
    this.parent_city,
    this.admin_area,
    this.tagIndex,
    this.namePinyin,
  });

  static City fromMap(Map<String, dynamic> map) {
    City city = City();
    city.type = map['type'];
    city.cid = map['cid'];
    city.location = map['location'];
    city.admin_area = map['admin_area'];
    city.parent_city = map['parent_city'];
    city.lon = map['lon'];
    city.cnty = map['cnty'];
    city.tz = map['tz'];
    city.namePinyin = PinyinHelper.getPinyinE(map['parent_city']);
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
    return tagIndex;
  }
}
