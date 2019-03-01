import 'package:flutter_app/movie/bean/avatars.dart';

class Directors {
  String name_en;
  String name;
  String alt;
  String id;
  Avatars avatars;

  static Directors fromMap(Map<String, dynamic> map) {
    Directors directorsListBean = Directors();
    directorsListBean.name_en = map['name_en'];
    directorsListBean.name = map['name'];
    directorsListBean.alt = map['alt'];
    directorsListBean.id = map['id'];
    directorsListBean.avatars = Avatars.fromMap(map['avatars']);
    return directorsListBean;
  }

  static List<Directors> fromMapList(dynamic mapList) {
    List<Directors> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Directors{name_en: $name_en, name: $name, alt: $alt, id: $id, avatars: $avatars}';
  }
}
