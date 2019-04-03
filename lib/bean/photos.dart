import 'package:flutter_app/bean/author.dart';

class Photos {
  String thumb;
  String icon;
  String created_at;
  String album_id;
  String cover;
  String id;
  String prev_photo;
  String album_url;
  String image;
  String alt;
  String album_title;
  String next_photo;
  String subject_id;
  String desc;
  int photos_count;
  int comments_count;
  int recs_count;
  int position;
  Author author;

  static Photos fromMap(Map<String, dynamic> map) {
    Photos photos = Photos();
    photos.thumb = map['thumb'];
    photos.icon = map['icon'];
    photos.created_at = map['created_at'];
    photos.album_id = map['album_id'];
    photos.cover = map['cover'];
    photos.id = map['id'];
    photos.prev_photo = map['prev_photo'];
    photos.album_url = map['album_url'];
    photos.image = map['image'];
    photos.alt = map['alt'];
    photos.album_title = map['album_title'];
    photos.next_photo = map['next_photo'];
    photos.subject_id = map['subject_id'];
    photos.desc = map['desc'];
    photos.photos_count = map['photos_count'];
    photos.comments_count = map['comments_count'];
    photos.recs_count = map['recs_count'];
    photos.position = map['position'];
    photos.author =
        map['author'] == null ? null : Author.fromMap(map['author']);
    return photos;
  }

  static List<Photos> fromMapList(dynamic mapList) {
    List<Photos> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Photos{thumb: $thumb, icon: $icon, created_at: $created_at, album_id: $album_id, cover: $cover, id: $id, prev_photo: $prev_photo, album_url: $album_url, image: $image, alt: $alt, album_title: $album_title, next_photo: $next_photo, subject_id: $subject_id, desc: $desc, photos_count: $photos_count, comments_count: $comments_count, recs_count: $recs_count, position: $position, author: $author}';
  }
}
