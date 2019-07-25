import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/bean/celebrity.dart';
import 'package:flutter_app/bean/contact.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/image.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/bean/photos.dart';
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
  Article article;

  /// 相册
  List<Photos> photos;
  List<Works> works;

  /// 影人
  Celebrity celebrity;

  /// 影评
  List<Reviews> reviews;

  /// 短评
  List<Reviews> comments;

  /// 天气
  List<HeWeather> heWeather;

  /// 联系人
  List<Contact> contacts;

  List<ImageModal> images;

  static Result fromMap(Map<String, dynamic> map) {
    Result result = Result();
    result.title = map['title'] == null ? "" : map['title'];
    result.count = map['count'];
    result.start = map['start'];
    result.total = map['total'];
    result.contacts =
        map['results'] == null ? [] : Contact.fromMapList(map['results']);
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
    result.article = map['data'] == null ? null : Article.fromMap(map['data']);

    result.heWeather = List()
      ..addAll(
          (map['HeWeather6'] as List ?? []).map((o) => HeWeather.fromMap(o)));

    result.images =
        map['list'] == null ? [] : ImageModal.fromMapList(map['list']);
    return result;
  }
}
