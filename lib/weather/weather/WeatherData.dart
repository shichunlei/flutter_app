import 'dart:convert';

class WeatherData {
  String cloud; // 云量
  String cond_code; // 实况天气状况代码
  String cond_txt; // 实况天气状况描述
  String fl; // 体感温度
  String hum; // 相对湿度
  String pcpn; // 降水量
  String pres; // 大气压强
  String tmp; // 温度
  String vis; // 能见度，默认单位：公里
  String wind_deg; // 风向360角度
  String wind_dir; // 风向
  String wind_sc; // 风力
  String wind_spd; // 风速

  WeatherData({
    this.cloud,
    this.cond_code,
    this.cond_txt,
    this.fl,
    this.hum,
    this.pcpn,
    this.pres,
    this.tmp,
    this.vis,
    this.wind_deg,
    this.wind_dir,
    this.wind_sc,
    this.wind_spd,
  });

  static WeatherData decodeData(String jsonData) {
    WeatherData weather = WeatherData();

    var data = json.decode(jsonData);

    print(data.toString());

    if (data['HeWeather6'][0]['status'] == 'ok') {
      var results = data['HeWeather6'][0]['now'];
      weather = fromMap(results);
    }
    return weather;
  }

  static WeatherData fromMap(Map map) {
    return WeatherData(
      cloud: map['cloud'],
      cond_code: map.isEmpty
          ? ""
          : "https://cdn.heweather.com/cond_icon/${map['cond_code']}.png",
      cond_txt: map['cond_txt'],
      fl: map['fl'],
      hum: "湿度 ${map['hum']}%",
      pcpn: map['pcpn'],
      pres: map['pres'],
      tmp: "${map['tmp']}°",
      vis: map['vis'],
      wind_deg: map['wind_deg'],
      wind_dir: map['wind_dir'],
      wind_sc: map['wind_sc'],
      wind_spd: map['wind_spd'],
    );
  }
}
