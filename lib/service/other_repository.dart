import 'dart:convert';

import '../page_index.dart';

class OtherRepository {
  /// 每日一文
  static Future<Article> getTodayArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL).request(ApiUrl.ARTICLE_TODAY_URL);
    if (response.statusCode != 200) {
      return null;
    }

    Map<String, dynamic> map = json.decode(response.data)["data"];

    map["id"] = map["wc"];
    map["curr"] = map["date"]["curr"];
    map["prev"] = map["date"]["prev"];
    map["next"] = map["date"]["next"];

    return Article.fromMap(map);
  }

  /// 特定日期文章
  static Future<Article> getDayArticle(String date) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL).request(ApiUrl.ARTICLE_DAY_URL, data: {'date': date});
    if (response.statusCode != 200) {
      return null;
    }
    Map<String, dynamic> map = json.decode(response.data)["data"];

    map["id"] = map["wc"];
    map["curr"] = map["date"]["curr"];
    map["prev"] = map["date"]["prev"];
    map["next"] = map["date"]["next"];

    return Article.fromMap(map);
  }

  /// 随机文章
  static Future<Article> getRandomArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL).request(ApiUrl.ARTICLE_RANDOM_URL);
    if (response.statusCode != 200) {
      return null;
    }
    Map<String, dynamic> map = json.decode(response.data)["data"];

    map["id"] = map["wc"];
    map["curr"] = map["date"]["curr"];
    map["prev"] = map["date"]["prev"];
    map["next"] = map["date"]["next"];

    return Article.fromMap(map);
  }

  static Future<List<ContactBean>> getRandomUser({
    int page: 1,
    int results: 50,
    String gender: '',
    String format: 'json',
    String nat: '',
  }) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.RANDOMUSER_URL).request('', data: {
      "page": page,
      "results": results,
      "gender": gender,
      "format": format,
      "nat": nat,
    });
    if (response == null || response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.contacts;
  }

  /// 句子迷详情
  ///
  static Future<JuZiMi> getJuZiMiDetails(int id, String type) async {
    Response response = await HttpUtils().request(ApiUrl.JUZIMI_DETAILS_URL, data: {"id": id, "type": type});
    if (response == null || response.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return JuZiMi.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 根据类别得到句子迷列表
  ///
  static Future<List<JuZiMi>> getJuZiMiListByType(String type, int page) async {
    Response response = await HttpUtils().request(ApiUrl.JUZIMI_LIST_URL, data: {"type": type, "page": page});
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => JuZiMi.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 根据标签得到句子迷列表
  ///
  static Future<List<JuZiMi>> getJuZiMiListByTag(int id, int page) async {
    Response response = await HttpUtils().request(ApiUrl.JUZIMI_TAG_LIST_URL, data: {"page": page, "tag_id": id});
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => JuZiMi.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 360壁纸
  static Future<List<ImageModal>> getImagesData(String key) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.MEIZITU_URL).request('j',
        data: {"src": 'imageonebox', "q": key, "obx_type": "360pic_meinv", "pn": 100, "sn": 0, "kn": 50, "cn": 0});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.images;
  }

  /// 有道精品课首页上面部分数据
  static Future<YouDaoData> getYouDaoHomeHead(int t) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL).request(ApiUrl.YOUDAO_HOME_URL, data: {"t": t});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品课所有分类及部分课程列表数据
  static Future<YouDaoData> getYouDaoHomeTags(List tags, int t) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_HOME_LIST_URL, data: {"tagIds": tags.toString(), "t": t});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品分组详情
  static Future<YouDaoData> getYouDaoGroupDetails(int tag) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL).request(ApiUrl.YOUDAO_GROUP_DETAILS_URL, data: {"tag": tag});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品分组所有课程列表
  static Future<List<CoursesBean>> getYouDaoGroupCourseList(int tag, int rank, int time) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_GROUP_ALL_COURSE_URL, data: {"tag": tag, "rank": rank, "time": time});
    if (response?.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data.course;
  }

  /// 一言
  ///
  static Future<Hitokoto> hitokoto() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.HITOKOTO_URL).request('', data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    Hitokoto result = Hitokoto.fromMap(json.decode(response.data));
    return result;
  }

  /// 抖音视频榜
  ///
  static Future<List<TiktokVideo>> getTiktokVideos() async {
    Response response = await HttpUtils().request(ApiUrl.DY_VIDEOS, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => TiktokVideo.fromMap(o)));
    } else {
      return [];
    }
  }
}
