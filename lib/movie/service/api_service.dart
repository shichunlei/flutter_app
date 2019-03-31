import 'package:dio/dio.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/celebrity.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/news.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/log_util.dart';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

class ApiService {
  static final String MOVIE_LIST_URL = "/in_theaters";
  static final String MOVIE_DETAIL_URL = "/subject";
  static final String MOVIE_TOP250_URL = "/top250";
  static final String MOVIE_SEARCH_URL = "/search";
  static final String MOVIE_SOON_URL = "/coming_soon";

  static final String NEW_MOVIES_URL = "/new_movies";

  static final String WEEKLY_MOVIES_URL = "/weekly";

  static final String US_MOVIES_URL = "/us_box";

  /// 获取首页热门新闻文章
  static Future<List<News>> getNewsList() async {
    List<News> news = [];

    await http.get(Config.DOUBAN_WEB_URL).then((http.Response response) {
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
        News movieNews = new News(title, cover, summary, link);
        news.add(movieNews);
      });
    });

    LogUtil.v(news.toString());

    return news;
  }

  /// 获取正在上映电影
  static Future<List<Movie>> getNowPlayingList(
      {String city, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(MOVIE_LIST_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'city': city,
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList(
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(MOVIE_SOON_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      "start": start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取排行榜电影
  static Future<List<Movie>> getRankingList(String url,
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(url, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取本周口碑榜电影
  static Future<List<Movie>> getWeeklyList() async {
    Response response = await HttpUtils().get(WEEKLY_MOVIES_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取新片榜电影
  static Future<List<Movie>> getNewMoviesList() async {
    Response response = await HttpUtils().get(NEW_MOVIES_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取北美票房榜电影
  static Future<List<Movie>> getUsBoxList() async {
    Response response = await HttpUtils().get(US_MOVIES_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取 top250 榜单
  static Future<List<Movie>> getTop250List(
      {int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(MOVIE_TOP250_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 根据标签搜索
  static Future<List<Movie>> getSearchListByTag(
      {String tag, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'tag': tag,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 根据关键字搜索
  static Future<List<Movie>> getSearchListByKey(
      {String key, int start = 0, int count = 20}) async {
    Response response = await HttpUtils().get(MOVIE_SEARCH_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'q': key,
      'start': start,
      'count': count
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

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
    return Movie.fromMap(response.data);
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
    Result result = Result.fromMap(response.data);
    return result.photos;
  }

  /// 演员详细信息
  static Future<Celebrity> getActorDetail(String actorId) async {
    Response response = await HttpUtils().get('/celebrity/$actorId', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    return Celebrity.fromMap(response.data);
  }

  /// 演员剧照
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
    Result result = Result.fromMap(response.data);
    return result.photos;
  }
}
