class ImageModal {
  String id;
  String src;
  double width;
  double height;
  String thumb;

//  String grpCnt;
  bool grpMd5;
  int type;
  int index;

  static ImageModal fromMap(Map<String, dynamic> map) {
    ImageModal image = ImageModal();
    image.id = map['id'];
    image.src = map['src'];
    image.width = double.parse(map['width']);
    image.height = double.parse(map['height']);
    image.thumb = map['thumb'];
//    image.grpCnt = map['grpcnt'];
    image.grpMd5 = map['grpmd5'];
    image.type = map['type'];
    image.index = map['index'];
    return image;
  }
}
