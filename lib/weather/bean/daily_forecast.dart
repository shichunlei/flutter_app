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