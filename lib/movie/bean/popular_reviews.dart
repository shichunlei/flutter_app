import 'package:flutter_app/movie/bean/author.dart';
import 'package:flutter_app/movie/bean/rating.dart';

class PopularReviews {
  String title;
  String subject_id;
  String summary;
  String alt;
  String id;
  Author author;
  Rating rating;

  static PopularReviews fromMap(Map<String, dynamic> map) {
    PopularReviews popular_reviewsListBean = PopularReviews();
    popular_reviewsListBean.title = map['title'];
    popular_reviewsListBean.subject_id = map['subject_id'];
    popular_reviewsListBean.summary = map['summary'];
    popular_reviewsListBean.alt = map['alt'];
    popular_reviewsListBean.id = map['id'];
    popular_reviewsListBean.author = Author.fromMap(map['author']);
    popular_reviewsListBean.rating = Rating.fromMap(map['rating']);
    return popular_reviewsListBean;
  }

  static List<PopularReviews> fromMapList(dynamic mapList) {
    List<PopularReviews> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
