import 'package:flutter_app/movie/bean/celebrity.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/bean/reviews.dart';
import 'package:flutter_app/movie/bean/works.dart';

class Result {
  String title;
  int count;
  int start;
  int total;
  List<Movie> subjects;
  Movie subject;

  /// 相册
  List<Photos> photos;
  List<Works> works;

  /// 影人
  Celebrity celebrity;

  /// 影评
  List<Reviews> reviews;

  /// 短评
  List<Reviews> comments;

  static Result fromMap(Map<String, dynamic> map) {
    Result result = Result();
    result.title = map['title'] == null ? "" : map['title'];
    result.count = map['count'];
    result.start = map['start'];
    result.total = map['total'];
    result.reviews =
        map['reviews'] == null ? [] : Reviews.fromMapList(map['reviews']);
    result.comments =
        map['comments'] == null ? [] : Reviews.fromMapList(map['comments']);
    result.subjects =
        map['subjects'] == null ? [] : Movie.fromMapList(map['subjects']);
    result.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    result.works = map['works'] == null ? [] : Works.fromMapList(map['works']);
    result.celebrity =
        map['celebrity'] == null ? null : Celebrity.fromMap(map['celebrity']);
    result.subject =
        map['subject'] == null ? null : Movie.fromMap(map['subject']);
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
