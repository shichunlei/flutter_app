import 'package:flutter_app/bean/movie.dart';

class Works {
  Movie subject;
  List<String> roles;

  static Works fromMap(Map<String, dynamic> map) {
    Works works = Works();
    works.subject = Movie.fromMap(map['subject']);

    List<dynamic> roles = map['roles'] == null ? [] : map['roles'];
    works.roles = List();
    works.roles.addAll(roles.map((o) => o.toString()));

    return works;
  }

  static List<Works> fromMapList(dynamic mapList) {
    List<Works> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
