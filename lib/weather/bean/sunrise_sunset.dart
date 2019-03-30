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
