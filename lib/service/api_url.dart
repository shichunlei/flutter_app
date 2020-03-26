class ApiUrl {
  static const String BASE_URL = 'http://data.chingsoft.com/api/v1/';

  static const String LOGIN = 'users/login';

  static const String UPDATE_AVATAR = 'users/update_avatar';

  static const String MOVIE_BASE_URL = "https://api.douban.com/v2/movie";

  static final String MOVIE_HOME_URL = "movies/home_data";

  static final String MOVIE_LIST_URL = "movies/in_theaters";
  static final String MOVIE_DETAIL_URL = 'movies/details';
  static final String MOVIE_TOP250_URL = "movies/top250";
  static final String MOVIE_SEARCH_BY_TAG_URL = "movies/search_by_tag";
  static final String MOVIE_FILTER_URL = "movies/screening";
  static final String MOVIE_RANGE_URL = "movies/ranges";
  static final String MOVIE_SOON_URL = "movies/coming_soon";
  static final String NEW_MOVIES_URL = "movies/new_movies";
  static final String WEEKLY_MOVIES_URL = "movies/weekly";
  static final String US_MOVIES_URL = "movies/us_box";

  static final String MOVIE_PHOTOS_URL = 'movies/photos';

  static final String MOVIE_CELEBRITY_URL = "movies/celebrity";
  static final String MOVIE_CELEBRITY_WORKS_URL = "movies/works";

  static final String MOVIE_COMMENTS_URL = 'movies/comments';
  static final String MOVIE_REVIEWS_URL = 'movies/reviews';

  static final String TUBITV_HOME = 'tubitv/homescreen';
  static final String TUBITV_LIST = 'tubitv/list';
  static final String TUBITV_DETAIL = 'tubitv/details';
  static final String TUBITV_SEARCH = 'tubitv/search';

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

  static final String JUZIMI_LIST_URL = 'juzimi/list';
  static final String JUZIMI_TAG_LIST_URL = 'juzimi/tag_list';
  static final String JUZIMI_DETAILS_URL = 'juzimi/details';

  /// 每日一文
  static final String ARTICLE_TODAY_URL = "juzimi/article_today";
  static final String ARTICLE_DAY_URL = "juzimi/article_day";
  static final String ARTICLE_RANDOM_URL = "juzimi/article_random";

  static final String MEIZITU_URL = 'https://m.image.so.com/';

  static final String QDAILY_HOME_DATA = "qdaily/home_data";

  static final String QDAILY_CATEGORY_DATA = "qdaily/news_by_category";

  static final String QDAILY_COMMENT_DATA = "qdaily/comments";

  static final String QDAILY_ARTICLE_URL =
      "http://m.qdaily.com/mobile/articles/";
  static final String QDAILY_ARTICLE_DETAIL = "qdaily/articles_details";

  static final String QDAILY_LABS_URL = "qdaily/papers";
  static final String QDAILY_TOPIC_NEWS_URL = "qdaily/paper_topics";
  static final String QDAILY_LAB_DETAIL = "qdaily/paper_info";

  static final String QDAILY_VOTE_URL = "qdaily/vote_info";
  static final String QDAILY_VOTE_RESULT = "qdaily/vote_result";

  static final String QDAILY_TOTS_URL = "qdaily/tots";

  static final String QDAILY_ISAY_URL = "qdaily/i_say";

  static final String QDAILY_WHO_URL = "qdaily/whos";

  static final String QDAILY_CHOICE_URL = "qdaily/choices";

  static final String QDAILY_COLUMN_LIST = "qdaily/columns";
  static final String QDAILY_COLUMN_INFO = "qdaily/column_info";
  static final String QDAILY_COLUMN_NEWS = "qdaily/column_news";

  static final String QDAILY_SEARCH_HIGHLIGHTING = "qdaily/search_highlighting";
  static final String QDAILY_SEARCH = "qdaily/search";
  static final String QDAILY_SEARCH_WEB = "qdaily/search_web";

  static final String QDAILY_CATEGORYS = "qdaily/categories";

  /// 有道精品课
  static final String YOUDAO_BASE_URL = "https://ke.youdao.com/";

  static final String YOUDAO_HOME_URL = "course3/api/webhome";

  static final String YOUDAO_HOME_LIST_URL =
      "course3/api/webhome/recommendCourse";

  static final String YOUDAO_GROUP_DETAILS_URL = 'course3/api/vertical2';

  static final String YOUDAO_GROUP_ALL_COURSE_URL =
      "course3/api/content/course";

  /// 追书神器
  static final String BOOK_URL = 'http://api.zhuishushenqi.com';

  /// 首页小说列表
  static final String BOOKS_BY_CATEGORY_URL = '/book/by-categories';

  /// 获取小说详情
  static final String BOOK_DETAILS_URL = '/book/:id';

  /// 获取小说相关推荐
  static final String BOOK_RECOMMEND_URL = '/book/:id/recommend';

  /// 获取小说正版源
  static final String BOOK_BTOC_URL = '/btoc';

  /// 获取小说章节
  static final String BOOK_ATOC_URL = '/atoc/:sourceId';

  /// 关键字模糊搜索返回小说列表
  static final String BOOK_SEARCH_URL = '/book/fuzzy-search';

  /// 搜索热词
  static final String BOOK_HOT_WORDS_URL = '/book/hot-word';

  /// 带书籍数量的父分类
  static final String BOOK_STATISTICS_URL = '/cats/lv2/statistics';

  /// 获取二级分类
  static final String BOOK_CATEGORY_URL = '/cats/lv2';

  /// 书评列表
  static final String BOOK_REVIEW_URL = '/post/review/by-book';

  /// 短评列表
  static final String BOOK_SHORT_REVIEW_URL = '/post/short-review';

  /// 讨论列表
  static final String BOOK_TALK_URL = '/post/by-book';

  /// 获取小说所有排行榜
  static final String BOOK_RANKING_URL = '/ranking/gender';

  /// 获取某具体排行榜
  static final String BOOK_RANKING_INFO_URL = '/ranking/:rankingId';

  /// 获取书单列表
  static final String BOOK_LIST_URL = '/book-list';

  /// 获取书单详情
  static final String BOOK_LIST_INFO_URL = '/book-list/:booklistId';

  /// 获取书单标签
  static final String BOOK_LIST_TAGS_URL = '/book-list/tagType';

  /// 一言
  static final String HITOKOTO_URL = 'https://v1.hitokoto.cn/';

  /// NBA赛程
  static final NBA_SCHEDULE = 'sports/nba_schedule';

  /// NBA球队赛程
  static final TEAM_SCHEDULE = 'sports/team_schedule';

  /// NBA球队阵容
  static final TEAM_ROSTER = 'sports/team_roster';

  /// NBA球队排名
  static final TEAM_RANK = 'sports/team_rank';

  /// NBA球队数据排名（前五）
  static final TEAM_RANNGE = 'sports/team_range';

  /// NBA球队数据排名（全）
  static final TEAM_RANNGE_ALL = 'sports/team_range_all';

  /// NBA球员数据排名（前五）
  static final PLAYER_RANNGE = 'sports/player_range';

  /// NBA球员数据排名（全）
  static final PLAYER_RANNGE_ALL = 'sports/player_range_all';

  /// NBA球员详情
  static final PLAYER_DETAIL = 'sports/player_details';

  /// NBA球员详情
  static final PLAYER_INFO = 'sports/player_info';

  /// NBA球员生涯数据
  static final PLAYER_CAREER = 'sports/player_career';

  /// NBA球员单赛季比赛数据
  static final PLAYER_MATCH = 'sports/player_match';

  /// 球队数据概况
  static final TEAM_STATS = 'sports/team_stats';

  /// NBA球队详情
  static final TEAM_INFO = 'sports/team_info';

  /// NBA比赛本场概况（技术统计）
  static final MATCH_STATS = 'sports/match_stats';

  /// NBA最新动态
  static final NBA_NEWS = 'sports/nba_news';

  /// 抗击疫情
  static final NCOV_INDEX = "cnov/statistics";

  /// 谣言鉴别
  static final NCOV_RUMOUR = "cnov/rumour";

  /// 肺炎同程查询
  static final NCOV_SAME = "cnov/ncovsame";

  /// 获取全国最新的新闻数据
  static final NCOV_NEWS = "cnov/news";

  /// 地区数据
  static final NCOV_PROVINCE = "cnov/province";

  /// 地区新闻
  static final NCOV_PROVINCE_NEWS = "cnov/provincenews";

  /// 新冠肺炎确诊病患活动轨迹
  static final NCOV_TRAJECTORY = "cnov/trajectory";

  /// 疫情分析
  static final NCOV_ANALYZE = "cnov/analyze";

  /// 预防手册
  static final NCOV_PREVENT_MANUAL = "cnov/prevent_manual";

  /// 我的音乐
  static final MUSIC = "musics/list";

  /// 抖音视频榜
  static final DY_VIDEOS = "astros/dyvideohot";
}
