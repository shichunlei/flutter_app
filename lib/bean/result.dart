import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/bean/celebrity.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/bean/poetry.dart';
import 'package:flutter_app/bean/reviews.dart';
import 'package:flutter_app/bean/works.dart';

class Result {
  String title;
  int count;
  int start;
  int total;
  List<Movie> subjects;
  Movie subject;

  /// 每日一文
  Article data;

  /// 随机诗词
  Poetry result;

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
    result.result =
        map['result'] == null ? null : Poetry.fromMap(map['result']);
    result.data = map['data'] == null ? null : Article.fromMap(map['data']);
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
