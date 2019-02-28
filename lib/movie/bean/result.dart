import 'package:flutter_app/movie/bean/movie.dart';

class Result{
  String title;
  int count;
  int start;
  int total;
  List<Movie> subjects;

  static Result fromMap(Map<String, dynamic> map) {
    Result result = Result();
    result.title = map['title'];
    result.count = map['count'];
    result.start = map['start'];
    result.total = map['total'];
    result.subjects = Movie.fromMapList(map['subjects']);
    return result;
  }

  static List<Result> fromMapList(dynamic mapList) {
    List<Result> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}