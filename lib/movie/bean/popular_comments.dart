import 'package:flutter_app/movie/bean/author.dart';
import 'package:flutter_app/movie/bean/rating.dart';

class PopularComments {
  String subject_id;
  String content;
  String created_at;
  String id;
  int useful_count;
  Author author;
  Rating rating;

  static PopularComments fromMap(Map<String, dynamic> map) {
    PopularComments popular_comments = PopularComments();
    popular_comments.subject_id = map['subject_id'];
    popular_comments.content = map['content'];
    popular_comments.created_at = map['created_at'];
    popular_comments.id = map['id'];
    popular_comments.useful_count = map['useful_count'];
    popular_comments.author = Author.fromMap(map['author']);
    popular_comments.rating = Rating.fromMap(map['rating']);
    return popular_comments;
  }

  static List<PopularComments> fromMapList(dynamic mapList) {
    List<PopularComments> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{subject_id: $subject_id, content: $content, created_at: $created_at, id: $id, useful_count: $useful_count, author: $author, rating: $rating}';
  }
}
