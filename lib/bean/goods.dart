import 'package:flutter_app/baixing_life/db/goods_provider.dart';

class Goods {
  /**
   * image5 : ""
   * image3 : ""
   * image4 : ""
   * goodsId : "3b792c26aaca48f48d9ad13de36feb69"
   * isOnline : "yes"
   * image1 : "http://images.baixingliangfan.cn/shopGoodsImg/20190128/20190128203813_31.jpg"
   * image2 : ""
   * goodsSerialNumber : "6953296962252"
   * comPic : "http://images.baixingliangfan.cn/compressedPic/20190128203813_31.jpg"
   * shopId : "402880e860166f3c0160167897d60002"
   * goodsName : "稻香社五常大米绿钻5kg"
   * goodsDetail : ""
   * amount : 10
   * oriPrice : 59
   * presentPrice : 49
   * state : 1
   */

  String goodsId;
  String isOnline;
  String goodsSerialNumber;
  String comPic;
  String shopId;
  String goodsName;
  String goodsDetail;
  int amount;
  num oriPrice;
  num presentPrice;
  int state;

  List<String> pics;

  int isChecked;

  static Goods fromMap(Map<String, dynamic> map) {
    Goods goods = Goods();
    goods.goodsId = map['goodsId'];
    goods.isOnline = map['isOnline'];
    goods.goodsSerialNumber = map['goodsSerialNumber'];
    goods.comPic = map['comPic'] == null ? map['image'] : map['comPic'];
    goods.shopId = map['shopId'] == null ? '' : map['shopId'];
    goods.goodsName = map['goodsName'] == null ? map['name'] : map['goodsName'];
    goods.goodsDetail = map['goodsDetail'];
    goods.amount = map['amount'];
    goods.oriPrice = map['oriPrice'] == null ? map['price'] : map['oriPrice'];
    goods.presentPrice =
        map['presentPrice'] == null ? map['mallPrice'] : map['presentPrice'];
    goods.state = map['state'];
    goods.pics = [];
    if (null != map['image1'] && '' != map['image1']) {
      goods.pics.add(map['image1']);
    }
    if (null != map['image2'] && '' != map['image2']) {
      goods.pics.add(map['image2']);
    }
    if (null != map['image3'] && '' != map['image3']) {
      goods.pics.add(map['image3']);
    }
    if (null != map['image4'] && '' != map['image4']) {
      goods.pics.add(map['image4']);
    }
    if (null != map['image5'] && '' != map['image5']) {
      goods.pics.add(map['image5']);
    }
    return goods;
  }

  static List<Goods> fromMapList(dynamic mapList) {
    List<Goods> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Goods fromJson(Map<String, dynamic> map) {
    Goods goods = Goods();
    goods.goodsId = map['goods_id'];
    goods.comPic = map['image'];
    goods.shopId = map['shop_id'];
    goods.goodsName = map['name'];
    goods.amount = map['number'];
    goods.oriPrice = map['ori_price'];
    goods.presentPrice = map['price'];
    goods.isChecked = map['is_checked'];
    return goods;
  }

  Map<String, dynamic> toMap() => {
        '${GoodsProvider.COLUMN_GOODS_ID}': goodsId,
        '${GoodsProvider.COLUMN_IMAGE}': comPic,
        '${GoodsProvider.COLUMN_SHOP_ID}': shopId,
        '${GoodsProvider.COLUMN_NAME}': goodsName,
        '${GoodsProvider.COLUMN_NUM}': amount,
        '${GoodsProvider.COLUMN_ORI_PRICE}': oriPrice,
        '${GoodsProvider.COLUMN_PRICE}': presentPrice,
        '${GoodsProvider.COLUMN_IS_CHECK}': isChecked,
      };

  @override
  String toString() {
    return '{goodsId: $goodsId, comPic: $comPic, shopId: $shopId, goodsName: $goodsName, amount: $amount, oriPrice: $oriPrice, presentPrice: $presentPrice, isChecked: $isChecked}';
  }
}
