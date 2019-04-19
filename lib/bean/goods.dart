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

  String image5;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
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

  static Goods fromMap(Map<String, dynamic> map) {
    Goods goods = Goods();
    goods.image5 = map['image5'];
    goods.image3 = map['image3'];
    goods.image4 = map['image4'];
    goods.goodsId = map['goodsId'];
    goods.isOnline = map['isOnline'];
    goods.image1 = map['image1'];
    goods.image2 = map['image2'];
    goods.goodsSerialNumber = map['goodsSerialNumber'];
    goods.comPic = map['comPic'] == null ? map['image'] : map['comPic'];
    goods.shopId = map['shopId'];
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
}
