class ApiUrl {
  /// 豆瓣电影
  static const String DOUBAN_WEB_URL = 'https://movie.douban.com/';

  static const String MOVIE_BASE_URL = "https://api.douban.com/v2/movie";

  static final String MOVIE_LIST_URL = "/in_theaters";
  static final String MOVIE_DETAIL_URL = '/subject/:movieId';
  static final String MOVIE_PHOTO_URL = '/subject/:movieId/photos';
  static final String MOVIE_TOP250_URL = "/top250";
  static final String MOVIE_SEARCH_URL = "/search";
  static final String MOVIE_SOON_URL = "/coming_soon";
  static final String NEW_MOVIES_URL = "/new_movies";
  static final String WEEKLY_MOVIES_URL = "/weekly";
  static final String US_MOVIES_URL = "/us_box";

  static final String MOVIE_PHOTOS_URL = '/:url/:id/photos';

  static final String MOVIE_CELEBRITY_URL = "/celebrity/:actorId";
  static final String MOVIE_CELEBRITY_PHOTOS_URL = "/celebrity/:actorId/photos";
  static final String MOVIE_CELEBRITY_WORKS_URL = "/celebrity/:actorId/works";

  static final String MOVIE_COMMENTS_URL = '/subject/:movieId/comments';
  static final String MOVIE_REVIEWS_URL = '/subject/:movieId/reviews';

  /// 每日一文
  static final String ARTICLE_BASE_URL = "https://interface.meiriyiwen.com";

  static final String ARTICLE_TODAY_URL = "/article/today";
  static final String ARTICLE_DAY_URL = "/article/day";
  static final String ARTICLE_RANDOM_URL = "/article/random";

  /// 和风天气
  static final String WEATHER_BASE_URL = "https://free-api.heweather.net/s6";

  static final String WEATHER = "/weather";
  static final String WEATHER_NOW = "/weather/now";
  static final String WEATHER_HOURLY = "/weather/hourly";
  static final String WEATHER_FORECAST = "/weather/forecast";

  static final String AIR = "/air";
  static final String AIR_NOW = "/air/now";

  static final String LIFESTYLE = "/weather/lifestyle";

  static final String SUNRISE_SUNSET = "/solar/sunrise-sunset";

  static final String CITY_BASE_URL = 'https://search.heweather.net';

  static final String CITY_FIND = "/find";
  static final String CITY_TOP = "/top";

  /// 煎蛋
  static final String JIANDAN = "http://i.jandan.net";

  /// 百姓生活
  static final String BAIXING_BASE_URL =
      'http://v.jspang.com:8088/baixing/wxmini/';

  static final String BAIXING_HOME = 'homePageContent';
  static final String BAIXING_HOME_HOT = 'homePageBelowConten';
  static final String BAIXING_CATEGORY = 'getCategory';
  static final String BAIXING_GOODS = 'getMallGoods';
  static final String BAIXING_GOODS_DETAIL = 'getGoodDetailById';

  static final String RANDOMUSER_URL = 'https://randomuser.me/api/';

  static final String JUZIMI_URL = 'https://www.juzimi.com/';

  static final String MEIZITU_URL = 'https://m.image.so.com/';

  /// 好奇心日报APP接口
  static final String QDAILY_APP_URL = "http://app3.qdaily.com/";

  /// 好奇心日报Web接口
  static final String QDAILY_WEB_URL = "http://www.qdaily.com/";

  static final String QDAILY_HOME_DATA = "app3/homes/index_v2/";

  static final String QDAILY_CATEGORY_DATA = "app3/categories/index/";

  static final String QDAILY_COMMENT_DATA = "app3/comments/index/";

  static final String QDAILY_ARTICLE_URL =
      "http://m.qdaily.com/mobile/articles/";
  static final String QDAILY_ARTICLE_INFO_URL =
      "app3/articles/info/:articleId.json";

  static final String QDAILY_LAB_INDEX_DATA = "app3/papers/index/:lastKey.json";
  static final String QDAILY_LAB_DETAIL_DATA = "app3/papers/detail/:labId.json";

  static final String QDAILY_COLUMN_LIST_DATA = "special_columns/column_more/";
  static final String QDAILY_COLUMN_INFO_DATA =
      "app3/columns/info/:columnId.json";
  static final String QDAILY_COLUMN_INDEX_DATA =
      "app3/columns/index/:columnId/:lastKey.json";

  static final String QDAILY_SEARCH_HIGHLIGHTING_DATA =
      "app3/searches/post_highlighting_list.json?last_key={last_key}&search={content}";
  static final String QDAILY_SEARCH_DATA = "app3/searches/post_list.json";
  static final String QDAILY_SEARCH_WEB_DATA = "searches/more_search.json";

  static final String QDAILY_CATEGORYS_DATA = "app3/homes/left_sidebar.json";

  /// 有道精品课
  static final String YOUDAO_BASE_URL = "https://ke.youdao.com/";

  static final String YOUDAO_HOME_URL = "course3/api/webhome";

  static final String YOUDAO_HOME_LIST_URL =
      "course3/api/webhome/recommendCourse";

  static final String YOUDAO_GROUP_DETAILS_URL = 'course3/api/vertical2';

  static final String YOUDAO_GROUP_ALL_COURSE_URL =
      "course3/api/content/course";
}
