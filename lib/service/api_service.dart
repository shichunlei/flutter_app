import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/bean/baixing.dart';
import 'package:flutter_app/bean/youdao.dart';
import 'package:flutter_app/bean/contact.dart';
import 'package:flutter_app/qdaily/index.dart';

import '../bean/bean_index.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import '../page_index.dart';

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

    print(news.toString());

    return news;
  }

  /// 获取正在热映电影
  static Future<List<Movie>> getNowPlayingList(
      {String city, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_LIST_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'city': city,
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList(
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_SOON_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      "start": start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取排行榜电影
  static Future<List<Movie>> getRankingList(String url,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(url, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取本周口碑榜电影
  static Future<List<Movie>> getWeeklyList() async {
    Response response = await HttpUtils().request(ApiUrl.WEEKLY_MOVIES_URL,
        data: {'apikey': Config.DOUBAN_MOVIE_KEY});
    if (response.statusCode != 200) {
      return [];
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
    Response response = await HttpUtils().request(ApiUrl.NEW_MOVIES_URL,
        data: {'apikey': Config.DOUBAN_MOVIE_KEY});
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取北美票房榜电影
  static Future<List<Movie>> getUsBoxList() async {
    Response response = await HttpUtils().request(ApiUrl.US_MOVIES_URL,
        data: {'apikey': Config.DOUBAN_MOVIE_KEY});
    if (response.statusCode != 200) {
      return [];
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
    Response response = await HttpUtils().request(ApiUrl.MOVIE_TOP250_URL,
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 根据标签搜索
  static Future<List<Movie>> getSearchListByTag(
      {String tag, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_SEARCH_URL,
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'tag': tag,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 根据关键字搜索
  static Future<List<Movie>> getSearchListByKey(
      {String key, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().request(ApiUrl.MOVIE_SEARCH_URL,
        data: {
          'apikey': Config.DOUBAN_MOVIE_KEY,
          'q': key,
          'start': start,
          'count': count
        });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 搜索电影
  static Future<List<Movie>> getSearchList(
      {String key, String tag, int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'q': key,
      'tag': tag,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));

    return result.subjects;
  }

  /// 获取电影详情
  static Future<Movie> getMovieDetail(String movieId) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_DETAIL_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'movieId': movieId,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Movie.fromMap(json.decode(response.data));
  }

  /// 影片剧照
  static Future<List<Photos>> getMovieAlbum(String movieId,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_PHOTO_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'movieId': movieId
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 影人详细信息
  static Future<Celebrity> getActorDetail(String actorId) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_CELEBRITY_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'actorId': actorId,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Celebrity.fromMap(json.decode(response.data));
  }

  /// 影人相片
  static Future<List<Photos>> getActorPhotos(String actorId,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_CELEBRITY_PHOTOS_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'actorId': actorId,
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 剧照
  static Future<List<Photos>> getPhotos(String url, String id,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_PHOTOS_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'url': url,
      'id': id
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.photos;
  }

  /// 影人作品
  static Future<List<Movie>> getActorMovies(String actorId,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_CELEBRITY_WORKS_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'actorId': actorId
    });
    if (response.statusCode != 200) {
      return [];
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
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_COMMENTS_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'movieId': movieId
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.comments;
  }

  /// 影评
  static Future<List<Reviews>> getReviews(String movieId,
      {int start = 0, int count = 20}) async {
    Response response =
        await HttpUtils().request(ApiUrl.MOVIE_REVIEWS_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
      'movieId': movieId
    });
    if (response.statusCode != 200) {
      return [];
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.reviews;
  }

  /// 每日一文
  static Future<Article> getTodayArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .request(ApiUrl.ARTICLE_TODAY_URL, data: {'dev': 1});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
  }

  /// 特定日期文章
  static Future<Article> getDayArticle(String date) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .request(ApiUrl.ARTICLE_DAY_URL, data: {'dev': 1, 'date': date});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
  }

  /// 随机文章
  static Future<Article> getRandomArticle() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.ARTICLE_BASE_URL)
        .request(ApiUrl.ARTICLE_RANDOM_URL, data: {'dev': 1});
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.article;
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
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
    return result.heWeather[0];
  }

  /// 热门城市
  static Future<List<City>> getHotCities(
      {String group: 'world', int number: 50}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.CITY_BASE_URL)
        .request(ApiUrl.CITY_TOP, data: {
      "group": "world",
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
      return null;
    }
    return City.fromMapList(
        json.decode(response.data)['HeWeather6'][0]['basic']);
  }

  /// 煎蛋XXOO图
  static Future<List<Comment>> getJiandan(int page) async {
    Response response = await HttpUtils().request(ApiUrl.JIANDAN, data: {
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
        .request(ApiUrl.BAIXING_HOME,
            data: {
              "lon": lon,
              'lat': lat,
            },
            method: HttpUtils.POST);
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
        .request(ApiUrl.BAIXING_HOME_HOT,
            data: {
              "page": page,
            },
            method: HttpUtils.POST);
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
        .request(ApiUrl.BAIXING_CATEGORY, method: HttpUtils.POST, data: null);
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
        .request(ApiUrl.BAIXING_GOODS,
            data: {
              "page": page,
              "categoryId": categoryId,
              "categorySubId": categorySubId,
            },
            method: HttpUtils.POST);
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
        .request(ApiUrl.BAIXING_GOODS_DETAIL,
            data: {
              "goodId": goodId,
            },
            method: HttpUtils.POST);
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
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.contacts;
  }

  /// 获取句子迷上美图美句数据
  static Future<JuzimiResult> getMeiTuMeiJu(int page) async {
    JuzimiResult result;
    await http
        .get(
            ApiUrl.JUZIMI_URL + 'meitumeiju' + (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element pager = document
          .getElementsByClassName('item-list')
          .first
          .getElementsByClassName('pager')
          .first;

      List<dom.Element> pages = pager.querySelectorAll('li');

      int currentPage =
          int.parse(pager.getElementsByClassName('pager-current').first.text);

      int totalPage;

      List<dom.Element> nextPage = pager.getElementsByClassName('pager-next');
      if (nextPage.isEmpty) {
        totalPage = currentPage;
      } else {
        totalPage = int.parse(pages[pages.length - 3].text);
      }

      final List<MeiTuMeiJu> data = [];

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

        print('http:$image');

        String desc = field
            .getElementsByClassName('views-field-phpcode-1')
            .first
            .querySelector('a')
            .text;

        print('$desc');

        String author = field
            .getElementsByClassName('views-field-name')
            .first
            .getElementsByClassName('views-field-xqname')
            .first
            .querySelector('a')
            .text;

        print('$author');

        String like = field
            .getElementsByClassName('views-field-ops')
            .first
            .querySelector('a')
            .text
            .replaceAll(')', '')
            .replaceAll('(', '');

        print('$like');

        data.add(MeiTuMeiJu(
            image: 'http:$image', like: like, desc: desc, author: author));
      });

      result = JuzimiResult(totalPage, currentPage, meijus: data);
    });

    print('${result.toString()}');

    return result;
  }

  /// 获取句子迷上美图美句数据
  /// category = shouxiemeiju、jingdianduibai
  static Future<JuzimiResult> getMeiTuMeiJuImages(
      String category, int page) async {
    JuzimiResult result;

    await http
        .get(ApiUrl.JUZIMI_URL +
            'meitumeiju/$category' +
            (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element pager = document
          .getElementsByClassName('item-list')
          .first
          .getElementsByClassName('pager')
          .first;

      List<dom.Element> pages = pager.querySelectorAll('li');

      int currentPage =
          int.parse(pager.getElementsByClassName('pager-current').first.text);

      int totalPage;

      List<dom.Element> nextPage = pager.getElementsByClassName('pager-next');
      if (nextPage.isEmpty) {
        totalPage = currentPage;
      } else {
        totalPage = int.parse(pages[pages.length - 3].text);
      }

      final List<MeiTuMeiJu> data = [];

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

        print('http:$image');

        data.add(MeiTuMeiJu(image: image));
      });

      result = JuzimiResult(totalPage, currentPage, meijus: data);
    });

    print('${result.toString()}');

    return result;
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

      print('${content.toString()}');

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

    /// 精选句集
    List<MingjuClassify> _subData = [];
    _subData
      ..add(MingjuClassify(title: '精选句集', tag: 'albums'))
      ..add(MingjuClassify(title: '最新句集', tag: 'newalbums'));
    data.add(MingjuClassify(title: '精选句集', classify: _subData));

    /// 原创
    List<MingjuClassify> subData = [];
    subData
      ..add(MingjuClassify(title: '本周热门原创', tag: 'original/week'))
      ..add(MingjuClassify(title: '最新原创句子', tag: 'original/ju'))
      ..add(MingjuClassify(title: '推荐原创句子', tag: 'original/recommend'));
    data.add(MingjuClassify(title: '原创句子', classify: subData));

    print('${data.toString()}');

    return data;
  }

  /// 根据类别获取名人列表
  static Future<JuzimiResult> getCelebrityList(
      String category, int page) async {
    print('${ApiUrl.JUZIMI_URL}$category?page=$page');

    JuzimiResult result;

    Response response = await HttpUtils(
      baseUrl: ApiUrl.JUZIMI_URL,
    ).request(category, data: page == 0 ? null : {"page": page});

    var document = parse(response.data.toString());

    dom.Element pager = document
        .getElementsByClassName('item-list')
        .first
        .getElementsByClassName('pager')
        .first;

    List<dom.Element> pages = pager.querySelectorAll('li');

    int currentPage =
        int.parse(pager.getElementsByClassName('pager-current').first.text);

    int totalPage;

    List<dom.Element> nextPage =
        pager.getElementsByClassName('pager-next last');
    if (nextPage.isEmpty) {
      totalPage = currentPage;
    } else {
      totalPage = int.parse(pages[pages.length - 2].text);
    }

    print('$totalPage======================$currentPage');

    final List<JuzimiCelebrity> data = [];

    dom.Element content = document.getElementsByClassName('view-content').first;

    List<dom.Element> items = content.getElementsByClassName("views-row");

    items.forEach((item) {
      dom.Element img = item
          .getElementsByClassName('views-field-tid')
          .first
          .querySelector('a')
          .querySelector('img');

      String imgUrl =
          'http://img0.imgtn.bdimg.com/it/u=462445641,233137983&fm=26&gp=0.jpg';
      if (img != null) {
        imgUrl = img.attributes['src'];
      }

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

    result = JuzimiResult(totalPage, currentPage, celebrity: data);

//    print('${result.toString()}');

    return result;
  }

  /// 根据类别获取书籍等列表
  static Future<JuzimiResult> getBookList(String category, int page) async {
    print(ApiUrl.JUZIMI_URL + '$category?page=$page');
    JuzimiResult result;

    await http
        .get(ApiUrl.JUZIMI_URL + '$category' + (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element pager = document
          .getElementsByClassName('item-list')
          .first
          .getElementsByClassName('pager')
          .first;

      List<dom.Element> pages = pager.querySelectorAll('li');

      int currentPage =
          int.parse(pager.getElementsByClassName('pager-current').first.text);

      int totalPage;

      List<dom.Element> nextPage =
          pager.getElementsByClassName('pager-next last');
      if (nextPage.isEmpty) {
        totalPage = currentPage;
      } else {
        totalPage = int.parse(pages[pages.length - 2].text);
      }

      final List<JuzimiBook> data = [];

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        dom.Element img = item
            .getElementsByClassName('views-field-tid')
            .first
            .querySelector('a')
            .querySelector('img');
        String imgUrl =
            'http://img0.imgtn.bdimg.com/it/u=462445641,233137983&fm=26&gp=0.jpg';
        if (img != null) {
          imgUrl = img.attributes['src'];
        }

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

      result = JuzimiResult(totalPage, currentPage, books: data);
    });

    print('${result.toString()}');

    return result;
  }

  /// 获取名言/美句列表
  static Future<JuzimiResult> getAlbumList(String category, int page) async {
    print(ApiUrl.JUZIMI_URL + '$category?page=$page');
    JuzimiResult result;

    await http
        .get(ApiUrl.JUZIMI_URL + '$category' + (page == 0 ? '?page=$page' : ''))
        .then((http.Response response) {
      var document = parse(response.body.toString());

      dom.Element pager = document
          .getElementsByClassName('item-list')
          .first
          .getElementsByClassName('pager')
          .first;

      List<dom.Element> pages = pager.querySelectorAll('li');

      int currentPage =
          int.parse(pager.getElementsByClassName('pager-current').first.text);

      int totalPage;

      List<dom.Element> nextPage = pager.getElementsByClassName('pager-next');
      if (nextPage.isEmpty) {
        totalPage = currentPage;
      } else {
        totalPage = int.parse(pages[pages.length - 3].text);
      }

      final List<MeiTuMeiJu> data = [];

      dom.Element content =
          document.getElementsByClassName('view-content').first;

      List<dom.Element> items = content.getElementsByClassName("views-row");

      items.forEach((item) {
        dom.Element field =
            item.getElementsByClassName('views-field-phpcode').first;

        dom.Element phpcode_1 = field
            .getElementsByClassName('views-field-phpcode-1')
            .first
            .querySelector('a');

        String id = phpcode_1.attributes['href'].replaceAll('/ju/', '');

        String desc = phpcode_1.text;

        List<dom.Element> elements =
            field.getElementsByClassName('xqjulistwafo');

        String author = '';
        String source = '';
        if (elements.isNotEmpty) {
          dom.Element authorElement = elements.first.querySelector('a');
          if (authorElement != null) {
            // 作者
            author = authorElement.text;
          }

          List<dom.Element> elementAuthor =
              elements.first.getElementsByClassName('xqjulistori');

          if (elementAuthor.isNotEmpty) {
            // 原创
            author = elementAuthor.first
                .getElementsByClassName('xqfulunvis')
                .first
                .text;
          }

          List<dom.Element> elementSource = elements.first
              .getElementsByClassName('views-field-field-oriarticle-value');

          if (elementSource.isNotEmpty) {
            // 出处
            source = elementSource.first.querySelector('a').text;
          }
        }

        String publisher = field
            .getElementsByClassName('views-field-name')
            .first
            .getElementsByClassName('views-field-xqname')
            .first
            .querySelector('a')
            .text;

        String like = field
            .getElementsByClassName('views-field-ops')
            .first
            .querySelector('a')
            .text
            .replaceAll('喜欢(', '')
            .replaceAll(')', '');

        data.add(MeiTuMeiJu(
            desc: desc,
            author: author,
            id: id,
            publisher: publisher,
            like: like,
            source: source));
      });

      result = JuzimiResult(totalPage, currentPage, meijus: data);
    });

    print('${result.toString()}');

    return result;
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
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(json.decode(response.data));
    return result.images;
  }

  /// 获取全部新闻(首页)
  static Future<ResponseBean> getQdailyHomeData(String lastKey) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL)
        .request("${ApiUrl.QDAILY_HOME_DATA}$lastKey.json", data: null);
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 获取某分类下的新闻
  static Future<ResponseBean> getQdailyNewsDataByCategory(
      int tagId, String lastKey) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL).request(
        ApiUrl.QDAILY_CATEGORY_DATA + "$tagId/$lastKey.json",
        data: null);
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 获取文章/新闻评论
  static Future<ResponseBean> getQdailyCommentData(int id,
      {String dataType = 'article', String lastKey = '0'}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL).request(
        "${ApiUrl.QDAILY_COMMENT_DATA}$dataType/$id/$lastKey.json",
        data: null);
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 栏目列表
  static Future<DataBean> getQdailyColumnList(String lastKey) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_WEB_URL)
        .request("${ApiUrl.QDAILY_COLUMN_LIST_DATA}$lastKey.json", data: null);
    if (response.statusCode != 200) {
      return null;
    }
    QdailyResult result = QdailyResult.fromMap(json.decode(response.data));
    return result.data;
  }

  /// 栏目信息
  static Future<ResponseBean> getQdailyColumnInfo(int columnId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL)
        .request(ApiUrl.QDAILY_COLUMN_INFO_DATA, data: {'columnId': columnId});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 栏目新闻
  static Future<ResponseBean> getQdailyColumnIndex(
      int columnId, String lastKey) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL).request(
        ApiUrl.QDAILY_COLUMN_INDEX_DATA,
        data: {'lastKey': lastKey, 'columnId': columnId});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 好奇心研究所
  static Future<ResponseBean> getQdailyLabsData(String lastKey) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL)
        .request(ApiUrl.QDAILY_LAB_INDEX_DATA, data: {'lastKey': lastKey});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 好奇心研究所详情
  static Future<ResponseBean> getQdailyLabsDetailData(int labId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL)
        .request(ApiUrl.QDAILY_LAB_DETAIL_DATA, data: {'labId': labId});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 获取文章/新闻简介
  static Future<ResponseBean> getQDailyArticleInfoData(int articleId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_APP_URL).request(
        ApiUrl.QDAILY_ARTICLE_INFO_URL,
        data: {'articleId': articleId});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyAppResult result =
        QdailyAppResult.fromMap(json.decode(response.data));
    return result.response;
  }

  /// 搜索
  static Future<DataBean> getQDailySearchData(
      String keywords, String last_key) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_WEB_URL).request(
        ApiUrl.QDAILY_SEARCH_WEB_DATA,
        data: {"last_key": last_key, "key": keywords});
    if (response.statusCode != 200) {
      return null;
    }
    QdailyResult result = QdailyResult.fromMap(json.decode(response.data));
    return result.data;
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
    if (response.statusCode != 200) {
      return null;
    }
    YoudaoResult result = YoudaoResult.fromMap(json.decode(response.data));
    return result.data.course;
  }
}
