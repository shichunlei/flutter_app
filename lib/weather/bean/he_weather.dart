import 'package:flutter_app/weather/bean/air_now_city.dart';
import 'package:flutter_app/weather/bean/air_now_station.dart';
import 'package:flutter_app/weather/bean/basic.dart';
import 'package:flutter_app/weather/bean/daily_forecast.dart';
import 'package:flutter_app/weather/bean/hourly.dart';
import 'package:flutter_app/weather/bean/lifestyle.dart';
import 'package:flutter_app/weather/bean/now.dart';
import 'package:flutter_app/weather/bean/sunrise_sunset.dart';
import 'package:flutter_app/weather/bean/update.dart';

class HeWeather {
  /// 接口状态
  String status;

  /// 基础信息
  Basic basic;

  /// 实况天气
  NowBean now;

  /// 接口更新时间
  UpdateBean update;

  /// 天气预报
  List<DailyForecast> daily_forecast;

  /// 生活指数
  List<Lifestyle> lifestyle;

  /// 逐小时预报
  List<Hourly> hourly;

  /// AQI城市实况
  AirNowCity air_now_city;

  /// AQI站点实况
  List<AirNowStation> air_now_station;

  /// 日出日落
  List<SunriseSunset> sunrise_sunset;

  static HeWeather fromMap(Map<String, dynamic> map) {
    HeWeather he_weather = HeWeather();
    he_weather.status = map['status'];

    he_weather.basic =
        map['basic'] == null ? null : Basic.fromMap(map['basic']);

    he_weather.air_now_city = map['air_now_city'] == null
        ? null
        : AirNowCity.fromMap(map['air_now_city']);
    he_weather.now = map['now'] == null ? null : NowBean.fromMap(map['now']);
    he_weather.update =
        map['update'] == null ? null : UpdateBean.fromMap(map['update']);
    he_weather.daily_forecast = map['daily_forecast'] == null
        ? []
        : DailyForecast.fromMapList(map['daily_forecast']);
    he_weather.lifestyle =
        map['lifestyle'] == null ? [] : Lifestyle.fromMapList(map['lifestyle']);
    he_weather.hourly =
        map['hourly'] == null ? [] : Hourly.fromMapList(map['hourly']);

    he_weather.air_now_station = map['air_now_station'] == null
        ? []
        : AirNowStation.fromMapList(map['air_now_station']);

    he_weather.sunrise_sunset = map['sunrise_sunset'] == null
        ? []
        : SunriseSunset.fromMapList(map['sunrise_sunset']);
    return he_weather;
  }

  static List<HeWeather> fromMapList(dynamic mapList) {
    List<HeWeather> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
