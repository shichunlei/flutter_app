import 'package:flutter_app/movie/bean/avatars.dart';

class Writers {
  String name_en;
  String name;
  String alt;
  String id;
  Avatars avatars;

  static Writers fromMap(Map<String, dynamic> map) {
    Writers writersListBean = Writers();
    writersListBean.name_en = map['name_en'];
    writersListBean.name = map['name'];
    writersListBean.alt = map['alt'];
    writersListBean.id = map['id'];
    writersListBean.avatars = Avatars.fromMap(map['avatars']);
    return writersListBean;
  }

  static List<Writers> fromMapList(dynamic mapList) {
    List<Writers> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{name_en: $name_en, name: $name, alt: $alt, id: $id, avatars: $avatars}';
  }
}
