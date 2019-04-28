import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/bean/article.dart';
import 'package:flutter_app/bean/baixing.dart';
import 'package:flutter_app/bean/category.dart';
import 'package:flutter_app/bean/celebrity.dart';
import 'package:flutter_app/bean/city.dart';
import 'package:flutter_app/bean/comment.dart';
import 'package:flutter_app/bean/contact.dart';
import 'package:flutter_app/bean/cryptocurrency.dart';
import 'package:flutter_app/bean/goods.dart';
import 'package:flutter_app/bean/goods_info.dart';
import 'package:flutter_app/bean/he_weather.dart';
import 'package:flutter_app/bean/juzimi.dart';
import 'package:flutter_app/bean/news.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/bean/poetry.dart';
import 'package:flutter_app/bean/reviews.dart';
import 'package:flutter_app/bean/movie.dart';
import 'package:flutter_app/bean/result.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/service/api_url.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/log_util.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class ApiService {
  /// 获取豆瓣电影首页热门新闻文章
  static Future<List<News>> getNewsList() async {
    List<News> news = [];

    await http.get(ApiUrl.DOUBAN_WEB_URL).then((http.Response response) {
      var document = parse(response.body.toString());
      List<dom.Element> items =
          document.getElementsByClassName('gallery-frame');
      items.forEach((item) {
        String cover =
            item.getElementsByTagName('img')[0].attributes['src'].toString();
        String link =
            item.getElementsByTagName('a')[0].attributes['href'].toString();
        String title =
            item.getElementsByTagName('h3')[0].text.toString().trim();
        String summary =
            item.getElementsByTagName('p')[0].text.toString().trim();
        news.add(News(title, cover, summary, link));
      });
    });

    LogUtil.v(news.toString());

    return news;
  }

  /// 获取正在热映电影
  static Future<List<Movie>> getNowPlayingList(
      {String city, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_LIST_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'city': city,
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList(
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_SOON_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      "start": start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取排行榜电影
  static Future<List<Movie>> getRankingList(String url,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils(queryParameters: {'apikey': Config.DOUBAN_MOVIE_KEY})
            .get(url, data: {
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取本周口碑榜电影
  static Future<List<Movie>> getWeeklyList() async {
    Response response =
        await HttpUtils(queryParameters: {'apikey': Config.DOUBAN_MOVIE_KEY})
            .get(ApiUrl.WEEKLY_MOVIES_URL);
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    List<Movie> movies = [];
    result.subjects.map((m) {
      movies.add(m.subject);
    }).toList();

    return movies;
  }

  /// 获取新片榜电影
  static Future<List<Movie>> getNewMoviesList() async {
    Response response =
        await HttpUtils(queryParameters: {'apikey': Config.DOUBAN_MOVIE_KEY})
            .get(ApiUrl.NEW_MOVIES_URL);
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取北美票房榜电影
  static Future<List<Movie>> getUsBoxList() async {
    Response response =
        await HttpUtils(queryParameters: {'apikey': Config.DOUBAN_MOVIE_KEY})
            .get(ApiUrl.US_MOVIES_URL);
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    List<Movie> movies = [];
    result.subjects.map((m) {
      movies.add(m.subject);
    }).toList();

    return movies;
  }

  /// 获取 top250 榜单
  static Future<List<Movie>> getTop250List(
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_TOP250_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 根据标签搜索
  static Future<List<Movie>> getSearchListByTag(
      {String tag, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'tag': tag,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 根据关键字搜索
  static Future<List<Movie>> getSearchListByKey(
      {String key, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'q': key,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 搜索电影
  static Future<List<Movie>> getSearchList(
      {String key, String tag, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(ApiUrl.MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'q': key,
      'tag': tag,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取电影详情
  static Future<Movie> getMovieDetail(String movieId) async {
    Response response = await HttpUtils().get('/subject/$movieId', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Movie.fromMap(json.decode(response.data));
  }

  /// 影片剧照
  static Future<List<Photos>> getMovieAlbum(String movieId,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/subject/$movieId/photos',
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 影人详细信息
  static Future<Celebrity> getActorDetail(String actorId) async {
    Response response = await HttpUtils().get('/celebrity/$actorId', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Celebrity.fromMap(json.decode(response.data));
  }

  /// 影人相片
  static Future<List<Photos>> getActorPhotos(String actorId,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/celebrity/$actorId/photos',
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 剧照
  static Future<List<Photos>> getPhotos(String url, String id,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/$url/$id/photos', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 影人作品
  static Future<List<Movie>> getActorMovies(String actorId,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/celebrity/$actorId/works',
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    List<Movie> movies = [];
    result.works.map((work) {
      movies.add(work.subject);
    }).toList();
    return movies;
  }

  /// 短评
  static Future<List<Reviews>> getComments(String movieId,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/subject/$movieId/comments',
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.comments;
  }

  /// 影评
  static Future<List<Reviews>> getReviews(String movieId,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get('/subject/$movieId/reviews',
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.reviews;
  }

  /// 每日一文
  static Future<Article> getTodayArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .get(ApiUrl.ARTICLE_TODAY_URL, data: {'dev': 1});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
  }

  /// 特定日期文章
  static Future<Article> getDayArticle(String date) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .get(ApiUrl.ARTICLE_DAY_URL, data: {'dev': 1, 'date': date});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
  }

  /// 随机文章
  static Future<Article> getRandomArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .get(ApiUrl.ARTICLE_RANDOM_URL, data: {'dev': 1});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
  }

  /// 随机诗词
  static Future<Poetry> getRecommendPoetry() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.API_OPEN_BASE_URL)
        .get(ApiUrl.RECOMMEND_POETRY, data: null);
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.poetry;
  }

  /// 得到实况天气
  static Future<HeWeather> getHeWeatherNow(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.WEATHER_NOW, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 得到逐小时天气
  static Future<HeWeather> getHeWeatherHourly(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.WEATHER_HOURLY, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 得到3-10天天气
  static Future<HeWeather> getHeWeatherForecast(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.WEATHER_FORECAST, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 常规天气数据集合
  static Future<HeWeather> getHeWeather(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.WEATHER, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 日出日落
  static Future<HeWeather> getSunriseSunset(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.SUNRISE_SUNSET, data: {
      "location": city,
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 空气质量数据集合
  static Future<HeWeather> getAir(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.AIR, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 空气质量实况
  static Future<HeWeather> getAirNow(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.AIR_NOW, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 生活指数
  static Future<HeWeather> getLifeStyle(String city) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.WEATHER_BASE_URL)
        .get(ApiUrl.LIFESTYLE, data: {
      "location": city, // 所查询地区的纬度 纬度采用十进制格式，北纬为正，南纬为负
      "key": Config.HE_WEATHER_KEY,
      'unit': 'm', // 单位选择，公制（m）或英制（i），默认为公制单位
      'lang': 'zh', // 多语言，可以不使用该参数，默认为简体中文
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.heWeather[0];
  }

  /// 热门城市
  static Future<List<City>> getHotCitys() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.CITY_BASE_URL)
        .get(ApiUrl.CITY_TOP, data: {
      "group": "cn",
      "key": Config.HE_WEATHER_KEY,
      "number": 50,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return City.fromMapList(
        json.decode(response.data)['HeWeather6'][0]['basic']);
  }

  /// 搜索城市
  static Future<List<City>> getSeacherCitys(String keyword) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.CITY_BASE_URL)
        .get(ApiUrl.CITY_FIND, data: {
      "location": keyword,
      "group": "cn",
      // group=world 查询全球城市（默认值）;group=cn 仅查询中国城市;group=us,scenic 查询美国城市和中国景点地区;group=cn,us,ru 查询中国、美国和俄罗斯城市
      "key": Config.HE_WEATHER_KEY,
      "number": 20,
      'mode': 'match'
      // 查询方式（模糊检索 or 精准检索） 可选值: equal、match，默认：match
    });
    if (response.statusCode != 200) {
      return null;
    }
    return City.fromMapList(
        json.decode(response.data)['HeWeather6'][0]['basic']);
  }

  /// 煎蛋XXOO图
  static Future<List<Comment>> getJiandan(int page) async {
    Response response = await HttpUtils().get(ApiUrl.JIANDAN, data: {
      "page": page,
      'oxwlxojflwblxbsapi': 'jandan.get_ooxx_comments',
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Comment.fromMapList(json.decode(response.data)['comments']);
  }

  /// 百姓生活首页数据接口
  static Future<Baixing> getBaixingHomeData(String lon, String lat) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .post(ApiUrl.BAIXING_HOME, data: {
      "lon": lon,
      'lat': lat,
    });
    if (response.statusCode != 200) {
      return null;
    }
    if (json.decode(response.data)['code'] == '0') {
      return Baixing.fromMap(json.decode(response.data)['data']);
    } else {
      return null;
    }
  }

  /// 百姓生活首页火爆专区商品数据接口
  static Future<List<Goods>> getBaixingHomeHotData(int page) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .post(ApiUrl.BAIXING_HOME_HOT, data: {
      "page": page,
    });
    if (response.statusCode != 200) {
      return null;
    }
    if (json.decode(response.data)['code'] == '0' &&
        json.decode(response.data)['data'] != null) {
      return Goods.fromMapList(json.decode(response.data)['data']);
    } else {
      return [];
    }
  }

  /// 百姓生活分类数据接口
  static Future<List<Category>> getBaixingCategoryData() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .post(ApiUrl.BAIXING_CATEGORY);
    if (response.statusCode != 200) {
      return null;
    }
    if (json.decode(response.data)['code'] == '0' &&
        json.decode(response.data)['data'] != null) {
      return Category.fromMapList(json.decode(response.data)['data']);
    } else {
      return [];
    }
  }

  /// 百姓生活分类商品数据接口
  static Future<List<Goods>> getBaixingGoodsData(
    int page,
    String categoryId,
    String categorySubId,
  ) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .post(ApiUrl.BAIXING_GOODS, data: {
      "page": page,
      "categoryId": categoryId,
      "categorySubId": categorySubId,
    });
    if (response.statusCode != 200) {
      return null;
    }
    if (json.decode(response.data)['code'] == '0' &&
        json.decode(response.data)['data'] != null) {
      return Goods.fromMapList(json.decode(response.data)['data']);
    } else {
      return [];
    }
  }

  /// 百姓生活分类商品数据接口
  static Future<GoodsInfo> getBaixingGoodsDetailData(String goodId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BAIXING_BASE_URL)
        .post(ApiUrl.BAIXING_GOODS_DETAIL, data: {
      "goodId": goodId,
    });
    if (response.statusCode != 200) {
      return null;
    }
    if (json.decode(response.data)['code'] == '0' &&
        json.decode(response.data)['data'] != null) {
      return GoodsInfo.fromMap(json.decode(response.data)['data']);
    } else {
      return null;
    }
  }

  static Future<List<Contact>> getRandomUser({
    int page = 1,
    int results = 50,
    String gender,
    String format = 'json',
    String nat,
  }) async {
    Response response =
        await HttpUtils(baseUrl: ApiUrl.RANDOMUSER_URL).get('', data: {
      "page": page,
      "results": results,
      "gender": gender,
      "format": format,
      "nat": nat,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.contacts;
  }

  static Future<Cryptocurrency> getCryptocurrencyInfo(String id) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
      contentType: HttpUtils.CONTENT_TYPE_JSON,
    ).get(ApiUrl.CRYPTOCURRENCY_INFO, data: {
      // 一个或多个逗号分隔的硬币市值加密货币id。例如:“1,2”
      "id": id,
    });
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return Cryptocurrency.fromMap(json.decode(response.data)['data'], id: id);
    }
    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  static Future<List<KeyBean>> getCryptocurrencyMap(int start,
      {int limit = 10, String listing_status = 'active'}) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
    ).get(ApiUrl.CRYPTOCURRENCY_MAP, data: {
      // 默认情况下，只返回"active"硬币列表。通过“inactive”获得一个"active"的硬币列表。
      // 有效值: "active" "inactive"
      "listing_status": listing_status,
      "start": start,
      "limit": limit,
    });
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return KeyBean.fromMapList(json.decode(response.data)['data']);
    }
    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  static Future<List<KeyBean>> getCryptocurrencyLatest({
    int start = 1,
    int limit = 10,
    String convert = 'USD',
    String sort = 'market_cap',
    String sort_dir = 'desc',
    String cryptocurrency_type = 'all',
  }) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
    ).get(ApiUrl.CRYPTOCURRENCY_LATEST, data: {
      // Optionally calculate market quotes in up to 120 currencies at once by passing a comma-separated list of cryptocurrency or fiat currency symbols. Each additional convert option beyond the first requires an additional call credit. A list of supported fiat options can be found here. Each conversion is returned in its own "quote" object.
      "convert": convert,
      "start": start,
      "limit": limit,
      // 按哪个字段对加密货币列表排序。
      // 有效值 : "name" "symbol" "date_added" "market_cap" "price" "circulating_supply" "total_supply" "max_supply" "num_market_pairs" "volume_24h" "percent_change_1h" "percent_change_24h" "percent_change_7d"
      "sort": sort,
      // 根据指定的排序对加密货币排序的方向。
      // 有效值 : "asc" "desc"
      "sort_dir": sort_dir,
      // 要包含的加密货币的类型。
      // 有效值 : "all" "coins" "tokens"
      "cryptocurrency_type": cryptocurrency_type,
    });
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return KeyBean.fromMapList(json.decode(response.data)['data'],
          convert: convert);
    }

    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  static Future<Cryptocurrency> getCryptocurrencyQuoteLatest(String id,
      {String convert = 'USD'}) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
    ).get(ApiUrl.CRYPTOCURRENCY_QUOTE_LATEST,
        data: {'id': id, 'convert': convert});
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return Cryptocurrency.fromMap(json.decode(response.data)['data'],
          id: id, convert: convert);
    }
    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  static Future<KeyBean> getGlobalQuoteLatest({String convert = 'USD'}) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
    ).get(ApiUrl.GLOBAL_QUOTE_LATEST, data: {'convert': convert});
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return KeyBean.fromMap(json.decode(response.data)['data'],
          convert: convert);
    }
    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  static Future<KeyBean> getMarketPairsLatest(String id, int start,
      {String convert = 'USD', int limit = 20}) async {
    Response response = await HttpUtils(
      header: {'X-CMC_PRO_API_KEY': Config.COIN_MARKET_CAP_KEY},
      baseUrl: ApiUrl.COIN_MARKET_CAP_BASE_URL,
    ).get(ApiUrl.MARKET_PAIRS_LATEST, data: {
      'convert': convert,
    });
    if (json.decode(response.data)['status']['error_code'] == 0) {
      return KeyBean.fromMap(json.decode(response.data)['data'],
          convert: convert);
    }
    LogUtil.e('${json.decode(response.data)['status']['error_message']}');
    return null;
  }

  /// 获取句子迷上美图美句数据
  static Future<List<MeiTuMeiJu>> getMeiTuMeiJu(int page) async {
    final List<MeiTuMeiJu> data = [];
    await http
        .get(ApiUrl.JUZIMI_URL + 'meitumeiju/?page=$page')
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        dom.Element field =
            item.getElementsByClassName('views-field-phpcode').first;

        String image = field
            .getElementsByClassName('views-field-phpcode')
            .first
            .querySelector('a')
            .querySelector('img')
            .attributes['src'];

        LogUtil.v('http:$image');

        String desc = field
            .getElementsByClassName('views-field-phpcode-1')
            .first
            .querySelector('a')
            .text;

        LogUtil.v('$desc');

        String author = field
            .getElementsByClassName('views-field-name')
            .first
            .getElementsByClassName('views-field-xqname')
            .first
            .querySelector('a')
            .text;

        LogUtil.v('$author');

        int like = 0;
//        int.parse(field
//            .getElementsByClassName('views-field-ops')
//            .first
//            .querySelector('a')
//            .text
//            .replaceAll(')', '')
//            .replaceAll('喜欢(', ''));

        LogUtil.v('$like');

        data.add(MeiTuMeiJu(
            image: 'http:$image', like: like, desc: desc, author: author));
      });
    });

    LogUtil.v('${data.toString()}');

    return data;
  }

  /// 获取句子迷上美图美句数据
  /// category = shouxiemeiju、jingdianduibai
  static Future<List<String>> getMeiTuMeiJuImages(
      String category, int page) async {
    final List<String> data = [];
    await http
        .get(ApiUrl.JUZIMI_URL + 'meitumeiju/$category/?page=$page')
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        String image = item
            .getElementsByClassName('views-field-phpcode')
            .first
            .querySelector('a')
            .querySelector('img')
            .attributes['src'];

        LogUtil.v('http:$image');

        data.add('http:$image');
      });
    });

    LogUtil.v('$data');

    return data;
  }

  /// 获取句子迷上名人名句类别
  static Future<List<MingjuClassify>> getMingrenmingjuType() async {
    final List<MingjuClassify> data = [];
    await http
        .get(ApiUrl.JUZIMI_URL + '/writers')
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element content = document
          .getElementById('block-block-20')
          .getElementsByClassName('block-inner')
          .first
          .getElementsByClassName('content')
          .first
          .getElementsByClassName('contentin')
          .first;

      LogUtil.v('${content.toString()}');

      List<dom.Element> itemsTitle = content.getElementsByClassName("wrtitle");
      List<dom.Element> items = content.getElementsByClassName("wrlist");

      itemsTitle.forEach((item) {
        int index = itemsTitle.indexOf(item);

        String title = item.text.replaceAll('：', '');

        List<dom.Element> _items =
            items[index].getElementsByClassName('writersal');

        List<MingjuClassify> subData = [];
        _items.forEach((item) {
          String tag = item.attributes['href'];
          String subTitle = item.text;

          subData.add(MingjuClassify(tag: tag, title: subTitle));
        });

        data.add(MingjuClassify(title: '$title', classify: subData));
      });
    });

    LogUtil.v('${data.toString()}');

    return data;
  }

  /// 根据类别获取名人列表
  static Future<List<JuzimiCelebrity>> getCelebrityList(
      String category, int page) async {
    LogUtil.e(ApiUrl.JUZIMI_URL + '$category?page=$page');
    final List<JuzimiCelebrity> data = [];
    await http
        .get(ApiUrl.JUZIMI_URL + '$category' + (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        String imgUrl = item
            .getElementsByClassName('views-field-tid')
            .first
            .querySelector('a')
            .querySelector('img')
            .attributes['src'];

        String name = item
            .getElementsByClassName('views-field-name')
            .first
            .querySelector('a')
            .text;

        String desc = item
            .getElementsByClassName('views-field-phpcode')
            .first
            .getElementsByClassName('wridesccon')
            .first
            .getElementsByClassName('xqagepawirdesc')
            .first
            .text;

        data.add(
            JuzimiCelebrity(name: '$name', image: 'http:$imgUrl', desc: desc));
      });
    });

    LogUtil.v('${data.toString()}');

    return data;
  }

  /// 根据类别获取书籍等列表
  static Future<List<JuzimiBook>> getBookList(String category, int page) async {
    LogUtil.e(ApiUrl.JUZIMI_URL + '$category?page=$page');
    final List<JuzimiBook> data = [];
    await http
        .get(ApiUrl.JUZIMI_URL + '$category' + (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        String imgUrl = item
            .getElementsByClassName('views-field-tid')
            .first
            .querySelector('a')
            .querySelector('img')
            .attributes['src'];

        dom.Element field =
            item.getElementsByClassName('views-field-phpcode').first;

        String name = field
            .getElementsByClassName('xqallarticletilelinkspan')
            .first
            .querySelector('a')
            .text;

        String desc = field
            .getElementsByClassName('wridesccon')
            .first
            .getElementsByClassName('xqagepawirdesc')
            .first
            .text;

        String author = '';
        dom.Element a = field.querySelectorAll('a')[1];
        if (a != null) {
          author = field.querySelectorAll('a')[1].text;
        }

        String id = field
            .querySelector('a')
            .attributes['href']
            .replaceAll('/article/', '');

        data.add(JuzimiBook(
            name: '$name',
            image: 'http:$imgUrl',
            desc: desc,
            author: author,
            id: id));
      });
    });

    LogUtil.v('${data.toString()}');

    return data;
  }
}
