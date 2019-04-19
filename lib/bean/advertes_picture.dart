class AdvertesPicture {
  /**
   * PICTURE_ADDRESS : "http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg"
   * TO_PLACE : "1"
   */

  String pictureAddress;
  String toPlace;

  static AdvertesPicture fromMap(Map<String, dynamic> map) {
    AdvertesPicture advertes_picture = AdvertesPicture();
    advertes_picture.pictureAddress = map['PICTURE_ADDRESS'];
    advertes_picture.toPlace = map['TO_PLACE'];
    return advertes_picture;
  }

  static List<AdvertesPicture> fromMapList(dynamic mapList) {
    List<AdvertesPicture> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'AdvertesPicture{pictureAddress: $pictureAddress, toPlace: $toPlace}';
  }
}
