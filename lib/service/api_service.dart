import 'dart:convert';

import 'package:dio/dio.dart';

import '../bean/index.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import '../page_index.dart';

class ApiService {
  /// 登录
  ///
  /// [email] 邮箱
  /// [password] 密码
  ///
  static Future<User> login(String email, String password) async {
    Response response = await HttpUtils().request(ApiUrl.LOGIN,
        data: {'email': email, 'password': password}, method: HttpUtils.POST);
    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      BaseResult result = BaseResult.fromMap(json.decode(response.data));

      if (result.code == '0') {
        return User.fromMap(result.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// 修改头像
  ///
  /// [data] 数据
  ///
  static Future<User> updateAvatar(FormData data) async {
    Response response =
        await HttpUtils().uploadFile(ApiUrl.UPDATE_AVATAR, data: data);

    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      BaseResult result = BaseResult.fromMap(response.data);

      if (result.code == '0') {
        return User.fromMap(result.data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// 豆瓣电影首页数据
  static Future<MovieHomeData> getMovieHomeData({String city}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_HOME_URL, data: {'city': city});
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
    String data = await FileUtil.getInstance()
        .readDataFromFile('rank_$year.json', folderPath: '/movie/json/');

    if (data != null && data != "") {
      BaseResult result = BaseResult.fromMap(json.decode(data));
      return RangesData.fromMap(result.data);
    }

    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_RANGE_URL, data: {'year': year});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      await FileUtil.getInstance().writeDataToFile(
          'rank_$year.json', response.data.toString(),
          folderPath: '/movie/json/');
      return RangesData.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取正在热映电影
  static Future<List<Movie>> getNowPlayingList(
      {String city, int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_LIST_URL,
        data: {'city': city, 'page': page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList(
      {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_SOON_URL, data: {"page": page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取排行榜电影
  static Future<List<Movie>> getRankingList(String url,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(url, data: null);
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取 top250 榜单
  static Future<List<Movie>> getTop250List(
      {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_TOP250_URL, data: {'page': page, 'limit': limit});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 根据标签搜索
  static Future<List<Movie>> getSearchListByTag(String tag,
      {int page = 1, int limit = 20, String type = "movie"}) async {
    Response response = await HttpUtils().request(
        ApiUrl.MOVIE_SEARCH_BY_TAG_URL,
        data: {'tag': tag, 'page': page, 'limit': limit, 'type': type});
    if (response == null || response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
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
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_FILTER_URL, data: {
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
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 获取电影详情
  static Future<Movie> getMovieDetail(String id) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_DETAIL_URL, data: {'id': id});
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
    Response response = await HttpUtils()
        .request(ApiUrl.MOVIE_CELEBRITY_URL, data: {'id': actorId});
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
  static Future<List<Photos>> getPhotos(String type, String id,
      {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_PHOTOS_URL,
        data: {'page': page, 'limit': limit, 'type': type, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Photos.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 影人作品
  static Future<List<Movie>> getActorMovies(String actorId,
      {int start = 1, int count = 20}) async {
    Response response = await HttpUtils().request(
        ApiUrl.MOVIE_CELEBRITY_WORKS_URL,
        data: {'page': start, 'limit': count, 'id': actorId});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Movie.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 短评
  static Future<List<Reviews>> getComments(String id,
      {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_COMMENTS_URL,
        data: {'page': page, 'limit': limit, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Reviews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 影评
  static Future<List<Reviews>> getReviews(String id,
      {int page = 1, int limit = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_REVIEWS_URL,
        data: {'page': page, 'limit': limit, 'id': id});
    if (response.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Reviews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 每日一文
  static Future<Article> getTodayArticle() async {
    Response response =
        await HttpUtils().request(ApiUrl.ARTICLE_TODAY_URL, data: null);
    if (response.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Article.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 特定日期文章
  static Future<Article> getDayArticle(String date) async {
    Response response =
        await HttpUtils().request(ApiUrl.ARTICLE_DAY_URL, data: {'date': date});
    if (response.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Article.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 随机文章
  static Future<Article> getRandomArticle() async {
    Response response =
        await HttpUtils().request(ApiUrl.ARTICLE_RANDOM_URL, data: null);
    if (response.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));
    if (result.code == '0') {
      return Article.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 得到实况天气
  static Future<HeWeather> getHeWeatherNow(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.WEATHER_NOW, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 得到逐小时天气
  static Future<HeWeather> getHeWeatherHourly(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.WEATHER_HOURLY, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 得到3-10天天气
  static Future<HeWeather> getHeWeatherForecast(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.WEATHER_FORECAST, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 常规天气数据集合
  static Future<HeWeather> getHeWeather(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.WEATHER, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 日出日落
  static Future<HeWeather> getSunriseSunset(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.SUNRISE_SUNSET, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 空气质量数据集合
  static Future<HeWeather> getAir(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.AIR, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 空气质量实况
  static Future<HeWeather> getAirNow(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.AIR_NOW, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 生活指数
  static Future<HeWeather> getLifeStyle(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .request(ApiUrl.LIFESTYLE, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather?.first;
  }

  /// 热门城市
  static Future<List<City>> getHotCities(
      {String group: 'cn', int number: 50}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.CITY_BASE_URL)
        .request(ApiUrl.CITY_TOP, data: {
      "group": group,
      "key": Config.HE_WEATHER_KEY,
      "number": number,
    });
    if (response.statusCode != 200) {
      return [];
    }
    return City.fromMapList(
        json.decode(response.data)['HeWeather6'][0]['basic']);
  }

  /// 搜索城市
  ///
  /// [keyword] 关键词
  ///
  static Future<List<City>> getSearchCities(String keyword) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.CITY_BASE_URL)
        .request(ApiUrl.CITY_FIND, data: {
      "location": keyword,
      "group": "cn",
      // group=world 查询全球城市（默认值）;group=cn 仅查询中国城市;group=us,scenic 查询美国城市和中国景点地区;group=cn,us,ru 查询中国、美国和俄罗斯城市
      "key": Config.HE_WEATHER_KEY,
      "number": 20,
      'mode': 'match'
      // 查询方式（模糊检索 or 精准检索） 可选值: equal、match，默认：match
    });
    if (response.statusCode != 200) {
      return [];
    }
    return City.fromMapList(
        json.decode(response.data)['HeWeather6'][0]['basic']);
  }

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
      return List()
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
      return List()
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
      return List()
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
      return List()
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
      return List()
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

  static Future<List<ContactBean>> getRandomUser({
    int page: 1,
    int results: 50,
    String gender: '',
    String format: 'json',
    String nat: '',
  }) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.RANDOMUSER_URL).request('', data: {
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
    Response response = await HttpUtils()
        .request(ApiUrl.JUZIMI_DETAILS_URL, data: {"id": id, "type": type});
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
    Response response = await HttpUtils()
        .request(ApiUrl.JUZIMI_LIST_URL, data: {"type": type, "page": page});
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => JuZiMi.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 根据标签得到句子迷列表
  ///
  static Future<List<JuZiMi>> getJuZiMiListByTag(int id, int page) async {
    Response response = await HttpUtils().request(ApiUrl.JUZIMI_TAG_LIST_URL,
        data: {"page": page, "tag_id": id});
    if (response == null || response.statusCode != 200) {
      return [];
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => JuZiMi.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 360壁纸
  static Future<List<ImageModal>> getImagesData(String key) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.MEIZITU_URL).request('j', data: {
      "src": 'imageonebox',
      "q": key,
      "obx_type": "360pic_meinv",
      "pn": 100,
      "sn": 0,
      "kn": 50,
      "cn": 0
    });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.images;
  }

  /// 获取全部新闻(首页)
  static Future<ResponseBean> getQDailyHomeData(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_HOME_DATA, data: {"last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取某分类下的新闻
  static Future<ResponseBean> getQDailyNewsDataByCategory(
      int tagId, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_CATEGORY_DATA,
        data: {"last_key": lastKey, "tag_id": tagId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻评论
  static Future<ResponseBean> getQDailyCommentData(int id,
      {String dataType = 'article', String lastKey = '0'}) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_COMMENT_DATA,
        data: {"last_key": lastKey, "datatype": dataType, "id": id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目列表
  static Future<ResponseBean> getQDailyColumnList(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_COLUMN_LIST, data: {"last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目信息
  static Future<ResponseBean> getQDailyColumnInfo(int columnId) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_COLUMN_INFO, data: {'column_id': columnId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目新闻
  static Future<ResponseBean> getQDailyColumnIndex(
      int columnId, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_COLUMN_NEWS,
        data: {'last_key': lastKey, 'column_id': columnId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 好奇心研究所
  static Future<ResponseBean> getQDailyLabsData(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_LABS_URL, data: {'last_key': lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 好奇心研究所详情
  static Future<ResponseBean> getQDailyLabsDetailData(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_LAB_DETAIL, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 我说
  static Future<ResponseBean> getQDailyISay(int id, String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_ISAY_URL, data: {'id': id, "last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 投票详情
  static Future<ResponseBean> getQDailyVote(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_VOTE_URL, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 投票结果
  static Future<ResponseBean> getQDailyVoteResult(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_VOTE_RESULT, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 42%详情
  static Future<ResponseBean> getQDailyTots(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_TOTS_URL, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 你谁啊
  static Future<ResponseBean> getQDailyWho(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_WHO_URL, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 你猜
  static Future<ResponseBean> getQDailyChoices(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_CHOICE_URL, data: {'id': id});

    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻详情
  static Future<ResponseBean> getQDailyArticleInfoData(int articleId) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_ARTICLE_DETAIL, data: {'id': articleId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// Topics新闻/文章
  static Future<ResponseBean> getQDailyTopicNews(int id, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_TOPIC_NEWS_URL,
        data: {'topic_id': id, 'last_key': lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 搜索
  static Future<ResponseBean> getQDailySearchData(
      String keywords, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_SEARCH_WEB,
        data: {"last_key": lastKey, "keyword": keywords});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻详情
  static Future<DetailBean> getQDailyArticleData(int articleId) async {
    DetailBean articleDetail;

    String detailsHtml = '';
    bool longPage = false;
    List<String> tags = [];
    String image = '';

    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_ARTICLE_URL)
        .request(":articleId", data: {'articleId': articleId});

    var document = parse(response.data.toString());

    dom.Element pageContent =
        document.getElementsByClassName('page-content').first;

    List<dom.Element> detailLongDiv =
        pageContent.getElementsByClassName('com-article-detail long');
    List<dom.Element> detailShortDiv =
        pageContent.getElementsByClassName('com-article-detail short');

    dom.Element detailDiv =
        detailLongDiv.length > 0 ? detailLongDiv.first : detailShortDiv.first;

    dom.Element detailBodyDiv =
        detailDiv.getElementsByClassName('article-detail-bd').first;
    dom.Element detailHeaderDiv =
        detailDiv.getElementsByClassName('article-detail-hd').first;
    dom.Element detailFooterDiv =
        detailDiv.getElementsByClassName('article-detail-ft').first;

    if (detailLongDiv.length > 0) {
      longPage = true;
    }

    if (detailShortDiv.length > 0) {
      longPage = false;
    }

    image = detailHeaderDiv
        .getElementsByClassName('banner')
        .first
        .querySelector('img')
        .attributes['data-src'];

    detailsHtml =
        detailBodyDiv.getElementsByClassName('detail').first.outerHtml;

    ////////////////////////////////////////////////////////////////

    List<dom.Element> tagsLi = detailFooterDiv
        .getElementsByClassName('tags items clearfix')
        .first
        .querySelectorAll('li');

    tagsLi.forEach((item) {
      tags.add(item.querySelector('span').text);
    });

    ////////////////////////////////////////////////////////////////
    List<PostBean> posts = [];

    List<dom.Element> banners = pageContent
        .getElementsByClassName('related-banners-bd')
        .first
        .querySelectorAll('a');

    banners.forEach((item) {
      int articleId = int.parse(item.attributes['href']
          .replaceAll('/mobile/articles/', '')
          .replaceAll('.html', ''));

      dom.Element bannerHd =
          item.getElementsByClassName('grid-key-article-hd').first;

      String image = bannerHd
          .getElementsByClassName('imgcover pic')
          .first
          .querySelector('img')
          .attributes['data-src'];

      print('-=-=-=-================----------$image');

      dom.Element bannerBd =
          item.getElementsByClassName('grid-key-article-bd').first;

      String title = bannerBd.getElementsByClassName('title').first.text;

      String category =
          bannerBd.querySelector('p').querySelectorAll('span')[1].text;

      dom.Element ribbonDiv = bannerBd.getElementsByClassName('ribbon').first;

      List<dom.Element> messageSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-message');
      List<dom.Element> heartSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-heart');

      int commentCount =
          messageSpans.length > 0 ? int.parse(messageSpans.first.text) : 0;

      int praiseCount =
          heartSpans.length > 0 ? int.parse(heartSpans.first.text) : 0;

      PostBean post = PostBean(
          image: image,
          id: articleId,
          title: title,
          categoryTile: category,
          commentCount: commentCount,
          praiseCount: praiseCount);

      posts..add(post);
    });

    articleDetail = DetailBean(
        description: detailsHtml,
        image: image,
        tags: tags,
        isFullPage: longPage,
        posts: posts);

    print(articleDetail.toString());

    return articleDetail;
  }

  /// 获取图书详情
  static Future<BookBean> getQDailyBookData(int articleId) async {
    BookBean bookDetail;

    String desc = '';
    List<String> tags = [];
    String detail = '';

    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_ARTICLE_URL)
        .request(":articleId", data: {'articleId': articleId});

    var document = parse(response.data.toString());

    dom.Element pageContent =
        document.getElementsByClassName('page-content').first;

    dom.Element detailBodyDiv =
        pageContent.getElementsByClassName('article-detail-bd').first;
    dom.Element detailHeaderDiv =
        pageContent.getElementsByClassName('article-detail-hd').first;
    dom.Element detailFooterDiv =
        pageContent.getElementsByClassName('article-detail-ft').first;

    desc = detailHeaderDiv.getElementsByClassName('info').first.outerHtml;

    detail = detailBodyDiv.getElementsByClassName('detail').first.outerHtml;

    ////////////////////////////////////////////////////////////////

    List<dom.Element> tagsLi = detailFooterDiv
        .getElementsByClassName('tags items clearfix')
        .first
        .querySelectorAll('li');

    tagsLi.forEach((item) {
      tags.add(item.querySelector('span').text);
    });

    ////////////////////////////////////////////////////////////////
    List<PostBean> posts = [];

    List<dom.Element> banners = pageContent
        .getElementsByClassName('related-banners-bd')
        .first
        .querySelectorAll('a');

    banners.forEach((item) {
      int articleId = int.parse(item.attributes['href']
          .replaceAll('/mobile/articles/', '')
          .replaceAll('.html', ''));

      dom.Element bannerHd =
          item.getElementsByClassName('grid-key-article-hd').first;

      String image = bannerHd
          .getElementsByClassName('imgcover pic')
          .first
          .querySelector('img')
          .attributes['data-src'];

      print('-=-=-=-================----------$image');

      dom.Element bannerBd =
          item.getElementsByClassName('grid-key-article-bd').first;

      String title = bannerBd.getElementsByClassName('title').first.text;

      String category =
          bannerBd.querySelector('p').querySelectorAll('span')[1].text;

      dom.Element ribbonDiv = bannerBd.getElementsByClassName('ribbon').first;

      List<dom.Element> messageSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-message');
      List<dom.Element> heartSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-heart');

      int commentCount =
          messageSpans.length > 0 ? int.parse(messageSpans.first.text) : 0;

      int praiseCount =
          heartSpans.length > 0 ? int.parse(heartSpans.first.text) : 0;

      PostBean post = PostBean(
          image: image,
          id: articleId,
          title: title,
          categoryTile: category,
          commentCount: commentCount,
          praiseCount: praiseCount);

      posts..add(post);
    });

    bookDetail = BookBean(desc: desc, tags: tags, posts: posts, detail: detail);

    print(bookDetail.toString());

    return bookDetail;
  }

  /// 有道精品课首页上面部分数据
  static Future<YouDaoData> getYouDaoHomeHead(int t) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_HOME_URL, data: {"t": t});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品课所有分类及部分课程列表数据
  static Future<YouDaoData> getYouDaoHomeTags(List tags, int t) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_HOME_LIST_URL,
            data: {"tagIds": tags.toString(), "t": t});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品分组详情
  static Future<YouDaoData> getYouDaoGroupDetails(int tag) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_GROUP_DETAILS_URL, data: {"tag": tag});
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 有道精品分组所有课程列表
  static Future<List<CoursesBean>> getYouDaoGroupCourseList(
      int tag, int rank, int time) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.YOUDAO_BASE_URL)
        .request(ApiUrl.YOUDAO_GROUP_ALL_COURSE_URL,
            data: {"tag": tag, "rank": rank, "time": time});
    if (response?.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data.course;
  }

  /// 根据分类得到小说列表
  /// [gender] 性别 男生:mael 女生:female 出版:press
  /// [major] 大类别
  /// [minor] 小类别
  /// [type] 热门:hot 新书:new 好评:repulation 完结:over 包月: month
  /// [start] 分页位置，从0开始
  /// [limit] 分页条数
  ///
  static Future<List<Books>> getBookByCategories(String gender, String major,
      {int start: 0,
      int limit: 20,
      String minor: '',
      String type: 'hot'}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOKS_BY_CATEGORY_URL, data: {
      "gender": gender,
      "major": major,
      'type': type,
      "start": start,
      "limit": limit,
      "minor": minor
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 小说详情
  static Future<Books> getBookDetails(String id) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_DETAILS_URL, data: {"id": id});
    if (response?.statusCode != 200) {
      return null;
    }

    Books book = Books.fromJson(json.decode(response.data));
    return book;
  }

  /// 相关推荐
  static Future<List<Books>> getBookByRecommend(String id) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RECOMMEND_URL, data: {"id": id});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 小说书评列表
  static Future<BookResult> getBookReview(String id,
      {String sort: 'updated', int start: 0, int limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_REVIEW_URL,
        data: {"book": id, "sort": sort, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 小说短评列表
  static Future<List<DocsBean>> getBookShortReview(String id,
      {String sort: 'updated', int start: 0, int limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_SHORT_REVIEW_URL,
        data: {"book": id, "sort": sort, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.docs;
    } else {
      return [];
    }
  }

  /// 小说讨论列表
  static Future<List<Post>> getBookTalks(String id,
      {String sort: 'updated',
      int start: 1,
      int limit: 20,
      String type: 'normal'}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_TALK_URL, data: {
      "book": id,
      "sort": sort,
      "start": start,
      "limit": limit,
      "type": type
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.posts;
    } else {
      return [];
    }
  }

  /// 获取小说正版源
  static Future<BtocResult> getBookBtocSource(String bookId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_BTOC_URL,
        data: {"book": bookId, 'view': 'summary'});
    if (response?.statusCode != 200) {
      return null;
    }

    List<BtocResult> result = List()
      ..addAll((json.decode(response.data) as List ?? [])
          .map((o) => BtocResult.fromMap(o)));

    if (result.length > 0) {
      return result.first;
    } else {
      return null;
    }
  }

  /// 小说章节目录
  static Future<List<Chapters>> getBookChapters(String sourceId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_ATOC_URL,
        data: {"sourceId": sourceId, 'view': 'chapters'});
    if (response?.statusCode != 200) {
      return [];
    }

    ChapterResult result = ChapterResult.fromMap(json.decode(response.data));
    if (result.chapters.length > 0) {
      return result.chapters;
    } else {
      return [];
    }
  }

  /// 小说章节详情
  static Future<ChapterInfo> getBookChapterInfo(String link) async {
    Response response = await HttpUtils().request(link, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.chapter;
    } else {
      return null;
    }
  }

  /// 获取所有排行榜
  static Future<RankingResult> getBookRankings() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RANKING_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    RankingResult result = RankingResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 获取单一排行榜
  static Future<Ranking> getRankingBooks(String rankingId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RANKING_INFO_URL, data: {"rankingId": rankingId});
    if (response?.statusCode != 200) {
      return null;
    }

    RankingResult result = RankingResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.ranking;
    } else {
      return null;
    }
  }

  /// 获取分类
  static Future<StatisticsResult> getBookStatistics() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_STATISTICS_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    StatisticsResult result =
        StatisticsResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 获取二级分类
  static Future<CategoryResult> getBookCategory() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_CATEGORY_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    CategoryResult result = CategoryResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 关键字搜索返回小说列表
  /// [query] 搜索关键字
  /// [start] 开始位置（从1开始）
  /// [limit] 每页条数
  ///
  static Future<List<Books>> getSearchBook(String query,
      {int start: 1, limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_SEARCH_URL,
        data: {"query": query, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 搜索热词列表
  ///
  static Future<List<String>> getSearchHotWords() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_HOT_WORDS_URL, data: null);
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.hotWords;
    } else {
      return [];
    }
  }

  /// 书单列表
  ///
  static Future<List<BookList>> getBookLists(String gender,
      {int start: 0,
      int limit: 20,
      String duration: 'all',
      String sort: 'collectorCount',
      String tag: ''}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_LIST_URL, data: {
      "gender": gender,
      "duration": duration,
      "sort": sort,
      "tag": tag,
      "start": start,
      "limit": limit
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.bookLists;
    } else {
      return [];
    }
  }

  /// 书单详情
  ///
  static Future<BookList> getBookListInfo(String booklistId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_LIST_INFO_URL, data: {"booklistId": booklistId});
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.bookList;
    } else {
      return null;
    }
  }

  /// 一言
  ///
  static Future<Hitokoto> hitokoto() async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.HITOKOTO_URL).request('', data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    Hitokoto result = Hitokoto.fromMap(json.decode(response.data));
    return result;
  }

  /// tubi TV 首页数据
  ///
  static Future<List<TubiCategory>> getTubiTVHomeData(
      {String deviceId, String platform}) async {
    Response response = await HttpUtils().request(ApiUrl.TUBITV_HOME,
        data: {'platform': platform, 'device_id': deviceId});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => TubiCategory.fromMap(o)));
    } else {
      return [];
    }
  }

  /// tubi TV 分类列表
  ///
  static Future<List<TuBiTV>> getTubiTVByCategory(
      {int limit, int page, String category}) async {
    Response response = await HttpUtils().request(ApiUrl.TUBITV_LIST,
        data: {'page': page, 'category': category, 'limit': limit});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => TuBiTV.fromMap(o)));
    } else {
      return [];
    }
  }

  /// tubi TV 搜索
  ///
  static Future<List<TuBiTV>> getTubiTVSearchData(
      {String deviceId, String platform, String key}) async {
    Response response = await HttpUtils().request(ApiUrl.TUBITV_SEARCH,
        data: {'platform': platform, 'device_id': deviceId, 'key': key});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => TuBiTV.fromMap(o)));
    } else {
      return [];
    }
  }

  /// tubi TV 详情
  ///
  static Future<TuBiTV> getTubiTVDetails(
      {String deviceId, String platform, String id}) async {
    Response response = await HttpUtils().request(ApiUrl.TUBITV_DETAIL,
        data: {'platform': platform, 'device_id': deviceId, 'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return TuBiTV.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// NBA赛季赛程
  ///
  /// [startTime] 开始日期
  /// [endTime] 结束日期
  ///
  static Future<List<Schedule>> getNBASchedule(
      {String startTime, String endTime}) async {
    Response response = await HttpUtils().request(ApiUrl.NBA_SCHEDULE,
        data: {'startTime': startTime, 'endTime': endTime});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Schedule.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA球队赛季赛程
  ///
  /// [id] 球队ID
  ///
  static Future<List<Schedule>> getTeamSchedule({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_SCHEDULE, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Schedule.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA球队赛季阵容
  ///
  /// [id] 球队ID
  ///
  static Future<List<Player>> getTeamRoster({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_ROSTER, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Player.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球队赛季排名
  ///
  static Future<List<RankBase>> getTeamRank() async {
    Response response = await HttpUtils().request(ApiUrl.TEAM_RANK, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => RankBase.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员赛季数据排行前N（）
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  /// [limit] 返回前多少名
  ///
  static Future<PlayerSeasonRank> getPlayerRankTopN(
      {int year: 2019, int type: 1, int limit: 10}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_RANNGE,
        data: {'year': year, 'type': type, 'limit': limit});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return PlayerSeasonRank.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球员赛季数据排行(全)
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  /// [page] 页码
  /// [limit] 每页条数
  /// [sort] 排序方式 得分 t70；出手数 t83；命中率 t79；三分出手 t85；三分命中率 t80；罚球次数 t87；发球命中率 t81；篮板 t71；前场篮板 t77；后场篮板 t76；助攻 t68；抢断 t72；盖帽 t69；失误 t74；犯规 t73；场次 t5；上场时间 t78
  ///
  static Future<List<SeasonDataStat>> getPlayerRankAll(
      {int year: 2019,
      int type: 1,
      int page: 1,
      int limit: 50,
      String sort: 't70'}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_RANNGE_ALL,
        data: {
          'year': year,
          'type': type,
          'page': page,
          'limit': limit,
          'sort': sort
        });
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员详情
  ///
  /// [id] 球员ID
  ///
  static Future<StatsBase> getPlayerDetails({String id}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.PLAYER_DETAIL, data: {'id': id, 'year': 2019});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球员详情
  ///
  /// [id] 球员ID
  ///
  static Future<StatsBase> getPlayerInfo({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.PLAYER_INFO, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球队赛季数据排行(全)
  ///
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  ///
  static Future<List<SeasonDataStat>> getTeamRankAll(
      {int year: 2019, int type: 1}) async {
    Response response = await HttpUtils()
        .request(ApiUrl.TEAM_RANNGE_ALL, data: {'year': year, 'type': type});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员职业生涯赛季数据统计（包括季前赛、常规赛、季后赛）
  ///
  /// [id] 球员ID
  ///
  static Future<List<SeasonDataStat>> getPlayerCareer(String id) async {
    Response response =
        await HttpUtils().request(ApiUrl.PLAYER_CAREER, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => SeasonDataStat.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球员赛季每场比赛数据统计（包括季前赛、常规赛、季后赛）
  ///
  /// [id] 球员ID
  /// [year] 赛季
  /// [type] 类型 1:常规赛;2:季后赛;0:季前赛
  ///
  static Future<List<PlayerMatch>> getPlayerMatch(String id,
      {int year: 2019, int type: 1}) async {
    Response response = await HttpUtils().request(ApiUrl.PLAYER_MATCH,
        data: {'year': year, 'type': type, 'id': id});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => PlayerMatch.fromMap(o)));
    } else {
      return [];
    }
  }

  /// NBA最新动态
  ///
  /// [name] 球员名字or球队名称
  ///
  static Future<List<NBANews>> getNBANews(String name) async {
    Response response =
        await HttpUtils().request(ApiUrl.NBA_NEWS, data: {'name': name});
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => NBANews.fromMap(o)));
    } else {
      return [];
    }
  }

  /// 球队详情
  ///
  /// [id] 球队ID
  ///
  static Future<Team> getTeamInfo(String id) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_INFO, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return Team.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 比赛数据统计详情
  ///
  /// [mid] 球队ID
  ///
  static Future<MatchBaseBean> getMatchStats(String mid) async {
    Response response =
        await HttpUtils().request(ApiUrl.MATCH_STATS, data: {'mid': mid});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return MatchBaseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 球队数据概况
  ///
  /// [id] 球队ID
  ///
  static Future<StatsBase> getTeamStats({String id}) async {
    Response response =
        await HttpUtils().request(ApiUrl.TEAM_STATS, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return StatsBase.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 音乐列表
  ///
  static Future<List<Song>> getMusics() async {
    Response response = await HttpUtils().request(ApiUrl.MUSIC, data: null);
    if (response == null || response?.statusCode != 200) {
      return [];
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return List()
        ..addAll((result.data as List ?? []).map((o) => Song.fromMap(o)));
    } else {
      return [];
    }
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
      return List()
        ..addAll(
            (result.data as List ?? []).map((o) => TiktokVideo.fromMap(o)));
    } else {
      return [];
    }
  }

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
      return List()
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
      return List()
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
      return List()
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
      return List()
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
      return List()
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
      return List()
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
