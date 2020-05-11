import 'package:flutter_app/baixing_life/db/goods_provider.dart';
import 'package:flutter_app/utils/date_format.dart';

class Baixing {
  AdvertesPicture advertesPicture;
  ShopInfo shopInfo;
  AdvertesPicture toShareCode;
  List<GoodsCategory> category;
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
      ..addAll(
          (map['category'] as List ?? []).map((o) => GoodsCategory.fromMap(o)));

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

/// leaderPhone : "03936188699"
/// shopName : "理想城店"
/// shopID : "2c9f6c946fffd4f301700348f15300df"
/// shopAddress : "黄河路与盘锦路交叉口西北角"
/// distance : 780031.0
/// shopImage : "https://images.baixingliangfan.cn/common/20200202/20200202081818_2245.jpg"
/// goodsList : [{"SELL_MONEY":0.0,"PICTURE_COMPERSS_PATH":"https://images.baixingliangfan.cn/compressedPic/20200419100837_8840.jpg","NEED_INTEGRAL":50,"GOOD_ID":"60c0091884bc4ab98de5ce92dda940bc","NAME":"4.18百姓会员日感恩大回馈·减50积分送20元感恩礼券"}]
/// activityInfo : {"ACTIVITY_NAME":"4.18会员感恩礼 · 减50积分送20元感恩礼券","BEGINTIME":1587052800000,"LIMIT_AMOUNT":1,"END_TIME":"2020-04-26","IMAGE":"https://images.baixingliangfan.cn/integralGoodsPicture/20200419/20200419101004_1888.jpg","BEGIN_TIME":"2020-04-17","PARTICIPATE_TIMES":3,"ENDTIME":1587916799000,"IS_SEND":0,"STATE":0,"ACTIVITY_ID":"2c9f6c94716184e101717c8b69681de9"}

class ShopInfo {
  String leaderPhone;
  String shopName;
  String shopID;
  String shopAddress;
  double distance;
  String shopImage;

  List<GoodsListBean> goodsList;
  ActivityInfoBean activityInfo;

  static ShopInfo fromMap(Map<String, dynamic> map) {
    ShopInfo shopInfo = ShopInfo();
    shopInfo.shopName = map['shopName'];
    shopInfo.shopID = map['shopID'];
    shopInfo.shopAddress = map['shopAddress'];
    shopInfo.distance = map['distance'];
    shopInfo.shopImage = map['leaderImage'] ?? map['shopImage'] ?? "";
    shopInfo.leaderPhone = map['leaderPhone'];
    shopInfo.goodsList = List()
      ..addAll((map['goodsList'] as List ?? [])
          .map((o) => GoodsListBean.fromMap(o)));
    shopInfo.activityInfo = map['activityInfo'] == null
        ? null
        : ActivityInfoBean.fromMap(map['activityInfo']);
    return shopInfo;
  }

  static List<ShopInfo> fromMapList(dynamic mapList) {
    List<ShopInfo> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map toJson() => {
        "shopName": shopName,
        "shopID": shopID,
        "shopAddress": shopAddress,
        "distance": distance,
        "shopImage": shopImage,
        "leaderPhone": leaderPhone,
        "goodsList": goodsList,
        "activityInfo": activityInfo,
      };
}

/// ACTIVITY_NAME : "4.18会员感恩礼 · 减50积分送20元感恩礼券"
/// BEGINTIME : 1587052800000
/// LIMIT_AMOUNT : 1
/// END_TIME : "2020-04-26"
/// IMAGE : "https://images.baixingliangfan.cn/integralGoodsPicture/20200419/20200419101004_1888.jpg"
/// BEGIN_TIME : "2020-04-17"
/// PARTICIPATE_TIMES : 3
/// ENDTIME : 1587916799000
/// IS_SEND : 0
/// STATE : 0
/// ACTIVITY_ID : "2c9f6c94716184e101717c8b69681de9"

class ActivityInfoBean {
  String activityName;
  int limitAmount;
  String endTime;
  String image;
  String beginTime;
  int participateTimes;
  int isSend;
  int state;
  String activityId;

  static ActivityInfoBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ActivityInfoBean activity = ActivityInfoBean();
    activity.activityName = map['ACTIVITY_NAME'];
    activity.limitAmount = map['LIMIT_AMOUNT'];
    activity.endTime = map['END_TIME'];
    activity.image = map['IMAGE'];
    activity.beginTime = map['BEGIN_TIME'];
    activity.participateTimes = map['PARTICIPATE_TIMES'];
    activity.isSend = map['IS_SEND'];
    activity.state = map['STATE'];
    activity.activityId = map['ACTIVITY_ID'];
    return activity;
  }

  Map toJson() => {
        "ACTIVITY_NAME": activityName,
        "LIMIT_AMOUNT": limitAmount,
        "END_TIME": endTime,
        "IMAGE": image,
        "BEGIN_TIME": beginTime,
        "PARTICIPATE_TIMES": participateTimes,
        "IS_SEND": isSend,
        "STATE": state,
        "ACTIVITY_ID": activityId,
      };
}

/// SELL_MONEY : 0.0
/// PICTURE_COMPERSS_PATH : "https://images.baixingliangfan.cn/compressedPic/20200419100837_8840.jpg"
/// NEED_INTEGRAL : 50
/// GOOD_ID : "60c0091884bc4ab98de5ce92dda940bc"
/// NAME : "4.18百姓会员日感恩大回馈·减50积分送20元感恩礼券"

class GoodsListBean {
  double sellMoney;
  String picture;
  int needIntegral;
  String goodId;
  String name;

  static GoodsListBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GoodsListBean goodsListBean = GoodsListBean();
    goodsListBean.sellMoney = map['SELL_MONEY'];
    goodsListBean.picture = map['PICTURE_COMPERSS_PATH'];
    goodsListBean.needIntegral = map['NEED_INTEGRAL'];
    goodsListBean.goodId = map['GOOD_ID'];
    goodsListBean.name = map['NAME'];
    return goodsListBean;
  }

  Map toJson() => {
        "SELL_MONEY": sellMoney,
        "PICTURE_COMPERSS_PATH": picture,
        "NEED_INTEGRAL": needIntegral,
        "GOOD_ID": goodId,
        "NAME": name,
      };
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

class GoodsCategory {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  String comments;
  List<GoodsCategory> bxMallSubDto;

  String mallSubId;
  String mallSubName;

  static GoodsCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    GoodsCategory categoryBean = GoodsCategory();
    categoryBean.mallCategoryId = map['mallCategoryId'];
    categoryBean.mallCategoryName = map['mallCategoryName'];
    categoryBean.bxMallSubDto = List()
      ..addAll((map['bxMallSubDto'] as List ?? [])
          .map((o) => GoodsCategory.fromMap(o)));
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

/// SETTLEMENT_WAY : 0
/// SHOP_ID : "2c9f6c946164b6b8016165628cf2002f"
/// record_state : null
/// SHOP_NAME : "百姓量贩世龙店"
/// subOrder : [{"PAYMENT":5.80,"subOrderId":32941,"BUY_NUM":1,"GOODS_ID":"4a7879ca61aa41b7a676c52b22ff9921","goodsNumber":"179883","IMAGE1":"https://images.baixingliangfan.cn/compressedPic/20191001103448_5895.jpg","state":0,"NAME":"唐小朵港式三文鱼丸36g/台式三文鱼丸36g（自由组合）"},{"PAYMENT":9.90,"subOrderId":32942,"BUY_NUM":1,"GOODS_ID":"5bb0d2aab1e54c078b212b884bc60c2a","goodsNumber":"177057","IMAGE1":"https://images.baixingliangfan.cn/compressedPic/20191001151109_8291.jpg","state":0,"NAME":"翾少爷椒麻粉130g"},{"PAYMENT":3.00,"subOrderId":32943,"BUY_NUM":1,"GOODS_ID":"c00a60c3b53f47f7a57558a0aeaa049e","goodsNumber":"114453","IMAGE1":"https://images.baixingliangfan.cn/compressedPic/20190928101613_8955.jpg","state":0,"NAME":"屈臣氏蒸馏水400ml/屈臣氏矿物质水400ml"}]
/// STATE : 1
/// SETTLEMENT_TIME : null
/// refoundAble : 1
/// type_price : null
/// totalPayment : 18.70
/// ORDER_ID : "201912042014405734"
/// totalFee : 18.70
/// DELIVERY_FEES : 0.0
/// IS_SEND : 1
/// refund_fee : 0.00
/// sendPhone : null
/// couponsFee : 0.00
/// ORDER_TIME : 1575461680619
/// refund_state : 0
/// JIFEN_NUM : 0

class OrderBean {
  int settlementWay;
  String shopId;
  String recordState;
  String shopName;
  List<SubOrderBean> subOrder;
  int state;
  String settlementTime;
  int refoundAble;
  dynamic typePrice;
  double totalPayment;
  String orderId;
  double totalFee;
  double deliveryFees;
  int isSend;
  double refundFee;
  String sendPhone;
  double couponsFee;
  String orderTime;
  int refundState;
  int jiFenNum;

  static OrderBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    OrderBean order = OrderBean();
    order.settlementWay = map['SETTLEMENT_WAY'];
    order.shopId = map['SHOP_ID'];
    order.recordState = map['record_state'];
    order.shopName = map['SHOP_NAME'];
    order.subOrder = List()
      ..addAll(
          (map['subOrder'] as List ?? []).map((o) => SubOrderBean.fromMap(o)));
    order.state = map['STATE'];
    order.settlementTime = map['SETTLEMENT_TIME'] == null
        ? ""
        : formatDateByMs(map['SETTLEMENT_TIME']);
    order.refoundAble = map['refoundAble'];
    order.typePrice = map['type_price'];
    order.totalPayment = map['totalPayment'];
    order.orderId = map['ORDER_ID'];
    order.totalFee = map['totalFee'];
    order.deliveryFees = map['DELIVERY_FEES'];
    order.isSend = map['IS_SEND'];
    order.refundFee = map['refund_fee'];
    order.sendPhone = map['sendPhone'];
    order.couponsFee = map['couponsFee'];
    order.orderTime =
        map['ORDER_TIME'] == null ? "" : formatDateByMs(map['ORDER_TIME']);
    order.refundState = map['refund_state'];
    order.jiFenNum = map['JIFEN_NUM'];
    return order;
  }

  Map toJson() => {
        "SETTLEMENT_WAY": settlementWay,
        "SHOP_ID": shopId,
        "record_state": recordState,
        "SHOP_NAME": shopName,
        "subOrder": subOrder,
        "STATE": state,
        "SETTLEMENT_TIME": settlementTime,
        "refoundAble": refoundAble,
        "type_price": typePrice,
        "totalPayment": totalPayment,
        "ORDER_ID": orderId,
        "totalFee": totalFee,
        "DELIVERY_FEES": deliveryFees,
        "IS_SEND": isSend,
        "refund_fee": refundFee,
        "sendPhone": sendPhone,
        "couponsFee": couponsFee,
        "ORDER_TIME": orderTime,
        "refund_state": refundState,
        "JIFEN_NUM": jiFenNum,
      };
}

/// PAYMENT : 5.80
/// subOrderId : 32941
/// BUY_NUM : 1
/// GOODS_ID : "4a7879ca61aa41b7a676c52b22ff9921"
/// goodsNumber : "179883"
/// IMAGE1 : "https://images.baixingliangfan.cn/compressedPic/20191001103448_5895.jpg"
/// state : 0
/// NAME : "唐小朵港式三文鱼丸36g/台式三文鱼丸36g（自由组合）"

class SubOrderBean {
  double payment;
  int subOrderId;
  int buyNum;
  String goodsId;
  String goodsNumber;
  String image;
  int state;
  String name;

  static SubOrderBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubOrderBean subOrderBean = SubOrderBean();
    subOrderBean.payment = map['PAYMENT'];
    subOrderBean.subOrderId = map['subOrderId'];
    subOrderBean.buyNum = map['BUY_NUM'];
    subOrderBean.goodsId = map['GOODS_ID'];
    subOrderBean.goodsNumber = map['goodsNumber'];
    subOrderBean.image = map['IMAGE1'];
    subOrderBean.state = map['state'];
    subOrderBean.name = map['NAME'];
    return subOrderBean;
  }

  Map toJson() => {
        "PAYMENT": payment,
        "subOrderId": subOrderId,
        "BUY_NUM": buyNum,
        "GOODS_ID": goodsId,
        "goodsNumber": goodsNumber,
        "IMAGE1": image,
        "state": state,
        "NAME": name,
      };
}
