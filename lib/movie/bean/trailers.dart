class Trailers {
  String medium;
  String title;
  String subject_id;
  String alt;
  String small;
  String resource_url;
  String id;

  static Trailers fromMap(Map<String, dynamic> map) {
    Trailers trailersListBean = Trailers();
    trailersListBean.medium = map['medium'];
    trailersListBean.title = map['title'];
    trailersListBean.subject_id = map['subject_id'];
    trailersListBean.alt = map['alt'];
    trailersListBean.small = map['small'];
    trailersListBean.resource_url = map['resource_url'];
    trailersListBean.id = map['id'];
    return trailersListBean;
  }

  static List<Trailers> fromMapList(dynamic mapList) {
    List<Trailers> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
