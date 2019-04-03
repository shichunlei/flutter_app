import 'package:flutter_app/bean/author.dart';
import 'package:flutter_app/bean/rating.dart';

class Reviews {
  String created_at;
  String title;
  String updated_at;
  String share_url;
  String summary;
  String content;
  String alt;
  String id;
  String subject_id;
  int useful_count;
  int useless_count;
  int comments_count;
  Author author;
  Rating rating;

  static Reviews fromMap(Map<String, dynamic> map) {
    Reviews reviews = new Reviews();
    reviews.created_at = map['created_at'];
    reviews.title = map['title'];
    reviews.updated_at = map['updated_at'];
    reviews.share_url = map['share_url'];
    reviews.summary = map['summary'];
    reviews.content = map['content'];
    reviews.alt = map['alt'];
    reviews.id = map['id'];
    reviews.subject_id = map['subject_id'];
    reviews.useful_count = map['useful_count'];
    reviews.useless_count = map['useless_count'];
    reviews.comments_count = map['comments_count'];
    reviews.author =
        map['author'] == null ? null : Author.fromMap(map['author']);
    reviews.rating =
        map['rating'] == null ? null : Rating.fromMap(map['rating']);
    return reviews;
  }

  static List<Reviews> fromMapList(dynamic mapList) {
    List<Reviews> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
