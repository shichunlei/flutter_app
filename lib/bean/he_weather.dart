import 'package:flutter/material.dart';
import 'package:flutter_app/utils/date_format.dart';

import 'city.dart';

class HeWeather {
  /// 接口状态
  String status;

  /// 基础信息
  City city;

  /// 实况天气
  NowWeather now;

  /// 接口更新时间
  UpdateBean update;

  /// 天气预报
  List<DailyForecast> dailyForecast;

  /// 生活指数
  List<Lifestyle> lifestyle;

  /// 逐小时预报
  List<Hourly> hourly;

  /// AQI城市实况
  Air airNowCity;

  /// AQI站点实况
  List<Air> airNowStation;

  /// 日出日落
  List<SunriseSunset> sunriseSunset;

  HeWeather(
      {this.status,
      this.city,
      this.now,
      this.update,
      this.dailyForecast,
      this.lifestyle,
      this.hourly,
      this.airNowCity,
      this.airNowStation,
      this.sunriseSunset}) {
    this.city = city;
    this.now = now;
    this.dailyForecast = dailyForecast;
    this.update = update;
    this.status = status;
    this.lifestyle = lifestyle;
    this.hourly = hourly;
    this.sunriseSunset = sunriseSunset;
    this.airNowCity = airNowCity;
    this.airNowStation = airNowStation;
  }

  static HeWeather fromMap(Map<String, dynamic> map) {
    HeWeather weather = HeWeather();
    weather.status = map['status'];

    weather.city = (map['basic'] == null || !(map['basic'] is Map))
        ? null
        : City.fromMap(map['basic']);

    weather.airNowCity =
        map['air_now_city'] == null ? null : Air.fromMap(map['air_now_city']);
    weather.now = map['now'] == null ? null : NowWeather.fromMap(map['now']);
    weather.update =
        map['update'] == null ? null : UpdateBean.fromMap(map['update']);

    weather.dailyForecast = List()
      ..addAll((map['daily_forecast'] as List ?? [])
          .map((o) => DailyForecast.fromMap(o)));

    weather.lifestyle = List()
      ..addAll(
          (map['lifestyle'] as List ?? []).map((o) => Lifestyle.fromMap(o)));

    weather.hourly = List()
      ..addAll((map['hourly'] as List ?? []).map((o) => Hourly.fromMap(o)));

    weather.airNowStation = List()
      ..addAll(
          (map['air_now_station'] as List ?? []).map((o) => Air.fromMap(o)));

    weather.sunriseSunset = List()
      ..addAll((map['sunrise_sunset'] as List ?? [])
          .map((o) => SunriseSunset.fromMap(o)));
    return weather;
  }
}

class NowWeather {
  String cloud; // 云量
  String condCode; // 实况天气状况代码
  String condIcon;
  String condTxt; // 实况天气状况描述
  String fl; // 体感温度，默认单位：摄氏度
  String hum; // 相对湿度
  String pcpn; // 降水量
  String pcpn_10m; // 10分钟降水量
  String pres; // 大气压强
  String tmp; // 温度，默认单位：摄氏度
  String vis; // 能见度，默认单位：公里
  String windDeg; // 风向360角度
  String windDir; // 风向
  String windSc; // 风力
  String windSpd; // 风速，公里/小时

  static NowWeather fromMap(Map<String, dynamic> map) {
    NowWeather nowBean = NowWeather();
    nowBean.cloud = map['cloud'];
    nowBean.condCode = map['cond_code'];
    nowBean.condIcon =
        "https://cdn.heweather.com/cond_icon/${map['cond_code']}.png";
    nowBean.condTxt = map['cond_txt'];
    nowBean.fl = map['fl'];
    nowBean.hum = "${map['hum']}%";
    nowBean.pcpn = map['pcpn'];
    nowBean.pres = map['pres'];
    nowBean.tmp = "${map['tmp']}°";
    nowBean.vis = map['vis'];
    nowBean.windDeg = map['wind_deg'];
    nowBean.windDir = map['wind_dir'];
    nowBean.windSc = map['wind_sc'];
    nowBean.windSpd = map['wind_spd'];
    return nowBean;
  }
}

// * 生活指数类型
// * comf：舒适度指数
// * cw：洗车指数
// * drsg：穿衣指数
// * flu：感冒指数
// * sport：运动指数
// * trav：旅游指数
// * uv：紫外线指数
// * air：空气污染扩散条件指数
// * ac：空调开启指数
// * ag：过敏指数
// * gl：太阳镜指数
// * mu：化妆指数
// * airc：晾晒指数
// * ptfc：交通指数
// * fsh：钓鱼指数
// * spi：防晒指数

class Lifestyle {
  String type;

  /// 生活指数简介
  String brf;

  /// 生活指数详细描述
  String txt;

  /// 预报日期，例如2017-12-30
  String date;

  static Lifestyle fromMap(Map<String, dynamic> map) {
    Lifestyle lifestyle = Lifestyle();
    String lifeStyle = '';
    switch (map['type']) {
      case 'comf':
        lifeStyle = '舒适度指数';
        break;
      case 'cw':
        lifeStyle = '洗车指数';
        break;
      case 'drsg':
        lifeStyle = '穿衣指数';
        break;
      case 'flu':
        lifeStyle = '感冒指数';
        break;
      case 'sport':
        lifeStyle = '运动指数';
        break;
      case 'trav':
        lifeStyle = '旅游指数';
        break;
      case 'uv':
        lifeStyle = '紫外线指数';
        break;
      case 'air':
        lifeStyle = '空气污染扩散条件指数';
        break;
      case 'ac':
        lifeStyle = '空调开启指数';
        break;
      case 'ag':
        lifeStyle = '过敏指数';
        break;
      case 'gl':
        lifeStyle = '太阳镜指数';
        break;
      case 'mu':
        lifeStyle = '化妆指数';
        break;
      case 'airc':
        lifeStyle = '晾晒指数';
        break;
      case 'ptfc':
        lifeStyle = '交通指数';
        break;
      case 'fsh':
        lifeStyle = '钓鱼指数';
        break;
      case 'spi':
        lifeStyle = '防晒指数';
        break;
      default:
        break;
    }
    lifestyle.type = lifeStyle;
    lifestyle.brf = map['brf'];
    lifestyle.txt = map['txt'];
    lifestyle.date = map['date'];
    return lifestyle;
  }
}

//* cloud : "25"
//* cond_code : "100"
//* cond_txt : "晴"
//* dew : "-10"
//* hum : "39"
//* pop : "0"
//* pres : "1012"
//* time : "2019-03-04 13:00"
//* tmp : "13"
//* wind_deg : "69"
//* wind_dir : "东北风"
//* wind_sc : "1-2"
//* wind_spd : "6"

class Hourly {
  String cloud;
  String condCode;
  String cond_txt;
  String dew;
  String hum;
  String pop;
  String pres;
  String time;
  double tmp;
  String wind_deg;
  String wind_dir;
  String wind_sc;
  String wind_spd;

  static Hourly fromMap(Map<String, dynamic> map) {
    Hourly hourly = Hourly();
    String n = '';
    List<String> times = [
      '00:00',
      '01:00',
      '02:00',
      '03:00',
      '04:00',
      '05:00',
      '06:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00'
    ];

    String _time =
        formatDate(DateTime.parse("${map['time']}:00"), formats: [HH, ':', nn]);

    if ((map['cond_code'] == '100' ||
            map['cond_code'] == '103' ||
            map['cond_code'] == '104' ||
            map['cond_code'] == '300' ||
            map['cond_code'] == '301' ||
            map['cond_code'] == '406' ||
            map['cond_code'] == '407') &&
        times.contains(_time)) {
      n = 'n';
    }

    hourly.cloud = map['cloud'];
    hourly.condCode =
        "https://cdn.heweather.com/cond_icon/${map['cond_code']}$n.png";
    hourly.cond_txt = map['cond_txt'];
    hourly.dew = map['dew'];
    hourly.hum = map['hum'];
    hourly.pop = map['pop'];
    hourly.pres = map['pres'];
    hourly.time = _time;
    hourly.tmp = double.parse(map['tmp'] ?? "0");
    hourly.wind_deg = map['wind_deg'];
    hourly.wind_dir = map['wind_dir'];
    hourly.wind_sc = map['wind_sc'];
    hourly.wind_spd = map['wind_spd'];
    return hourly;
  }
}

class SunriseSunset {
  /**
   * date : "2019-03-04"
   * mr : "05:38"
   * ms : "15:50"
   * sr : "06:41"
   * ss : "18:10"
   */

  /// 预报日期
  String date;
  String mr;
  String ms;

  /// 日出时间
  String sr;

  /// 日落时间
  String ss;

  static SunriseSunset fromMap(Map<String, dynamic> map) {
    SunriseSunset sunriseSunset = SunriseSunset();
    sunriseSunset.date = map['date'];
    sunriseSunset.mr = map['mr'];
    sunriseSunset.ms = map['ms'];
    sunriseSunset.sr = map['sr'];
    sunriseSunset.ss = map['ss'];
    return sunriseSunset;
  }
}

class DailyForecast {
  /// 白天天气状况代码
  String cond_code_d;

  /// 晚间天气状况代码
  String cond_code_n;

  /// 白天天气状况描述
  String cond_txt_d;

  /// 晚间天气状况描述
  String cond_txt_n;

  /// 预报日期
  String date;

  /// 相对湿度
  String hum;

  /// 月升时间
  String mr;

  /// 月落时间
  String ms;

  /// 降水量
  String pcpn;

  /// 降水概率
  String pop;

  /// 大气压强
  String pres;

  /// 日出时间
  String sr;

  /// 日落时间
  String ss;

  /// 最高温度
  double tmp_max;

  /// 最低温度
  double tmp_min;

  /// 紫外线强度指数
  String uv_index;

  /// 能见度，单位：公里
  String vis;

  /// 风向360角度
  String wind_deg;

  /// 风向
  String wind_dir;

  /// 风力
  String wind_sc;

  /// 风速
  String wind_spd;

  DailyForecast({this.tmp_max, this.tmp_min});

  static DailyForecast fromMap(Map<String, dynamic> map) {
    DailyForecast daily = DailyForecast();
    String n = '';
    if (map['cond_code_n'] == '100' ||
        map['cond_code_n'] == '103' ||
        map['cond_code_n'] == '104' ||
        map['cond_code_n'] == '300' ||
        map['cond_code_n'] == '301' ||
        map['cond_code_n'] == '406' ||
        map['cond_code_n'] == '407') {
      n = 'n';
    }
    daily.cond_code_d =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_d']}.png";
    daily.cond_code_n =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_n']}$n.png";
    daily.cond_txt_d = map['cond_txt_d'];
    daily.cond_txt_n = map['cond_txt_n'];
    daily.date = map['date'];
    daily.hum = map['hum'];
    daily.mr = map['mr'];
    daily.ms = map['ms'];
    daily.pcpn = map['pcpn'];
    daily.pop = map['pop'];
    daily.pres = map['pres'];
    daily.sr = map['sr'];
    daily.ss = map['ss'];
    daily.tmp_max = double.parse(map['tmp_max'] ?? "0");
    daily.tmp_min = double.parse(map['tmp_min'] ?? "0");
    daily.uv_index = map['uv_index'];
    daily.vis = map['vis'];
    daily.wind_deg = map['wind_deg'];
    daily.wind_dir = map['wind_dir'];
    daily.wind_sc = map['wind_sc'];
    daily.wind_spd = map['wind_spd'];
    return daily;
  }
}

//   * air_sta : "万寿西宫"
//   * aqi : "82"
//   * asid : "CNA1001"
//   * co : "0.8"
//   * lat : "39.8673"
//   * lon : "116.366"
//   * main : "PM2.5"
//   * no2 : "31"
//   * o3 : "72"
//   * pm10 : "0"
//   * pm25 : "60"
//   * pub_time : "2019-03-04 12:00"
//   * qlty : "良"
//   * so2 : "6"

class Air {
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
  String pubTime;
  String qlty;
  String so2;

  Color aqiColor;

  static Air fromMap(Map<String, dynamic> map) {
    Air air = Air();
    air.air_sta = map['air_sta'];
    air.aqi = map['aqi'];
    air.asid = map['asid'];
    air.co = map['co'];
    air.lat = map['lat'];
    air.lon = map['lon'];
    air.main = map['main'];
    air.no2 = map['no2'];
    air.o3 = map['o3'];
    air.pm10 = map['pm10'];
    air.pm25 = map['pm25'];
    air.pubTime = map['pub_time'];
    air.qlty = map['qlty'];
    air.so2 = map['so2'];

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
    air.aqiColor = _aqiColor;

    return air;
  }
}

class UpdateBean {
  /// 当地时间，24小时制，格式yyyy-MM-dd HH:mm
  String loc;

  /// UTC时间，24小时制，格式yyyy-MM-dd HH:mm
  String utc;

  static UpdateBean fromMap(Map<String, dynamic> map) {
    UpdateBean updateBean = UpdateBean();
    updateBean.loc = map['loc'];
    updateBean.utc = map['utc'];
    return updateBean;
  }
}
