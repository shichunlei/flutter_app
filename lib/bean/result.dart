import 'package:flutter_app/bean/index.dart';

class Result {
  String title;
  int count;
  int start;
  int total;

  /// 天气
  List<HeWeather> heWeather;

  /// 联系人
  List<ContactBean> contacts;

  List<ImageModal> images;

  static Result fromMap(Map<String, dynamic> map) {
    Result result = Result();
    result.title = map['title'] == null ? "" : map['title'];
    result.count = map['count'];
    result.start = map['start'];
    result.total = map['total'];
    result.contacts = []..addAll((map['results'] as List ?? []).map((o) => ContactBean.fromMap(o)));

    result.heWeather = []..addAll((map['HeWeather6'] as List ?? []).map((o) => HeWeather.fromMap(o)));

    result.images = (map['list'] as List ?? []).map((e) => ImageModal.fromMap(e)).toList();
    return result;
  }
}
