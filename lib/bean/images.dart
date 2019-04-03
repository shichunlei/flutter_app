class Images {
  String small;
  String large;
  String medium;

  static Images fromMap(Map<String, dynamic> map) {
    Images imagesBean = Images();
    imagesBean.small = map['small'];
    imagesBean.large = map['large'];
    imagesBean.medium = map['medium'];
    return imagesBean;
  }

  static List<Images> fromMapList(dynamic mapList) {
    List<Images> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
