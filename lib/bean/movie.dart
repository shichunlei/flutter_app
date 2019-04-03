import 'package:flutter_app/bean/bloopers.dart';
import 'package:flutter_app/bean/casts.dart';
import 'package:flutter_app/bean/clips.dart';
import 'package:flutter_app/bean/images.dart';
import 'package:flutter_app/bean/photos.dart';
import 'package:flutter_app/bean/rating.dart';
import 'package:flutter_app/bean/reviews.dart';
import 'package:flutter_app/bean/trailers.dart';
import 'package:flutter_app/bean/videos.dart';

class Movie {
  /// 原名
  String original_title;

  /// 豆瓣小站
  String douban_site;

  /// 年代
  String year;

  /// 条目页URL
  String alt;

  /// id
  String id;

  /// 移动版条目页URL
  String mobile_url;

  /// 兼容性数据，未来会去掉，大陆上映日期，如果条目类型是电影则为上映日期，如果是电视剧则为首播日期
  String pubdate;

  /// 中文名
  String title;

  /// 分享链接
  String share_url;

  /// 影讯页URL(movie only)
  String schedule_url;

  /// 官方网站
  String website;

  /// 大陆上映日期，如果条目类型是电影则为上映日期，如果是电视剧则为首播日期
  String mainland_pubdate;

  /// 简介
  String summary;

  /// 条目分类, movie或者tv
  String subtype;

  ///
  bool has_video;

  /// 是否预定
  bool has_schedule;

  /// 是否有票
  bool has_ticket;

  /// 排行
  int rank;

  /// 排名改变量
  int delta;

  /// 影片
  Movie subject;

  /// 票房
  num box;

  /// 是否新上映
  bool is_new;

  /// 在看人数，如果是电视剧，默认值为0，如果是电影值为null
  int do_count;

  /// 总季数(tv only)
  int seasons_count;

  /// 收藏
  dynamic collection;

  /// 当前季的集数(tv only)
  String episodes_count;

  /// 当前季数(tv only)
  String current_season;

  /// 影评数量
  int reviews_count;

  /// 想看人数
  int wish_count;

  /// 看过人数
  int collect_count;

  /// 剧照数量
  int photos_count;

  /// 短评数量
  int comments_count;

  /// 评分人数
  int ratings_count;

  /// 电影海报图，分别提供288px x 465px(大)，96px x 155px(中) 64px x 103px(小)尺寸
  Images images;

  /// 评分
  Rating rating;

  /// 又名
  List<String> aka;

  /// 花絮URL，对高级用户以上开放，最多开放4个地址
  List<String> blooper_urls;

  /// 片段URL，对高级用户以上开放，最多开放4个地址
  List<String> clip_urls;

  /// 制片国家/地区
  List<String> countries;

  /// 片长
  List<String> durations;

  /// 影片类型，最多提供3个
  List<String> genres;

  /// 语言
  List<String> languages;

  /// 如果条目类型是电影则为上映日期，如果是电视剧则为首Ï日期
  List<String> pubdates;

  /// 标签
  List<String> tags;

  /// 预告片URL，对高级用户以上开放，最多开放4个地址
  List<String> trailer_urls;

  /// 花絮，对高级用户以上开放
  List<Bloopers> bloopers;

  /// 片段，对高级用户以上开放
  List<Clips> clips;

  /// 电影剧照，前10张
  List<Photos> photos;

  /// 热评
  List<Reviews> popular_comments;

  /// 影评，前10条
  List<Reviews> popular_reviews;
  List<Trailers> trailers;
  List<Videos> videos;

  /// 导演
  List<Casts> directors;

  /// 主演，最多可获得4个
  List<Casts> casts;

  /// 编剧
  List<Casts> writers;

  static Movie fromMap(Map<String, dynamic> map) {
    Movie movie = Movie();
    movie.original_title = map['original_title'];
    movie.douban_site = map['douban_site'];
    movie.year = map['year'];
    movie.alt = map['alt'];
    movie.id = map['id'];
    movie.mobile_url = map['mobile_url'];
    movie.pubdate = map['pubdate'];
    movie.title = map['title'];
    movie.share_url = map['share_url'];
    movie.schedule_url = map['schedule_url'];
    movie.website = map['website'];
    movie.mainland_pubdate = map['mainland_pubdate'];
    movie.summary = map['summary'];
    movie.subtype = map['subtype'];
    movie.has_video = map['has_video'];
    movie.has_schedule = map['has_schedule'];
    movie.has_ticket = map['has_ticket'];
    movie.do_count = map['do_count'] == null ? 0 : map['do_count'];
    movie.seasons_count =
        map['seasons_count'] == null ? 0 : map['seasons_count'];
    movie.collection = map['collection'];
    movie.episodes_count =
        map['episodes_count'] == null ? '0' : map['episodes_count'];
    movie.current_season =
        map['current_season'] == null ? '0' : map['current_season'];
    movie.reviews_count = map['reviews_count'];
    movie.wish_count = map['wish_count'];
    movie.collect_count = map['collect_count'];
    movie.photos_count = map['photos_count'];
    movie.comments_count = map['comments_count'];
    movie.ratings_count = map['ratings_count'];

    movie.is_new = map['new'];
    movie.box = map['box'];
    movie.rank = map['rank'];
    movie.delta = map['delta'];
    movie.subject =
        map['subject'] == null ? null : Movie.fromMap(map['subject']);

    movie.images = map['images'] == null ? null : Images.fromMap(map['images']);
    movie.rating = map['rating'] == null ? null : Rating.fromMap(map['rating']);
    movie.bloopers =
        map['bloopers'] == null ? [] : Bloopers.fromMapList(map['bloopers']);
    movie.casts = map['casts'] == null ? [] : Casts.fromMapList(map['casts']);
    movie.clips = map['clips'] == null ? [] : Clips.fromMapList(map['clips']);
    movie.directors =
        map['directors'] == null ? [] : Casts.fromMapList(map['directors']);
    movie.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    movie.popular_comments = map['popular_comments'] == null
        ? []
        : Reviews.fromMapList(map['popular_comments']);
    movie.popular_reviews = map['popular_reviews'] == null
        ? []
        : Reviews.fromMapList(map['popular_reviews']);
    movie.trailers =
        map['trailers'] == null ? [] : Trailers.fromMapList(map['trailers']);
    movie.videos =
        map['videos'] == null ? [] : Videos.fromMapList(map['videos']);
    movie.writers =
        map['writers'] == null ? [] : Casts.fromMapList(map['writers']);

    List<dynamic> aka = map['aka'] == null ? [] : map['aka'];
    movie.aka = List();
    movie.aka.addAll(aka.map((o) => o.toString()));

    List<dynamic> blooper_urls =
        map['blooper_urls'] == null ? [] : map['blooper_urls'];
    movie.blooper_urls = List();
    movie.blooper_urls.addAll(blooper_urls.map((o) => o.toString()));

    List<dynamic> clip_urls = map['clip_urls'] == null ? [] : map['clip_urls'];
    movie.clip_urls = List();
    movie.clip_urls.addAll(clip_urls.map((o) => o.toString()));

    List<dynamic> countries = map['countries'] == null ? [] : map['countries'];
    movie.countries = List();
    movie.countries.addAll(countries.map((o) => o.toString()));

    List<dynamic> durations = map['durations'] == null ? [] : map['durations'];
    movie.durations = List();
    movie.durations.addAll(durations.map((o) => o.toString()));

    List<dynamic> genres = map['genres'] == null ? [] : map['genres'];
    movie.genres = List();
    movie.genres.addAll(genres.map((o) => o.toString()));

    List<dynamic> languages = map['languages'] == null ? [] : map['languages'];
    movie.languages = List();
    movie.languages.addAll(languages.map((o) => o.toString()));

    List<dynamic> pubdates = map['pubdates'] == null ? [] : map['pubdates'];
    movie.pubdates = List();
    movie.pubdates.addAll(pubdates.map((o) => o.toString()));

    List<dynamic> tagList = map['tags'] == null ? [] : map['tags'];
    movie.tags = List();
    movie.tags.addAll(tagList.map((o) => o.toString()));

    List<dynamic> trailerUrlList =
        map['trailer_urls'] == null ? [] : map['trailer_urls'];
    movie.trailer_urls = List();
    movie.trailer_urls.addAll(trailerUrlList.map((o) => o.toString()));

    return movie;
  }

  static List<Movie> fromMapList(dynamic mapList) {
    List<Movie> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
