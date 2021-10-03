import 'dart:convert';

import '../page_index.dart';

class SARSCovRepository {
  /// 获取同程信息
  ///
  /// [no] 同程车次
  /// [type] 交通类型
  /// [arrive] 到达地点
  /// [date] 时间
  /// [page] 页码
  /// [num] 每页返回条数
  ///
  static Future<List<SameRide>> getSameRideData({
    String no,
    String type = "1",
    String arrive,
    String date,
    int page = 1,
    int num = 20,
  }) async {
    Response response = await HttpUtils().request(ApiUrl.NCOV_SAME, data: {
      "date": date,
      "no": no,
      "type": type,
      "arrive": arrive,
      "page": page,
      "num": num,
    });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => SameRide.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 谣言鉴别
  ///
  /// [page] 页码
  ///
  static Future<List<Rumour>> getRumourData({
    int page = 1,
  }) async {
    Response response =
        await HttpUtils().request(ApiUrl.NCOV_RUMOUR, data: {"page": page});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Rumour.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 疫情实时新闻
  ///
  static Future<List<CovNews>> getSARSCovNewsData() async {
    Response response = await HttpUtils().request(ApiUrl.NCOV_NEWS, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => CovNews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 抗击疫情
  ///
  static Future<SARSCov> getSARSCovIndexData() async {
    Response response =
        await HttpUtils().request(ApiUrl.NCOV_INDEX, data: null);
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return SARSCov.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 地区疫情情况
  ///
  /// [province] 省份拼音
  ///
  static Future<ProvinceDataBean> getSARSCovProvinceData(
      String province) async {
    Response response = await HttpUtils()
        .request(ApiUrl.NCOV_PROVINCE, data: {'province': province});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ProvinceDataBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 地区疫情新闻
  ///
  /// [province] 省份拼音
  /// [page] 页码
  /// [num] 每页返回条数
  ///
  static Future<List<ProvinceNews>> getSARSCovProvinceNewsData(String province,
      {int page: 1, int num: 10}) async {
    Response response = await HttpUtils().request(ApiUrl.NCOV_PROVINCE_NEWS,
        data: {"province": province, "page": page, "num": num});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll(
            (result.data as List ?? []).map((o) => ProvinceNews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 疫情分析
  ///
  static Future<List<Analyze>> getSARSCovAnalyzeData() async {
    Response response =
        await HttpUtils().request(ApiUrl.NCOV_ANALYZE, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Analyze.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 新冠肺炎确诊病患活动轨迹
  ///
  /// [province] 省份
  /// [city] 市/区
  /// [county] 区/县
  /// [page] 页码
  /// [num] 每页返回条数
  ///
  static Future<List<Trajectory>> getSARSCovTrajectoryData(
      {String province,
      String city,
      String county,
      int page: 1,
      int num: 10}) async {
    Response response = await HttpUtils().request(ApiUrl.NCOV_TRAJECTORY,
        data: {
          "province": province,
          "city": city,
          "county": county,
          "page": page,
          "num": num
        });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []
        ..addAll((result.data as List ?? []).map((o) => Trajectory.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 预防手册
  ///
  static Future<PreventManualBase> getSARSCovPreventManualData() async {
    Response response =
        await HttpUtils().request(ApiUrl.NCOV_PREVENT_MANUAL, data: null);
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return PreventManualBase.fromMap(result.data);
    } else {
      return null;
    }
  }
}
