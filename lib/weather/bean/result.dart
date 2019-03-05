import 'package:flutter_app/weather/bean/he_weather.dart';

class Result {
  List<HeWeather> HeWeather6;

  static Result fromMap(Map<String, dynamic> map) {
    Result he_weather = Result();
    he_weather.HeWeather6 = HeWeather.fromMapList(map['HeWeather6']);
    return he_weather;
  }

  static List<Result> fromMapList(dynamic mapList) {
    List<Result> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
