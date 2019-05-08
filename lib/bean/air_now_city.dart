import 'package:flutter/material.dart';

class AirNowCity {
  /**
   * aqi : "75"
   * qlty : "良"
   * main : "PM2.5"
   * pm25 : "55"
   * pm10 : "46"
   * no2 : "26"
   * so2 : "5"
   * co : "0.7"
   * o3 : "82"
   * pub_time : "2019-03-04 12:00"
   */

  String aqi;
  String qlty;
  String main;
  String pm25;
  String pm10;
  String no2;
  String so2;
  String co;
  String o3;
  String pub_time;

  Color aqiColor;

  static AirNowCity fromMap(Map<String, dynamic> map) {
    AirNowCity air_now_city = AirNowCity();
    air_now_city.aqi = map['aqi'];
    air_now_city.qlty = map['qlty'];
    air_now_city.main = map['main'];
    air_now_city.pm25 = map['pm25'];
    air_now_city.pm10 = map['pm10'];
    air_now_city.no2 = map['no2'];
    air_now_city.so2 = map['so2'];
    air_now_city.co = map['co'];
    air_now_city.o3 = map['o3'];
    air_now_city.pub_time = map['pub_time'];

    Color _aqiColor;
    switch (map['qlty']) {
      case '优':
        _aqiColor = Colors.green;
        break;
      case '良':
        _aqiColor = Colors.yellow;
        break;
      case '轻度污染':
        _aqiColor = Colors.orange;
        break;
      case '中度污染':
        _aqiColor = Colors.deepOrangeAccent;
        break;
      case '重度污染':
        _aqiColor = Colors.deepOrange;
        break;
      case '严重污染':
        _aqiColor = Colors.red;
        break;
      default:
        _aqiColor = Colors.grey;
        break;
    }
    air_now_city.aqiColor = _aqiColor;

    return air_now_city;
  }

  static List<AirNowCity> fromMapList(dynamic mapList) {
    List<AirNowCity> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
