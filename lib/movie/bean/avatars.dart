class Avatars {
  String small;
  String large;
  String medium;

  static Avatars fromMap(Map<String, dynamic> map) {
    Avatars avatarsBean = Avatars();
    avatarsBean.small = map != null ? map['small'] : "";
    avatarsBean.large = map != null ? map['large'] : "";
    avatarsBean.medium = map != null ? map['medium'] : "";
    return avatarsBean;
  }

  static List<Avatars> fromMapList(dynamic mapList) {
    List<Avatars> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{small: $small, large: $large, medium: $medium}';
  }
}
