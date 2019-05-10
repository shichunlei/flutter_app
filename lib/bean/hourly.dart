import 'package:flutter_app/utils/time_utils.dart';

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
    String _time = TimeUtils.getDateStrByTimeStr("${map['time']}:00",
        format: DateFormat.HOUR_MINUTE);

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
    hourly.cond_code =
        "https://cdn.heweather.com/cond_icon/${map['cond_code']}$n.png";
    hourly.cond_txt = map['cond_txt'];
    hourly.dew = map['dew'];
    hourly.hum = map['hum'];
    hourly.pop = map['pop'];
    hourly.pres = map['pres'];
    hourly.time = _time;
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
