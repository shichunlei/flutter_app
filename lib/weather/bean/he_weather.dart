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

  static List<UpdateBean> fromMapList(dynamic mapList) {
    List<UpdateBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Basic {
  /// 地区／城市ID
  String cid;

  /// 地区／城市名称
  String location;

  /// 该地区／城市的上级城市
  String parent_city;

  /// 该地区／城市所属行政区域
  String admin_area;

  /// 该地区／城市所属国家名称
  String cnty;

  /// 地区／城市纬度
  String lat;

  /// 地区／城市经度
  String lon;

  /// 该地区／城市所在时区
  String tz;

  ///
  String type;

  static Basic fromMap(Map<String, dynamic> map) {
    Basic basicListBean = Basic();
    basicListBean.cid = map['cid'];
    basicListBean.location = map['location'];
    basicListBean.parent_city = map['parent_city'];
    basicListBean.admin_area = map['admin_area'];
    basicListBean.cnty = map['cnty'];
    basicListBean.lat = map['lat'];
    basicListBean.lon = map['lon'];
    basicListBean.tz = map['tz'];
    basicListBean.type = map['type'];
    return basicListBean;
  }

  static List<Basic> fromMapList(dynamic mapList) {
    List<Basic> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class NowBean {
  String cloud;
  String cond_code;
  String cond_txt;
  String fl;
  String hum;
  String pcpn;
  String pres;
  String tmp;
  String vis;
  String wind_deg;
  String wind_dir;
  String wind_sc;
  String wind_spd;

  static NowBean fromMap(Map<String, dynamic> map) {
    NowBean nowBean = NowBean();
    nowBean.cloud = map['cloud'];
    nowBean.cond_code =
        "https://cdn.heweather.com/cond_icon/${map['cond_code']}.png";
    nowBean.cond_txt = map['cond_txt'];
    nowBean.fl = map['fl'];
    nowBean.hum = "湿度 ${map['hum']}%";
    nowBean.pcpn = map['pcpn'];
    nowBean.pres = map['pres'];
    nowBean.tmp = "${map['tmp']}°";
    nowBean.vis = map['vis'];
    nowBean.wind_deg = map['wind_deg'];
    nowBean.wind_dir = map['wind_dir'];
    nowBean.wind_sc = map['wind_sc'];
    nowBean.wind_spd = map['wind_spd'];
    return nowBean;
  }

  static List<NowBean> fromMapList(dynamic mapList) {
    List<NowBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
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
  String tmp_max;

  /// 最低温度
  String tmp_min;

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

  static DailyForecast fromMap(Map<String, dynamic> map) {
    DailyForecast daily_forecastListBean = DailyForecast();
    daily_forecastListBean.cond_code_d =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_d']}.png";
    daily_forecastListBean.cond_code_n =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_n']}.png";
    daily_forecastListBean.cond_txt_d = map['cond_txt_d'];
    daily_forecastListBean.cond_txt_n = map['cond_txt_n'];
    daily_forecastListBean.date = map['date'];
    daily_forecastListBean.hum = map['hum'];
    daily_forecastListBean.mr = map['mr'];
    daily_forecastListBean.ms = map['ms'];
    daily_forecastListBean.pcpn = map['pcpn'];
    daily_forecastListBean.pop = map['pop'];
    daily_forecastListBean.pres = map['pres'];
    daily_forecastListBean.sr = map['sr'];
    daily_forecastListBean.ss = map['ss'];
    daily_forecastListBean.tmp_max = map['tmp_max'];
    daily_forecastListBean.tmp_min = map['tmp_min'];
    daily_forecastListBean.uv_index = map['uv_index'];
    daily_forecastListBean.vis = map['vis'];
    daily_forecastListBean.wind_deg = map['wind_deg'];
    daily_forecastListBean.wind_dir = map['wind_dir'];
    daily_forecastListBean.wind_sc = map['wind_sc'];
    daily_forecastListBean.wind_spd = map['wind_spd'];
    return daily_forecastListBean;
  }

  static List<DailyForecast> fromMapList(dynamic mapList) {
    List<DailyForecast> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Hourly {
  /**
   * cloud : "25"
   * cond_code : "100"
   * cond_txt : "晴"
   * dew : "-10"
   * hum : "39"
   * pop : "0"
   * pres : "1012"
   * time : "2019-03-04 13:00"
   * tmp : "13"
   * wind_deg : "69"
   * wind_dir : "东北风"
   * wind_sc : "1-2"
   * wind_spd : "6"
   */

  String cloud;
  String cond_code;
  String cond_txt;
  String dew;
  String hum;
  String pop;
  String pres;
  String time;
  String tmp;
  String wind_deg;
  String wind_dir;
  String wind_sc;
  String wind_spd;

  static Hourly fromMap(Map<String, dynamic> map) {
    Hourly hourly = Hourly();
    hourly.cloud = map['cloud'];
    hourly.cond_code = map['cond_code'];
    hourly.cond_txt = map['cond_txt'];
    hourly.dew = map['dew'];
    hourly.hum = map['hum'];
    hourly.pop = map['pop'];
    hourly.pres = map['pres'];
    hourly.time = map['time'];
    hourly.tmp = map['tmp'];
    hourly.wind_deg = map['wind_deg'];
    hourly.wind_dir = map['wind_dir'];
    hourly.wind_sc = map['wind_sc'];
    hourly.wind_spd = map['wind_spd'];
    return hourly;
  }

  static List<Hourly> fromMapList(dynamic mapList) {
    List<Hourly> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Lifestyle {
  /***
   * 生活指数类型
   *
   * comf：舒适度指数
   * cw：洗车指数
   * drsg：穿衣指数
   * flu：感冒指数
   * sport：运动指数
   * trav：旅游指数
   * uv：紫外线指数
   * air：空气污染扩散条件指数
   * ac：空调开启指数
   * ag：过敏指数
   * gl：太阳镜指数
   * mu：化妆指数
   * airc：晾晒指数
   * ptfc：交通指数
   * fsh：钓鱼指数
   * spi：防晒指数
   */
  String type;

  /// 生活指数简介
  String brf;

  /// 生活指数详细描述
  String txt;

  /// 预报日期，例如2017-12-30
  String date;

  static Lifestyle fromMap(Map<String, dynamic> map) {
    Lifestyle lifestyleListBean = Lifestyle();
    lifestyleListBean.type = map['type'];
    lifestyleListBean.brf = map['brf'];
    lifestyleListBean.txt = map['txt'];
    lifestyleListBean.date = map['date'];
    return lifestyleListBean;
  }

  static List<Lifestyle> fromMapList(dynamic mapList) {
    List<Lifestyle> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
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

  String date;
  String mr;
  String ms;
  String sr;
  String ss;

  static SunriseSunset fromMap(Map<String, dynamic> map) {
    SunriseSunset sunrise_sunset = SunriseSunset();
    sunrise_sunset.date = map['date'];
    sunrise_sunset.mr = map['mr'];
    sunrise_sunset.ms = map['ms'];
    sunrise_sunset.sr = map['sr'];
    sunrise_sunset.ss = map['ss'];
    return sunrise_sunset;
  }

  static List<SunriseSunset> fromMapList(dynamic mapList) {
    List<SunriseSunset> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

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
