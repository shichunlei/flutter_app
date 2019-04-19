import 'package:flutter_app/bean/advertes_picture.dart';
import 'package:flutter_app/bean/goods.dart';

class GoodsInfo {
  /**
   * advertesPicture : {"PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg","TO_PLACE":"1"}
   * goodInfo : {"image5":"","amount":10,"image3":"","image4":"","goodsId":"3b792c26aaca48f48d9ad13de36feb69","isOnline":"yes","image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190128/20190128203813_31.jpg","image2":"","goodsSerialNumber":"6953296962252","oriPrice":59,"presentPrice":49,"comPic":"http://images.baixingliangfan.cn/compressedPic/20190128203813_31.jpg","state":1,"shopId":"402880e860166f3c0160167897d60002","goodsName":"稻香社五常大米绿钻5kg","goodsDetail":""}
   * goodComments : []
   */

  AdvertesPicture advertesPicture;
  Goods goodInfo;
  List<dynamic> goodComments;

  static GoodsInfo fromMap(Map<String, dynamic> map) {
    GoodsInfo goods_info = GoodsInfo();
    goods_info.goodComments = map['goodComments'];
    goods_info.advertesPicture = map['advertesPicture'] == null
        ? []
        : AdvertesPicture.fromMap(map['advertesPicture']);
    goods_info.goodInfo = Goods.fromMap(map['goodInfo']);
    return goods_info;
  }

  static List<GoodsInfo> fromMapList(dynamic mapList) {
    List<GoodsInfo> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
