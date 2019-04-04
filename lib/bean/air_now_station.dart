class AirNowStation {
  /**
   * air_sta : "万寿西宫"
   * aqi : "82"
   * asid : "CNA1001"
   * co : "0.8"
   * lat : "39.8673"
   * lon : "116.366"
   * main : "PM2.5"
   * no2 : "31"
   * o3 : "72"
   * pm10 : "0"
   * pm25 : "60"
   * pub_time : "2019-03-04 12:00"
   * qlty : "良"
   * so2 : "6"
   */

  String air_sta;
  String aqi;
  String asid;
  String co;
  String lat;
  String lon;
  String main;
  String no2;
  String o3;
  String pm10;
  String pm25;
  String pub_time;
  String qlty;
  String so2;

  static AirNowStation fromMap(Map<String, dynamic> map) {
    AirNowStation air_now_station = AirNowStation();
    air_now_station.air_sta = map['air_sta'];
    air_now_station.aqi = map['aqi'];
    air_now_station.asid = map['asid'];
    air_now_station.co = map['co'];
    air_now_station.lat = map['lat'];
    air_now_station.lon = map['lon'];
    air_now_station.main = map['main'];
    air_now_station.no2 = map['no2'];
    air_now_station.o3 = map['o3'];
    air_now_station.pm10 = map['pm10'];
    air_now_station.pm25 = map['pm25'];
    air_now_station.pub_time = map['pub_time'];
    air_now_station.qlty = map['qlty'];
    air_now_station.so2 = map['so2'];
    return air_now_station;
  }

  static List<AirNowStation> fromMapList(dynamic mapList) {
    List<AirNowStation> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}