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
    DailyForecast daily_forecast = DailyForecast();
    daily_forecast.cond_code_d =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_d']}.png";
    daily_forecast.cond_code_n =
        "https://cdn.heweather.com/cond_icon/${map['cond_code_n']}.png";
    daily_forecast.cond_txt_d = map['cond_txt_d'];
    daily_forecast.cond_txt_n = map['cond_txt_n'];
    daily_forecast.date = map['date'];
    daily_forecast.hum = map['hum'];
    daily_forecast.mr = map['mr'];
    daily_forecast.ms = map['ms'];
    daily_forecast.pcpn = map['pcpn'];
    daily_forecast.pop = map['pop'];
    daily_forecast.pres = map['pres'];
    daily_forecast.sr = map['sr'];
    daily_forecast.ss = map['ss'];
    daily_forecast.tmp_max = map['tmp_max'];
    daily_forecast.tmp_min = map['tmp_min'];
    daily_forecast.uv_index = map['uv_index'];
    daily_forecast.vis = map['vis'];
    daily_forecast.wind_deg = map['wind_deg'];
    daily_forecast.wind_dir = map['wind_dir'];
    daily_forecast.wind_sc = map['wind_sc'];
    daily_forecast.wind_spd = map['wind_spd'];
    return daily_forecast;
  }

  static List<DailyForecast> fromMapList(dynamic mapList) {
    List<DailyForecast> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
