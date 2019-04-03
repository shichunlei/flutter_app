
import 'package:flutter_app/bean/avatars.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/bean/works.dart';

class Celebrity {
  String website;
  String mobile_url;
  String name;
  String name_en;
  String gender;
  String summary;
  String birthday;
  String alt;
  String born_place;
  String constellation;
  String id;
  Avatars avatars;
  List<String> aka;
  List<String> aka_en;
  List<String> professions;
  List<Photos> photos;
  List<Works> works;

  static Celebrity fromMap(Map<String, dynamic> map) {
    Celebrity celebrity = Celebrity();
    celebrity.website = map['website'];
    celebrity.mobile_url = map['mobile_url'];
    celebrity.name = map['name'];
    celebrity.name_en = map['name_en'];
    celebrity.gender = map['gender'];
    celebrity.summary = map['summary'];
    celebrity.birthday = map['birthday'];
    celebrity.alt = map['alt'];
    celebrity.born_place = map['born_place'];
    celebrity.constellation = map['constellation'];
    celebrity.id = map['id'];
    celebrity.avatars =
        map['avatars'] == null ? null : Avatars.fromMap(map['avatars']);
    celebrity.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    celebrity.works =
        map['works'] == null ? [] : Works.fromMapList(map['works']);

    List<dynamic> aka = map['aka'] == null ? [] : map['aka'];
    celebrity.aka = List();
    celebrity.aka.addAll(aka.map((o) => o.toString()));

    List<dynamic> aka_en = map['aka_en'] == null ? [] : map['aka_en'];
    celebrity.aka_en = List();
    celebrity.aka_en.addAll(aka_en.map((o) => o.toString()));

    List<dynamic> professions =
        map['professions'] == null ? [] : map['professions'];
    celebrity.professions = List();
    celebrity.professions.addAll(professions.map((o) => o.toString()));

    return celebrity;
  }

  static List<Celebrity> fromMapList(dynamic mapList) {
    List<Celebrity> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{website: $website, mobile_url: $mobile_url, name: $name, name_en: $name_en, gender: $gender, summary: $summary, birthday: $birthday, alt: $alt, born_place: $born_place, constellation: $constellation, id: $id, avatars: $avatars, aka: $aka, aka_en: $aka_en, professions: $professions, photos: $photos, works: $works}';
  }
}
