import 'package:flutter_app/baixing_life/db/goods_provider.dart';

class Baixing {
  AdvertesPicture advertesPicture;
  ShopInfo shopInfo;
  AdvertesPicture toShareCode;
  List<Category> category;
  List<Goods> recommend;
  List<Goods> slides;
  List<Goods> reservationGoods;

  List<FloorBean> floors;

  List<AdvertesPicture> ads;

  static Baixing fromMap(Map<String, dynamic> map) {
    Baixing baixing = Baixing();
    baixing.reservationGoods = List()
      ..addAll(
          (map['reservationGoods'] as List ?? []).map((o) => Goods.fromMap(o)));
    baixing.advertesPicture = AdvertesPicture.fromMap(map['advertesPicture']);
    baixing.shopInfo = ShopInfo.fromMap(map['shopInfo']);
    baixing.toShareCode = AdvertesPicture.fromMap(map['toShareCode']);
    baixing.category = List()
      ..addAll((map['category'] as List ?? []).map((o) => Category.fromMap(o)));

    baixing.recommend = List()
      ..addAll((map['recommend'] as List ?? []).map((o) => Goods.fromMap(o)));
    baixing.slides = List()
      ..addAll((map['slides'] as List ?? []).map((o) => Goods.fromMap(o)));

    FloorBean floorBean1 = FloorBean();
    floorBean1.floorName = map['floorName']['floor1'];
    floorBean1.floorPic = AdvertesPicture.fromMap(map['floor1Pic']);
    floorBean1.floor = List()
      ..addAll((map['floor1'] as List ?? []).map((o) => Goods.fromMap(o)));

    print(floorBean1.toString());

    FloorBean floorBean2 = FloorBean();
    floorBean2.floorName = map['floorName']['floor2'];
    floorBean2.floorPic = AdvertesPicture.fromMap(map['floor2Pic']);
    floorBean2.floor = List()
      ..addAll((map['floor2'] as List ?? []).map((o) => Goods.fromMap(o)));

    print(floorBean2.toString());

    FloorBean floorBean3 = FloorBean();
    floorBean3.floorName = map['floorName']['floor3'];
    floorBean3.floorPic = AdvertesPicture.fromMap(map['floor3Pic']);
    floorBean3.floor = List()
      ..addAll((map['floor3'] as List ?? []).map((o) => Goods.fromMap(o)));

    print(floorBean3.toString());

    baixing.floors = [floorBean1, floorBean2, floorBean3];

    AdvertesPicture integralMallPic =
        AdvertesPicture.fromMap(map['integralMallPic']);
    AdvertesPicture newUser = AdvertesPicture.fromMap(map['newUser']);
    AdvertesPicture saoma = AdvertesPicture.fromMap(map['saoma']);

    baixing.ads = [saoma, integralMallPic, newUser];

    return baixing;
  }

  Map toJson() => {
        "slides": slides,
        "shopInfo": shopInfo,
        "toShareCode": toShareCode,
        "recommend": recommend,
        "advertesPicture": advertesPicture,
        "floors": floors,
        "ads": ads,
        "category": category,
        "reservationGoods": reservationGoods,
      };

  @override
  String toString() {
    return 'Baixing{advertesPicture: $advertesPicture, shopInfo: $shopInfo, toShareCode: $toShareCode, category: $category, recommend: $recommend, slides: $slides, reservationGoods: $reservationGoods, floors: $floors, ads: $ads}';
  }
}

class FloorBean {
  String floorName;
  AdvertesPicture floorPic;
  List<Goods> floor;

  @override
  String toString() {
    return 'FloorBean{floorName: $floorName, floorPic: $floorPic, floor: $floor}';
  }
}

/// leaderImage : "http://images.baixingliangfan.cn/leaderImage/20181121/20181121133310_65.jpg"
/// leaderPhone : "03936188699"

class ShopInfo {
  String leaderImage;
  String leaderPhone;

  static ShopInfo fromMap(Map<String, dynamic> map) {
    ShopInfo shopInfoBean = ShopInfo();
    shopInfoBean.leaderImage = map['leaderImage'];
    shopInfoBean.leaderPhone = map['leaderPhone'];
    return shopInfoBean;
  }

  static List<ShopInfo> fromMapList(dynamic mapList) {
    List<ShopInfo> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Goods {
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
  int number;

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

  Goods({
    this.goodsId,
    this.comPic,
    this.shopId,
    this.goodsName,
    this.oriPrice,
    this.presentPrice,
    this.number,
    this.isChecked,
  });

  static Goods fromJson(Map<String, dynamic> map) {
    Goods goods = Goods();
    goods.goodsId = map['${GoodsProvider.COLUMN_GOODS_ID}'];
    goods.comPic = map['${GoodsProvider.COLUMN_IMAGE}'];
    goods.shopId = map['${GoodsProvider.COLUMN_SHOP_ID}'];
    goods.goodsName = map['${GoodsProvider.COLUMN_NAME}'];
    goods.number = map['${GoodsProvider.COLUMN_NUM}'];
    goods.oriPrice = map['${GoodsProvider.COLUMN_ORI_PRICE}'];
    goods.presentPrice = map['${GoodsProvider.COLUMN_PRICE}'];
    goods.isChecked = map['${GoodsProvider.COLUMN_IS_CHECK}'];
    return goods;
  }

  Map<String, dynamic> toMap() => {
        '${GoodsProvider.COLUMN_GOODS_ID}': goodsId,
        '${GoodsProvider.COLUMN_IMAGE}': comPic,
        '${GoodsProvider.COLUMN_SHOP_ID}': shopId,
        '${GoodsProvider.COLUMN_NAME}': goodsName,
        '${GoodsProvider.COLUMN_NUM}': number,
        '${GoodsProvider.COLUMN_ORI_PRICE}': oriPrice,
        '${GoodsProvider.COLUMN_PRICE}': presentPrice,
        '${GoodsProvider.COLUMN_IS_CHECK}': isChecked,
      };

  @override
  String toString() {
    return '{goodsId: $goodsId, comPic: $comPic, shopId: $shopId, goodsName: $goodsName, number: $number, oriPrice: $oriPrice, presentPrice: $presentPrice, isChecked: $isChecked}';
  }
}

class GoodsInfo {
  AdvertesPicture advertesPicture;
  Goods goodInfo;
  List<GoodComment> goodComments;

  static GoodsInfo fromMap(Map<String, dynamic> map) {
    GoodsInfo info = GoodsInfo();
    info.goodComments = List()
      ..addAll((map['goodComments'] as List ?? [])
          .map((o) => GoodComment.fromMap(o)));

    info.advertesPicture = map['advertesPicture'] == null
        ? null
        : AdvertesPicture.fromMap(map['advertesPicture']);
    info.goodInfo = Goods.fromMap(map['goodInfo']);
    return info;
  }

  static List<GoodsInfo> fromMapList(dynamic mapList) {
    List<GoodsInfo> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GoodComment {
  int score;
  String comments;
  String userName;
  int discussTime;

  static GoodComment fromMap(Map<String, dynamic> map) {
    GoodComment comment = GoodComment();
    comment.score = map['SCORE'];
    comment.comments = map['comments'];
    comment.userName = map['userName'];
    comment.discussTime = map['discussTime'];
    return comment;
  }
}

/// PICTURE_ADDRESS : "http://images.baixingliangfan.cn/advertesPicture/20190131/20190131165032_5788.png"
/// TO_PLACE : "1"

class AdvertesPicture {
  String pictureAddress;
  String toPlace;

  static AdvertesPicture fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AdvertesPicture advertesPic = AdvertesPicture();
    advertesPic.pictureAddress = map['PICTURE_ADDRESS'];
    advertesPic.toPlace = map['TO_PLACE'];
    return advertesPic;
  }

  Map toJson() => {
        "PICTURE_ADDRESS": pictureAddress,
        "TO_PLACE": toPlace,
      };
}

class Category {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  String comments;
  List<Category> bxMallSubDto;

  String mallSubId;
  String mallSubName;

  static Category fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Category categoryBean = Category();
    categoryBean.mallCategoryId = map['mallCategoryId'];
    categoryBean.mallCategoryName = map['mallCategoryName'];
    categoryBean.bxMallSubDto = List()
      ..addAll(
          (map['bxMallSubDto'] as List ?? []).map((o) => Category.fromMap(o)));
    categoryBean.comments = map['comments'];
    categoryBean.image = map['image'];
    categoryBean.mallSubId = map['mallSubId'];
    categoryBean.mallSubName = map['mallSubName'];
    return categoryBean;
  }

  Map toJson() => {
        "mallCategoryId": mallCategoryId,
        "mallCategoryName": mallCategoryName,
        "bxMallSubDto": bxMallSubDto,
        "comments": comments,
        "image": image,
        "mallSubId": mallSubId,
        "mallSubName": mallSubName,
      };
}
