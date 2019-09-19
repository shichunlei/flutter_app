class Movie {
  /// 原名
  String originalTitle;

  /// 豆瓣小站
  String douBanSite;

  /// 年代
  String year;

  /// 条目页URL
  String alt;

  /// id
  String id;

  /// 移动版条目页URL
  String mobileUrl;

  /// 兼容性数据，未来会去掉，大陆上映日期，如果条目类型是电影则为上映日期，如果是电视剧则为首播日期
  String pubDate;

  /// 中文名
  String title;

  /// 分享链接
  String shareUrl;

  /// 影讯页URL(movie only)
  String scheduleUrl;

  /// 官方网站
  String website;

  /// 大陆上映日期，如果条目类型是电影则为上映日期，如果是电视剧则为首播日期
  String mainlandPubDate;

  /// 简介
  String summary;

  /// 条目分类, movie或者tv
  String subtype;

  ///
  bool hasVideo;

  /// 是否预定
  bool hasSchedule;

  /// 是否有票
  bool hasTicket;

  /// 排行
  int rank;

  /// 排名改变量
  int delta;

  /// 影片
  Movie subject;

  /// 票房
  num box;

  /// 是否新上映
  bool isNew;

  /// 在看人数，如果是电视剧，默认值为0，如果是电影值为null
  int doCount;

  /// 总季数(tv only)
  int seasonsCount;

  /// 收藏
  dynamic collection;

  /// 当前季的集数(tv only)
  String episodesCount;

  /// 当前季数(tv only)
  String currentSeason;

  /// 影评数量
  int reviewsCount;

  /// 想看人数
  int wishCount;

  /// 看过人数
  int collectCount;

  /// 剧照数量
  int photosCount;

  /// 短评数量
  int commentsCount;

  /// 评分人数
  int ratingsCount;

  /// 电影海报图，分别提供288px x 465px(大)，96px x 155px(中) 64px x 103px(小)尺寸
  Images images;

  /// 评分
  Rating rating;

  /// 又名
  List<String> aka;

  /// 制片国家/地区
  List<String> countries;

  /// 片长
  List<String> durations;

  /// 影片类型，最多提供3个
  List<String> genres;

  /// 语言
  List<String> languages;

  /// 如果条目类型是电影则为上映日期，如果是电视剧则为首Ï日期
  List<String> pubDates;

  /// 标签
  List<String> tags;

  /// 预告片
  List<Clips> trailers;

  /// 预告片URL，对高级用户以上开放，最多开放4个地址
  List<String> trailerUrls;

  /// 花絮，对高级用户以上开放
  List<Clips> bloopers;

  /// 花絮URL，对高级用户以上开放，最多开放4个地址
  List<String> blooperUrls;

  /// 片段，对高级用户以上开放
  List<Clips> clips;

  /// 片段URL，对高级用户以上开放，最多开放4个地址
  List<String> clipUrls;

  /// 电影剧照，前10张
  List<Photos> photos;

  /// 热评
  List<Reviews> popularComments;

  /// 影评，前10条
  List<Reviews> popularReviews;

  List<Videos> videos;

  /// 导演
  List<Casts> directors;

  /// 主演，最多可获得4个
  List<Casts> casts;

  /// 编剧
  List<Casts> writers;

  static Movie fromMap(Map<String, dynamic> map) {
    Movie movie = Movie();
    movie.originalTitle = map['original_title'];
    movie.douBanSite = map['douban_site'];
    movie.year = map['year'];
    movie.alt = map['alt'];
    movie.id = map['id'];
    movie.mobileUrl = map['mobile_url'];
    movie.pubDate = map['pubdate'];
    movie.title = map['title'];
    movie.shareUrl = map['share_url'];
    movie.scheduleUrl = map['schedule_url'];
    movie.website = map['website'];
    movie.mainlandPubDate = map['mainland_pubdate'];
    movie.summary = map['summary'];
    movie.subtype = map['subtype'];
    movie.hasVideo = map['has_video'];
    movie.hasSchedule = map['has_schedule'];
    movie.hasTicket = map['has_ticket'];
    movie.doCount = map['do_count'] == null ? 0 : map['do_count'];
    movie.seasonsCount =
        map['seasons_count'] == null ? 0 : map['seasons_count'];
    movie.collection = map['collection'];
    movie.episodesCount =
        map['episodes_count'] == null ? '0' : map['episodes_count'];
    movie.currentSeason =
        map['current_season'] == null ? '0' : map['current_season'];
    movie.reviewsCount = map['reviews_count'];
    movie.wishCount = map['wish_count'];
    movie.collectCount = map['collect_count'];
    movie.photosCount = map['photos_count'];
    movie.commentsCount = map['comments_count'];
    movie.ratingsCount = map['ratings_count'];

    movie.isNew = map['new'];
    movie.box = map['box'];
    movie.rank = map['rank'];
    movie.delta = map['delta'];
    movie.subject =
        map['subject'] == null ? null : Movie.fromMap(map['subject']);

    movie.images = map['images'] == null ? null : Images.fromMap(map['images']);
    movie.rating = map['rating'] == null ? null : Rating.fromMap(map['rating']);
    movie.bloopers =
        map['bloopers'] == null ? [] : Clips.fromMapList(map['bloopers']);
    movie.casts = map['casts'] == null ? [] : Casts.fromMapList(map['casts']);
    movie.clips = map['clips'] == null ? [] : Clips.fromMapList(map['clips']);
    movie.directors =
        map['directors'] == null ? [] : Casts.fromMapList(map['directors']);
    movie.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    movie.popularComments = map['popular_comments'] == null
        ? []
        : Reviews.fromMapList(map['popular_comments']);
    movie.popularReviews = map['popular_reviews'] == null
        ? []
        : Reviews.fromMapList(map['popular_reviews']);
    movie.trailers =
        map['trailers'] == null ? [] : Clips.fromMapList(map['trailers']);
    movie.videos =
        map['videos'] == null ? [] : Videos.fromMapList(map['videos']);
    movie.writers =
        map['writers'] == null ? [] : Casts.fromMapList(map['writers']);

    List<dynamic> aka = map['aka'] == null ? [] : map['aka'];
    movie.aka = List();
    movie.aka.addAll(aka.map((o) => o.toString()));

    List<dynamic> blooper_urls =
        map['blooper_urls'] == null ? [] : map['blooper_urls'];
    movie.blooperUrls = List();
    movie.blooperUrls.addAll(blooper_urls.map((o) => o.toString()));

    List<dynamic> clip_urls = map['clip_urls'] == null ? [] : map['clip_urls'];
    movie.clipUrls = List();
    movie.clipUrls.addAll(clip_urls.map((o) => o.toString()));

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
    movie.pubDates = List();
    movie.pubDates.addAll(pubdates.map((o) => o.toString()));

    List<dynamic> tagList = map['tags'] == null ? [] : map['tags'];
    movie.tags = List();
    movie.tags.addAll(tagList.map((o) => o.toString()));

    List<dynamic> trailerUrlList =
        map['trailer_urls'] == null ? [] : map['trailer_urls'];
    movie.trailerUrls = List();
    movie.trailerUrls.addAll(trailerUrlList.map((o) => o.toString()));

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

class Celebrity {
  String website;
  String mobileUrl;
  String name;
  String nameEn;
  String gender;
  String summary;
  String birthday;
  String alt;
  String bornPlace;
  String constellation;
  String id;
  Avatars avatars;
  List<String> aka;
  List<String> akaEn;
  List<String> professions;
  List<Photos> photos;
  List<Works> works;

  static Celebrity fromMap(Map<String, dynamic> map) {
    Celebrity celebrity = Celebrity();
    celebrity.website = map['website'];
    celebrity.mobileUrl = map['mobile_url'];
    celebrity.name = map['name'];
    celebrity.nameEn = map['name_en'];
    celebrity.gender = map['gender'];
    celebrity.summary = map['summary'];
    celebrity.birthday = map['birthday'];
    celebrity.alt = map['alt'];
    celebrity.bornPlace = map['born_place'];
    celebrity.constellation = map['constellation'];
    celebrity.id = map['id'];
    celebrity.avatars =
        map['avatars'] == null ? null : Avatars.fromMap(map['avatars']);
    celebrity.photos =
        map['photos'] == null ? [] : Photos.fromMapList(map['photos']);
    celebrity.works =
        map['works'] == null ? [] : Works.fromMapList(map['works']);

    List<dynamic> aka = map['aka'] == null ? [] : map['aka'];
    celebrity.aka = List();
    celebrity.aka.addAll(aka.map((o) => o.toString()));

    List<dynamic> aka_en = map['aka_en'] == null ? [] : map['aka_en'];
    celebrity.akaEn = List();
    celebrity.akaEn.addAll(aka_en.map((o) => o.toString()));

    List<dynamic> professions =
        map['professions'] == null ? [] : map['professions'];
    celebrity.professions = List();
    celebrity.professions.addAll(professions.map((o) => o.toString()));

    return celebrity;
  }

  static List<Celebrity> fromMapList(dynamic mapList) {
    List<Celebrity> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{website: $website, mobile_url: $mobileUrl, name: $name, name_en: $nameEn, gender: $gender, summary: $summary, birthday: $birthday, alt: $alt, born_place: $bornPlace, constellation: $constellation, id: $id, avatars: $avatars, aka: $aka, aka_en: $akaEn, professions: $professions, photos: $photos, works: $works}';
  }
}

class Casts {
  String nameEn;
  String name;
  String alt;
  String id;
  Avatars avatars;

  static Casts fromMap(Map<String, dynamic> map) {
    Casts castsListBean = Casts();
    castsListBean.nameEn = map['name_en'];
    castsListBean.name = map['name'];
    castsListBean.alt = map['alt'];
    castsListBean.id = map['id'];
    castsListBean.avatars = Avatars.fromMap(map['avatars']);
    return castsListBean;
  }

  static List<Casts> fromMapList(dynamic mapList) {
    List<Casts> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{name_en: $nameEn, name: $name, alt: $alt, id: $id, avatars: $avatars}';
  }
}

class Photos {
  String thumb;
  String icon;
  String createdAt;
  String albumId;
  String cover;
  String id;
  String prevPhoto;
  String albumUrl;
  String image;
  String alt;
  String albumTitle;
  String nextPhoto;
  String subjectId;
  String desc;
  int photosCount;
  int commentsCount;
  int recsCount;
  int position;
  Author author;

  static Photos fromMap(Map<String, dynamic> map) {
    Photos photos = Photos();
    photos.thumb = map['thumb'];
    photos.icon = map['icon'];
    photos.createdAt = map['created_at'];
    photos.albumId = map['album_id'];
    photos.cover = map['cover'];
    photos.id = map['id'];
    photos.prevPhoto = map['prev_photo'];
    photos.albumUrl = map['album_url'];
    photos.image = map['image'];
    photos.alt = map['alt'];
    photos.albumTitle = map['album_title'];
    photos.nextPhoto = map['next_photo'];
    photos.subjectId = map['subject_id'];
    photos.desc = map['desc'];
    photos.photosCount = map['photos_count'];
    photos.commentsCount = map['comments_count'];
    photos.recsCount = map['recs_count'];
    photos.position = map['position'];
    photos.author =
        map['author'] == null ? null : Author.fromMap(map['author']);
    return photos;
  }

  static List<Photos> fromMapList(dynamic mapList) {
    List<Photos> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Photos{thumb: $thumb, icon: $icon, created_at: $createdAt, album_id: $albumId, cover: $cover, id: $id, prev_photo: $prevPhoto, album_url: $albumUrl, image: $image, alt: $alt, album_title: $albumTitle, next_photo: $nextPhoto, subject_id: $subjectId, desc: $desc, photos_count: $photosCount, comments_count: $commentsCount, recs_count: $recsCount, position: $position, author: $author}';
  }
}

class Reviews {
  String created_at;
  String title;
  String updated_at;
  String share_url;
  String summary;
  String content;
  String alt;
  String id;
  String subject_id;
  int useful_count;
  int useless_count;
  int comments_count;
  Author author;
  Rating rating;

  static Reviews fromMap(Map<String, dynamic> map) {
    Reviews reviews = new Reviews();
    reviews.created_at = map['created_at'];
    reviews.title = map['title'];
    reviews.updated_at = map['updated_at'];
    reviews.share_url = map['share_url'];
    reviews.summary = map['summary'];
    reviews.content = map['content'];
    reviews.alt = map['alt'];
    reviews.id = map['id'];
    reviews.subject_id = map['subject_id'];
    reviews.useful_count = map['useful_count'];
    reviews.useless_count = map['useless_count'];
    reviews.comments_count = map['comments_count'];
    reviews.author =
        map['author'] == null ? null : Author.fromMap(map['author']);
    reviews.rating =
        map['rating'] == null ? null : Rating.fromMap(map['rating']);
    return reviews;
  }

  static List<Reviews> fromMapList(dynamic mapList) {
    List<Reviews> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Author {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  static Author fromMap(Map<String, dynamic> map) {
    Author author = Author();
    author.uid = map['uid'];
    author.avatar = map['avatar'];
    author.signature = map['signature'];
    author.alt = map['alt'];
    author.id = map['id'];
    author.name = map['name'];
    return author;
  }

  static List<Author> fromMapList(dynamic mapList) {
    List<Author> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{uid: $uid, avatar: $avatar, signature: $signature, alt: $alt, id: $id, name: $name}';
  }
}

class Avatars {
  String small;
  String large;
  String medium;

  static Avatars fromMap(Map<String, dynamic> map) {
    Avatars avatarsBean = Avatars();
    avatarsBean.small = map != null ? map['small'] : "";
    avatarsBean.large = map != null ? map['large'] : "";
    avatarsBean.medium = map != null ? map['medium'] : "";
    return avatarsBean;
  }

  static List<Avatars> fromMapList(dynamic mapList) {
    List<Avatars> list = List(mapList.length);
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

class Videos {
  String sampleLink;
  String videoId;
  bool needPay;
  Source source;

  static Videos fromMap(Map<String, dynamic> map) {
    Videos videosListBean = Videos();
    videosListBean.sampleLink = map['sample_link'];
    videosListBean.videoId = map['video_id'];
    videosListBean.needPay = map['need_pay'];
    videosListBean.source = Source.fromMap(map['source']);
    return videosListBean;
  }

  static List<Videos> fromMapList(dynamic mapList) {
    List<Videos> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Source {
  String literal;
  String pic;
  String name;

  static Source fromMap(Map<String, dynamic> map) {
    Source sourceBean = Source();
    sourceBean.literal = map['literal'];
    sourceBean.pic = map['pic'];
    sourceBean.name = map['name'];
    return sourceBean;
  }

  static List<Source> fromMapList(dynamic mapList) {
    List<Source> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'SourceBean{literal: $literal, pic: $pic, name: $name}';
  }
}

class Works {
  Movie subject;
  List<String> roles;

  static Works fromMap(Map<String, dynamic> map) {
    Works works = Works();
    works.subject = Movie.fromMap(map['subject']);

    List<dynamic> roles = map['roles'] == null ? [] : map['roles'];
    works.roles = List();
    works.roles.addAll(roles.map((o) => o.toString()));

    return works;
  }

  static List<Works> fromMapList(dynamic mapList) {
    List<Works> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class Rating {
  int max;
  num value;
  int min;
  num average;
  String stars;
  Details details;

  static Rating fromMap(Map<String, dynamic> map) {
    Rating ratingBean = Rating();
    ratingBean.max = map['max'];
    ratingBean.value = map['value'] == null ? -1 : map['value'];
    ratingBean.min = map['min'];
    ratingBean.stars = map['stars'] == null ? "" : map['stars'];
    ratingBean.average = map['average'] == null ? 0 : map['average'];
    ratingBean.details =
        map['details'] == null ? null : Details.fromMap(map['details']);
    return ratingBean;
  }

  static List<Rating> fromMapList(dynamic mapList) {
    List<Rating> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Rating{max: $max, value: $value, min: $min, average: $average, stars: $stars, details: $details}';
  }
}

class Details {
  var star1;
  var star2;
  var star3;
  var star4;
  var star5;

  static Details fromMap(Map<String, dynamic> map) {
    Details detailsBean = Details();
    detailsBean.star1 = map['1'];
    detailsBean.star2 = map['2'];
    detailsBean.star3 = map['3'];
    detailsBean.star4 = map['4'];
    detailsBean.star5 = map['5'];
    return detailsBean;
  }

  static List<Details> fromMapList(dynamic mapList) {
    List<Details> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{star1: $star1, star2: $star2, star3: $star3, star4: $star4, star5: $star5}';
  }
}

class Clips {
  String medium;
  String title;
  String subjectId;
  String alt;
  String small;
  String resourceUrl;
  String id;

  static Clips fromMap(Map<String, dynamic> map) {
    Clips clipsListBean = Clips();
    clipsListBean.medium = map['medium'];
    clipsListBean.title = map['title'];
    clipsListBean.subjectId = map['subject_id'];
    clipsListBean.alt = map['alt'];
    clipsListBean.small = map['small'];
    clipsListBean.resourceUrl = map['resource_url'];
    clipsListBean.id = map['id'];
    return clipsListBean;
  }

  static List<Clips> fromMapList(dynamic mapList) {
    List<Clips> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Clips{medium: $medium, title: $title, subject_id: $subjectId, alt: $alt, small: $small, resource_url: $resourceUrl, id: $id}';
  }
}

class Images {
  String small;
  String large;
  String medium;

  static Images fromMap(Map<String, dynamic> map) {
    Images imagesBean = Images();
    imagesBean.small = map['small'];
    imagesBean.large = map['large'];
    imagesBean.medium = map['medium'];
    return imagesBean;
  }

  static List<Images> fromMapList(dynamic mapList) {
    List<Images> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
