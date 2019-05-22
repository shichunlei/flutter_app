class ImageModal {
  /**
   * id : "0d16718c0f0153349ad49484b1ee8b1e"
   * src : "1"
   * width : "1456"
   * height : "1456"
   * thumb : "https://p3.ssl.qhimgs1.com/t01f325126874820e13.jpg"
   * grpcnt : "0"
   * grpmd5 : false
   * type : 0
   * index : 0
   */

  String id;
  String src;
  double width;
  double height;
  String thumb;
  String grpcnt;
  bool grpmd5;
  int type;
  int index;

  static ImageModal fromMap(Map<String, dynamic> map) {
    ImageModal image = ImageModal();
    image.id = map['id'];
    image.src = map['src'];
    image.width = double.parse(map['width']);
    image.height = double.parse(map['height']);
    image.thumb = map['thumb'];
    image.grpcnt = map['grpcnt'];
    image.grpmd5 = map['grpmd5'];
    image.type = map['type'];
    image.index = map['index'];
    return image;
  }

  static List<ImageModal> fromMapList(dynamic mapList) {
    if (mapList == null) return [];
    List<ImageModal> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
