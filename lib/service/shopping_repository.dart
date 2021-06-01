import 'dart:convert';

import '../page_index.dart';

class ShoppingRepository {
  /// 百姓生活首页数据接口
  ///
  /// [lon] 纬度
  /// [lat] 经度
  ///
  static Future<Baixing> getBaixingHomeData(String lon, String lat) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_HOME,
            data: {"lon": lon, 'lat': lat}, method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Baixing.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 百姓生活首页火爆专区商品数据接口
  ///
  /// [page] 页码
  ///
  static Future<List<Goods>> getBaixingHomeHotData(int page) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_HOME_HOT,
            data: {"page": page}, method: HttpUtils.POST);

    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Goods.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 百姓生活分类数据接口
  ///
  static Future<List<GoodsCategory>> getBaixingCategoryData() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_CATEGORY, method: HttpUtils.POST, data: null);

    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => GoodsCategory.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 百姓生活分类商品数据接口
  ///
  /// [page] 页码
  /// [categoryId] 类别
  /// [categorySubId] 子类别
  ///
  static Future<List<Goods>> getBaixingGoodsData(
    int page,
    String categoryId,
    String categorySubId,
  ) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_GOODS,
            data: {
              "page": page,
              "categoryId": categoryId,
              "categorySubId": categorySubId
            },
            method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Goods.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 百姓生活商品详情接口
  ///
  /// [goodId] 商品ID
  ///
  static Future<GoodsInfo> getBaixingGoodsDetailData(String goodId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_GOODS_DETAIL,
            data: {"goodId": goodId}, method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return GoodsInfo.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 订单
  ///
  /// [userId] 用户ID
  /// [state] 状态；-1：所有，1：，401：已结算，
  /// [page] 页码
  ///
  static Future<List<OrderBean>> getBaixingOrders(
      {int page: 1,
      String userId: "da290bbcbcff4c1dbd662e15d5808150",
      int state: -1}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_ORDERS,
            data: {"currentPage": page, "userId": userId, "state": state},
            method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => OrderBean.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 百姓生活门店列表
  ///
  /// [lon] 纬度
  /// [lat] 经度
  ///
  static Future<List<ShopInfo>> getBaixingShops(
      {String lat, String lon}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_SHOPS,
            data: {"lon": lon, "lat": lat}, method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => ShopInfo.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 百姓生活门店详情接口
  ///
  /// [id] 门店ID
  ///
  static Future<ShopInfo> getBaixingShopInfo(String id) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .request(ApiUrl.BAIXING_SHOP_DETAIL,
            data: {"shopId": id}, method: HttpUtils.POST);
    if (response == null || response.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return ShopInfo.fromMap(result.data);
    } else {
      return null;
    }
  }
}
