import 'package:dio/dio.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/movie/bean/celebrity.dart';
import 'package:flutter_app/movie/bean/movie.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/bean/result.dart';
import 'package:flutter_app/utils/http_utils.dart';

class ApiService {
  static final String MOVIE_BASE_URL = "https://api.douban.com/v2/movie";
  static final String MOVIE_LIST_URL = "/in_theaters";
  static final String MOVIE_DETAIL_URL = "/subject";
  static final String MOVIE_TOP250_URL = "/top250";
  static final String MOVIE_SEARCH_URL = "/search";
  static final String MOVIE_SOON_URL = "/coming_soon";

  static final String NEW_MOVIES_URL = "/new_movies";

  static final String WEEKLY_MOVIES_URL = "/weekly";

  static final String US_MOVIES_URL = "/us_box";

  /// 获取正在上映电影
  static Future<List<Movie>> getNowPlayingList({String city}) async {
    Response response = await HttpUtils().get(MOVIE_LIST_URL, data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
      'city': city,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);

    return result.subjects;
  }

  /// 获取即将上映电影
  static Future<List<Movie>> getComingList({int start, int count}) async {
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
  static Future<List<Movie>> getTop250List({int start, int count}) async {
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
      {String tag, int start, int count}) async {
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
      {String key, int start, int count}) async {
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
  static Future<List<Photos>> getMovieAlbum(String movieId) async {
    Response response =
        await HttpUtils().get('/subject/$movieId/photos', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);
    return result.photos;
  }

  /// 演员详细信息
  static Future<Celebrity> getActorDetail(String actorId) async {
    Response response =
        await HttpUtils().get('/celebrity/$actorId/photos', data: {
      'apikey': Config.DOUBAN_MOVIE_KEY,
    });
    if (response.statusCode != 200) {
      return null;
    }
    Result result = Result.fromMap(response.data);
    return result.celebrity;
  }
}
