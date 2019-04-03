class Bloopers {
  String medium;
  String title;
  String subject_id;
  String alt;
  String small;
  String resource_url;
  String id;

  static Bloopers fromMap(Map<String, dynamic> map) {
    Bloopers bloopersListBean = Bloopers();
    bloopersListBean.medium = map['medium'];
    bloopersListBean.title = map['title'];
    bloopersListBean.subject_id = map['subject_id'];
    bloopersListBean.alt = map['alt'];
    bloopersListBean.small = map['small'];
    bloopersListBean.resource_url = map['resource_url'];
    bloopersListBean.id = map['id'];
    return bloopersListBean;
  }

  static List<Bloopers> fromMapList(dynamic mapList) {
    List<Bloopers> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Bloopers{medium: $medium, title: $title, subject_id: $subject_id, alt: $alt, small: $small, resource_url: $resource_url, id: $id}';
  }
}
