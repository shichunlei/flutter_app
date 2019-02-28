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
  ImagesBean images;
  RatingBean rating;
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
  List<BloopersListBean> bloopers;
  List<CastsListBean> casts;
  List<ClipsListBean> clips;
  List<DirectorsListBean> directors;
  List<PhotosListBean> photos;
  List<PopularCommentsListBean> popular_comments;
  List<PopularReviewsListBean> popular_reviews;
  List<TrailersListBean> trailers;
  List<VideosListBean> videos;
  List<WritersListBean> writers;

  static Movie fromMap(Map<String, dynamic> map) {
    Movie movie = new Movie();
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
    movie.images =
        map['images'] == null ? null : ImagesBean.fromMap(map['images']);
    movie.rating =
        map['rating'] == null ? null : RatingBean.fromMap(map['rating']);
    movie.bloopers = map['bloopers'] == null
        ? []
        : BloopersListBean.fromMapList(map['bloopers']);
    movie.casts =
        map['casts'] == null ? [] : CastsListBean.fromMapList(map['casts']);
    movie.clips =
        map['clips'] == null ? [] : ClipsListBean.fromMapList(map['clips']);
    movie.directors = map['directors'] == null
        ? []
        : DirectorsListBean.fromMapList(map['directors']);
    movie.photos =
        map['photos'] == null ? [] : PhotosListBean.fromMapList(map['photos']);
    movie.popular_comments = map['popular_comments'] == null
        ? []
        : PopularCommentsListBean.fromMapList(map['popular_comments']);
    movie.popular_reviews = map['popular_reviews'] == null
        ? []
        : PopularReviewsListBean.fromMapList(map['popular_reviews']);
    movie.trailers = map['trailers'] == null
        ? []
        : TrailersListBean.fromMapList(map['trailers']);
    movie.videos =
        map['videos'] == null ? [] : VideosListBean.fromMapList(map['videos']);
    movie.writers = map['writers'] == null
        ? []
        : WritersListBean.fromMapList(map['writers']);

    List<dynamic> dynamicList = map['aka'] == null ? [] : map['aka'];
    movie.aka = List();
    movie.aka.addAll(dynamicList.map((o) => o.toString()));

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

class ImagesBean {
  String small;
  String large;
  String medium;

  static ImagesBean fromMap(Map<String, dynamic> map) {
    ImagesBean imagesBean = ImagesBean();
    imagesBean.small = map['small'];
    imagesBean.large = map['large'];
    imagesBean.medium = map['medium'];
    return imagesBean;
  }

  static List<ImagesBean> fromMapList(dynamic mapList) {
    List<ImagesBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class RatingBean {
  int max;
  num value;
  int min;
  num average;

  static RatingBean fromMap(Map<String, dynamic> map) {
    RatingBean ratingBean = new RatingBean();
    ratingBean.max = map['max'];
    ratingBean.value = map['value'];
    ratingBean.min = map['min'];
    ratingBean.average = map['average'];
    return ratingBean;
  }

  static List<RatingBean> fromMapList(dynamic mapList) {
    List<RatingBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class BloopersListBean {
  String medium;
  String title;
  String subject_id;
  String alt;
  String small;
  String resource_url;
  String id;

  static BloopersListBean fromMap(Map<String, dynamic> map) {
    BloopersListBean bloopersListBean = new BloopersListBean();
    bloopersListBean.medium = map['medium'];
    bloopersListBean.title = map['title'];
    bloopersListBean.subject_id = map['subject_id'];
    bloopersListBean.alt = map['alt'];
    bloopersListBean.small = map['small'];
    bloopersListBean.resource_url = map['resource_url'];
    bloopersListBean.id = map['id'];
    return bloopersListBean;
  }

  static List<BloopersListBean> fromMapList(dynamic mapList) {
    List<BloopersListBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class CastsListBean {
  String name_en;
  String name;
  String alt;
  String id;
  AvatarsBean avatars;

  static CastsListBean fromMap(Map<String, dynamic> map) {
    CastsListBean castsListBean = new CastsListBean();
    castsListBean.name_en = map['name_en'];
    castsListBean.name = map['name'];
    castsListBean.alt = map['alt'];
    castsListBean.id = map['id'];
    castsListBean.avatars = AvatarsBean.fromMap(map['avatars']);
    return castsListBean;
  }

  static List<CastsListBean> fromMapList(dynamic mapList) {
    List<CastsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ClipsListBean {
  String medium;
  String title;
  String subject_id;
  String alt;
  String small;
  String resource_url;
  String id;

  static ClipsListBean fromMap(Map<String, dynamic> map) {
    ClipsListBean clipsListBean = new ClipsListBean();
    clipsListBean.medium = map['medium'];
    clipsListBean.title = map['title'];
    clipsListBean.subject_id = map['subject_id'];
    clipsListBean.alt = map['alt'];
    clipsListBean.small = map['small'];
    clipsListBean.resource_url = map['resource_url'];
    clipsListBean.id = map['id'];
    return clipsListBean;
  }

  static List<ClipsListBean> fromMapList(dynamic mapList) {
    List<ClipsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class DirectorsListBean {
  String name_en;
  String name;
  String alt;
  String id;
  AvatarsBean avatars;

  static DirectorsListBean fromMap(Map<String, dynamic> map) {
    DirectorsListBean directorsListBean = new DirectorsListBean();
    directorsListBean.name_en = map['name_en'];
    directorsListBean.name = map['name'];
    directorsListBean.alt = map['alt'];
    directorsListBean.id = map['id'];
    directorsListBean.avatars = AvatarsBean.fromMap(map['avatars']);
    return directorsListBean;
  }

  static List<DirectorsListBean> fromMapList(dynamic mapList) {
    List<DirectorsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class PhotosListBean {
  String thumb;
  String image;
  String cover;
  String alt;
  String id;
  String icon;

  static PhotosListBean fromMap(Map<String, dynamic> map) {
    PhotosListBean photosListBean = new PhotosListBean();
    photosListBean.thumb = map['thumb'];
    photosListBean.image = map['image'];
    photosListBean.cover = map['cover'];
    photosListBean.alt = map['alt'];
    photosListBean.id = map['id'];
    photosListBean.icon = map['icon'];
    return photosListBean;
  }

  static List<PhotosListBean> fromMapList(dynamic mapList) {
    List<PhotosListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class PopularCommentsListBean {
  String subject_id;
  String content;
  String created_at;
  String id;
  int useful_count;
  AuthorBean author;
  RatingBean rating;

  static PopularCommentsListBean fromMap(Map<String, dynamic> map) {
    PopularCommentsListBean popular_comments = PopularCommentsListBean();
    popular_comments.subject_id = map['subject_id'];
    popular_comments.content = map['content'];
    popular_comments.created_at = map['created_at'];
    popular_comments.id = map['id'];
    popular_comments.useful_count = map['useful_count'];
    popular_comments.author = AuthorBean.fromMap(map['author']);
    popular_comments.rating = RatingBean.fromMap(map['rating']);
    return popular_comments;
  }

  static List<PopularCommentsListBean> fromMapList(dynamic mapList) {
    List<PopularCommentsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class PopularReviewsListBean {
  String title;
  String subject_id;
  String summary;
  String alt;
  String id;
  AuthorBean author;
  RatingBean rating;

  static PopularReviewsListBean fromMap(Map<String, dynamic> map) {
    PopularReviewsListBean popular_reviewsListBean =
        new PopularReviewsListBean();
    popular_reviewsListBean.title = map['title'];
    popular_reviewsListBean.subject_id = map['subject_id'];
    popular_reviewsListBean.summary = map['summary'];
    popular_reviewsListBean.alt = map['alt'];
    popular_reviewsListBean.id = map['id'];
    popular_reviewsListBean.author = AuthorBean.fromMap(map['author']);
    popular_reviewsListBean.rating = RatingBean.fromMap(map['rating']);
    return popular_reviewsListBean;
  }

  static List<PopularReviewsListBean> fromMapList(dynamic mapList) {
    List<PopularReviewsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class TrailersListBean {
  String medium;
  String title;
  String subject_id;
  String alt;
  String small;
  String resource_url;
  String id;

  static TrailersListBean fromMap(Map<String, dynamic> map) {
    TrailersListBean trailersListBean = new TrailersListBean();
    trailersListBean.medium = map['medium'];
    trailersListBean.title = map['title'];
    trailersListBean.subject_id = map['subject_id'];
    trailersListBean.alt = map['alt'];
    trailersListBean.small = map['small'];
    trailersListBean.resource_url = map['resource_url'];
    trailersListBean.id = map['id'];
    return trailersListBean;
  }

  static List<TrailersListBean> fromMapList(dynamic mapList) {
    List<TrailersListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class VideosListBean {
  String sample_link;
  String video_id;
  bool need_pay;
  SourceBean source;

  static VideosListBean fromMap(Map<String, dynamic> map) {
    VideosListBean videosListBean = new VideosListBean();
    videosListBean.sample_link = map['sample_link'];
    videosListBean.video_id = map['video_id'];
    videosListBean.need_pay = map['need_pay'];
    videosListBean.source = SourceBean.fromMap(map['source']);
    return videosListBean;
  }

  static List<VideosListBean> fromMapList(dynamic mapList) {
    List<VideosListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class WritersListBean {
  String name_en;
  String name;
  String alt;
  String id;
  AvatarsBean avatars;

  static WritersListBean fromMap(Map<String, dynamic> map) {
    WritersListBean writersListBean = new WritersListBean();
    writersListBean.name_en = map['name_en'];
    writersListBean.name = map['name'];
    writersListBean.alt = map['alt'];
    writersListBean.id = map['id'];
    writersListBean.avatars = AvatarsBean.fromMap(map['avatars']);
    return writersListBean;
  }

  static List<WritersListBean> fromMapList(dynamic mapList) {
    List<WritersListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class AvatarsBean {
  String small;
  String large;
  String medium;

  static AvatarsBean fromMap(Map<String, dynamic> map) {
    AvatarsBean avatarsBean = AvatarsBean();
    avatarsBean.small = map != null ? map['small'] : "";
    avatarsBean.large = map != null ? map['large'] : "";
    avatarsBean.medium = map != null ? map['medium'] : "";
    return avatarsBean;
  }

  static List<AvatarsBean> fromMapList(dynamic mapList) {
    List<AvatarsBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{small: $small, large: $large, medium: $medium}';
  }
}

class AuthorBean {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  static AuthorBean fromMap(Map<String, dynamic> map) {
    AuthorBean authorBean = new AuthorBean();
    authorBean.uid = map['uid'];
    authorBean.avatar = map['avatar'];
    authorBean.signature = map['signature'];
    authorBean.alt = map['alt'];
    authorBean.id = map['id'];
    authorBean.name = map['name'];
    return authorBean;
  }

  static List<AuthorBean> fromMapList(dynamic mapList) {
    List<AuthorBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class DetailsBean {
  var star1;
  var star2;
  var star3;
  var star4;
  var star5;

  static DetailsBean fromMap(Map<String, dynamic> map) {
    DetailsBean detailsBean = DetailsBean();
    detailsBean.star1 = map['1'];
    detailsBean.star2 = map['2'];
    detailsBean.star3 = map['3'];
    detailsBean.star4 = map['4'];
    detailsBean.star5 = map['5'];
    return detailsBean;
  }

  static List<DetailsBean> fromMapList(dynamic mapList) {
    List<DetailsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class SourceBean {
  String literal;
  String pic;
  String name;

  static SourceBean fromMap(Map<String, dynamic> map) {
    SourceBean sourceBean = new SourceBean();
    sourceBean.literal = map['literal'];
    sourceBean.pic = map['pic'];
    sourceBean.name = map['name'];
    return sourceBean;
  }

  static List<SourceBean> fromMapList(dynamic mapList) {
    List<SourceBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
