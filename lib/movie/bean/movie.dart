import 'package:flutter_app/movie/bean/bloopers.dart';
import 'package:flutter_app/movie/bean/casts.dart';
import 'package:flutter_app/movie/bean/clips.dart';
import 'package:flutter_app/movie/bean/directors.dart';
import 'package:flutter_app/movie/bean/images.dart';
import 'package:flutter_app/movie/bean/photos.dart';
import 'package:flutter_app/movie/bean/popular_comments.dart';
import 'package:flutter_app/movie/bean/popular_reviews.dart';
import 'package:flutter_app/movie/bean/rating.dart';
import 'package:flutter_app/movie/bean/trailers.dart';
import 'package:flutter_app/movie/bean/videos.dart';
import 'package:flutter_app/movie/bean/writers.dart';

class Movie {
  String original_title;
  String douban_site;
  String year;
  String alt;
  String id;
  String mobile_url;
  String pubdate;
  String title;
  String share_url;
  String schedule_url;
  String website;
  String mainland_pubdate;
  String summary;
  String subtype;
  bool has_video;
  bool has_schedule;
  bool has_ticket;
  dynamic do_count;
  dynamic seasons_count;
  dynamic collection;
  dynamic episodes_count;
  dynamic current_season;
  int reviews_count;
  int wish_count;
  int collect_count;
  int photos_count;
  int comments_count;
  int ratings_count;
  Images images;
  Rating rating;
  List<String> aka;
  List<String> blooper_urls;
  List<String> clip_urls;
  List<String> countries;
  List<String> durations;
  List<String> genres;
  List<String> languages;
  List<String> pubdates;
  List<String> tags;
  List<String> trailer_urls;
  List<Bloopers> bloopers;
  List<Casts> casts;
  List<Clips> clips;
  List<Directors> directors;
  List<Photos> photos;
  List<PopularComments> popular_comments;
  List<PopularReviews> popular_reviews;
  List<Trailers> trailers;
  List<Videos> videos;
  List<Writers> writers;

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
    movie.do_count = map['do_count'];
    movie.seasons_count = map['seasons_count'];
    movie.collection = map['collection'];
    movie.episodes_count = map['episodes_count'];
    movie.current_season = map['current_season'];
    movie.reviews_count = map['reviews_count'];
    movie.wish_count = map['wish_count'];
    movie.collect_count = map['collect_count'];
    movie.photos_count = map['photos_count'];
    movie.comments_count = map['comments_count'];
    movie.ratings_count = map['ratings_count'];
    movie.images = map['images'] == null ? null : Images.fromMap(map['images']);
    movie.rating = map['rating'] == null ? null : Rating.fromMap(map['rating']);
    movie.bloopers =
        map['bloopers'] == null ? [] : Bloopers.fromMapList(map['bloopers']);
    movie.casts = map['casts'] == null ? [] : Casts.fromMapList(map['casts']);
    movie.clips = map['clips'] == null ? [] : Clips.fromMapList(map['clips']);
    movie.directors =
        map['directors'] == null ? [] : Directors.fromMapList(map['directors']);
    movie.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    movie.popular_comments = map['popular_comments'] == null
        ? []
        : PopularComments.fromMapList(map['popular_comments']);
    movie.popular_reviews = map['popular_reviews'] == null
        ? []
        : PopularReviews.fromMapList(map['popular_reviews']);
    movie.trailers =
        map['trailers'] == null ? [] : Trailers.fromMapList(map['trailers']);
    movie.videos =
        map['videos'] == null ? [] : Videos.fromMapList(map['videos']);
    movie.writers =
        map['writers'] == null ? [] : Writers.fromMapList(map['writers']);

    List<dynamic> aka = map['aka'] == null ? [] : map['aka'];
    movie.aka = List();
    movie.aka.addAll(aka.map((o) => o.toString()));

    List<dynamic> dynamicList1 =
        map['blooper_urls'] == null ? [] : map['blooper_urls'];
    movie.blooper_urls = List();
    movie.blooper_urls.addAll(dynamicList1.map((o) => o.toString()));

    List<dynamic> dynamicList2 =
        map['clip_urls'] == null ? [] : map['clip_urls'];
    movie.clip_urls = List();
    movie.clip_urls.addAll(dynamicList2.map((o) => o.toString()));

    List<dynamic> dynamicList3 =
        map['countries'] == null ? [] : map['countries'];
    movie.countries = List();
    movie.countries.addAll(dynamicList3.map((o) => o.toString()));

    List<dynamic> dynamicList4 =
        map['durations'] == null ? [] : map['durations'];
    movie.durations = List();
    movie.durations.addAll(dynamicList4.map((o) => o.toString()));

    List<dynamic> dynamicList5 = map['genres'] == null ? [] : map['genres'];
    movie.genres = List();
    movie.genres.addAll(dynamicList5.map((o) => o.toString()));

    List<dynamic> dynamicList6 =
        map['languages'] == null ? [] : map['languages'];
    movie.languages = List();
    movie.languages.addAll(dynamicList6.map((o) => o.toString()));

    List<dynamic> dynamicList7 = map['pubdates'] == null ? [] : map['pubdates'];
    movie.pubdates = List();
    movie.pubdates.addAll(dynamicList7.map((o) => o.toString()));

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
