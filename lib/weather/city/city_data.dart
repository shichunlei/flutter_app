import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class CityData extends ISuspensionBean {
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

  CityData(
      {this.cid,
      this.location,
      this.tz,
      this.cnty,
      this.type,
      this.lon,
      this.lat,
      this.parent_city,
      this.admin_area,
      this.tagIndex,
      this.namePinyin});

  static List<CityData> decodeData(String jsonData) {
    List<CityData> citys = new List<CityData>();

    var data = json.decode(jsonData)['HeWeather6'][0];

    if (data['status'] == 'ok') {
      var results = data['basic'];
      for (int i = 0; i < results.length; i++) {
        citys.add(fromMap(results[i]));
      }
    }
    return citys;
  }

  static CityData fromMap(Map map) {
    return new CityData(
      cid: map['cid'],
      location: map['location'],
      tz: map['tz'],
      cnty: map['cnty'],
      type: map['type'],
      lon: map['lon'],
      lat: map['lat'],
      parent_city: map['parent_city'],
      admin_area: map['admin_area'],
      tagIndex: "",
      namePinyin: "",
    );
  }

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}
