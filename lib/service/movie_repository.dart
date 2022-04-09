import 'dart:convert';

import '../page_index.dart';

class MovieRepository {
  /// 豆瓣电影首页数据
  static Future<MovieHomeData> getMovieHomeData({String city}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_HOME_URL, data: {'city': city});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return MovieHomeData.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 豆瓣电影年度榜单
  ///
  /// [year] 年份
  ///
  static Future<RangesData> getMovieRanges(int year) async {
    String data = await FileUtil.getInstance().readDataFromFile('rank_$year.json', folderPath: '/movie/json/');

    if (data != null && data != "") {
      BaseResult result = BaseResult.fromMap(json.decode(data));
      return RangesData.fromMap(result.data);
    }

    Response response = await HttpUtils().request(ApiUrl.MOVIE_RANGE_URL, data: {'year': year});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      await FileUtil.getInstance()
          .writeDataToFile('rank_$year.json', response.data.toString(), folderPath: '/movie/json/');
      return RangesData.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取正在热映电影
  static Future<List<Movie>> getNowPlayingList({String city, int page = 1, int limit = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_LIST_URL, data: {'city': city, 'page': page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList({int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_SOON_URL, data: {"page": page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取排行榜电影
  static Future<List<Movie>> getRankingList(String url, {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(url, data: null);
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取 top250 榜单
  static Future<List<Movie>> getTop250List({int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_TOP250_URL, data: {'page': page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 根据标签搜索
  static Future<List<Movie>> getSearchListByTag(String tag,
      {int page = 1, int limit = 20, String type = "movie"}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_SEARCH_BY_TAG_URL, data: {'tag': tag, 'page': page, 'limit': limit, 'type': type});
    if (response == null || response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 找电影
  static Future<List<Movie>> getFilterList(
      {int page: 1,
      String range: "1,10",
      bool playable: false,
      bool unwatched: false,
      String yearRange,
      String countries,
      String genres,
      String sort,
      String type,
      String feature}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_FILTER_URL, data: {
      'page': page,
      'playable': playable ? 1 : null,
      "range": range,
      "unwatched": unwatched ? 1 : null,
      "year_range": yearRange,
      "countries": countries,
      "genres": genres,
      "sort": sort,
      "type": type,
      "feature": feature
    });
    if (response == null || response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取电影详情
  static Future<Movie> getMovieDetail(String id) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_DETAIL_URL, data: {'id': id});
    if (response == null || response.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Movie.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 影人详细信息
  static Future<Celebrity> getActorDetail(String actorId) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_CELEBRITY_URL, data: {'id': actorId});
    if (response.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Celebrity.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 剧照
  static Future<List<Photos>> getPhotos(String type, String id, {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_PHOTOS_URL, data: {'page': page, 'limit': limit, 'type': type, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Photos.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 影人作品
  static Future<List<Movie>> getActorMovies(String actorId, {int start = 1, int count = 20}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_CELEBRITY_WORKS_URL, data: {'page': start, 'limit': count, 'id': actorId});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 短评
  static Future<List<Reviews>> getComments(String id, {int page = 1, int limit = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_COMMENTS_URL, data: {'page': page, 'limit': limit, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Reviews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 影评
  static Future<List<Reviews>> getReviews(String id, {int page = 1, int limit = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_REVIEWS_URL, data: {'page': page, 'limit': limit, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return []..addAll((result.data as List ?? []).map((o) => Reviews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// tubi TV 首页数据
  ///
  static Future<List<TubiCategory>> getTubiTVHomeData({String deviceId, String platform}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.TUBITV_HOST)
        .request(ApiUrl.TUBITV_HOME, data: {'platform': platform, 'device_id': deviceId});

    if (response == null || response?.statusCode != 200) {
      return [];
    }
    Map<String, dynamic> map = json.decode(response.data);

    Log.d(map["containers"].length);

    for (int i = 0; i < map["containers"].length; i++) {
      Map<String, dynamic> value = map["containers"][i];
      List<Map<String, dynamic>> children = [];

      for (int j = 0; j < value["children"].length; j++) {
        children.add(map['contents']["${value["children"][j]}"]);
      }

      value["contents"] = children;
    }

    map.remove("contents");

    return []..addAll((map["containers"] as List ?? []).map((o) => TubiCategory.fromMap(o)));
  }

  /// tubi TV 分类列表
  ///
  static Future<List<TuBiTV>> getTubiTVByCategory({int limit, int page, String category}) async {
    Response response =
        await HttpUtils(baseUrl: "https://tubitv.com/").request("oz/containers/$category/content", data: {
      'cursor': (page - 1) * limit,
      'limit': limit,
      "app_id": "tubitv",
      "parentId": "",
      "version": "6.1.0",
      "isKidsModeEnabled": false,
      "expand": 0
    });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    Map<String, dynamic> map = json.decode(response.data);

    List<TuBiTV> children = [];

    map["contents"].forEach((key, value) {
      children.add(TuBiTV.fromMap(value));
    });

    return children;
  }

  /// tubi TV 搜索
  ///
  static Future<List<TuBiTV>> getTubiTVSearchData({String deviceId, String platform, String key}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.TUBITV_HOST).request(ApiUrl.TUBITV_SEARCH,
        data: {'platform': platform, 'device_id': deviceId, 'search': key, "app_id": "tubitv", "categorize": false});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    return (json.decode(response.data) as List ?? []).map((o) => TuBiTV.fromMap(o)).toList();
  }

  /// tubi TV 详情
  ///
  static Future<TuBiTV> getTubiTVDetails({String deviceId, String platform, String id}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.TUBITV_HOST).request(ApiUrl.TUBITV_DETAIL, data: {
      'platform': platform,
      'device_id': deviceId,
      'content_id': id,
      "includeChannels": true,
      "app_id": "tubitv"
    });
    if (response == null || response?.statusCode != 200 || json.decode(response.data)["code"] == "NotFound") {
      return null;
    }

    Map<String, dynamic> map = json.decode(response.data);

    Response _response = await HttpUtils(baseUrl: ApiUrl.TUBITV_HOST)
        .request("cms/content/$id/related", data: {'platform': platform, 'device_id': deviceId, "app_id": "tubitv"});

    if (_response != null && _response?.statusCode == 200 && json.decode(response.data)["code"] != "NotFound") {
      map["related"] = json.decode(_response.data);
    }

    return TuBiTV.fromMap(map);
  }
}
