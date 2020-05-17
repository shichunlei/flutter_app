class ApiUrl {
  static const String BASE_URL = 'http://data.chingsoft.com/api/v1/';

  static const String LOGIN = 'users/login';

  static const String UPDATE_AVATAR = 'users/update_avatar';

  static const String MOVIE_BASE_URL = "https://api.douban.com/v2/movie";

  static const String MOVIE_HOME_URL = "movies/home_data";

  static const String MOVIE_LIST_URL = "movies/in_theaters";
  static const String MOVIE_DETAIL_URL = 'movies/details';
  static const String MOVIE_TOP250_URL = "movies/top250";
  static const String MOVIE_SEARCH_BY_TAG_URL = "movies/search_by_tag";
  static const String MOVIE_FILTER_URL = "movies/screening";
  static const String MOVIE_RANGE_URL = "movies/ranges";
  static const String MOVIE_SOON_URL = "movies/coming_soon";
  static const String NEW_MOVIES_URL = "movies/new_movies";
  static const String WEEKLY_MOVIES_URL = "movies/weekly";
  static const String US_MOVIES_URL = "movies/us_box";

  static const String MOVIE_PHOTOS_URL = 'movies/photos';

  static const String MOVIE_CELEBRITY_URL = "movies/celebrity";
  static const String MOVIE_CELEBRITY_WORKS_URL = "movies/works";

  static const String MOVIE_COMMENTS_URL = 'movies/comments';
  static const String MOVIE_REVIEWS_URL = 'movies/reviews';

  static const String TUBITV_HOME = 'tubitv/homescreen';
  static const String TUBITV_LIST = 'tubitv/list';
  static const String TUBITV_DETAIL = 'tubitv/details';
  static const String TUBITV_SEARCH = 'tubitv/search';

  /// 和风天气
  static const String WEATHER_BASE_URL = "https://free-api.heweather.net/s6";

  static const String WEATHER = "/weather";
  static const String WEATHER_NOW = "/weather/now";
  static const String WEATHER_HOURLY = "/weather/hourly";
  static const String WEATHER_FORECAST = "/weather/forecast";

  static const String AIR = "/air";
  static const String AIR_NOW = "/air/now";

  static const String LIFESTYLE = "/weather/lifestyle";

  static const String SUNRISE_SUNSET = "/solar/sunrise-sunset";

  static const String CITY_BASE_URL = 'https://search.heweather.net';

  static const String CITY_FIND = "/find";
  static const String CITY_TOP = "/top";

  /// 百姓生活
  static const String BAIXING_BASE_URL =
      'https://wxmini.baixingliangfan.cn/baixing/wxmini/';

  static const String BAIXING_HOME = 'homePageContent';
  static const String BAIXING_HOME_HOT = 'homePageBelowConten';
  static const String BAIXING_CATEGORY = 'getCategory';
  static const String BAIXING_GOODS = 'getMallGoods';
  static const String BAIXING_GOODS_DETAIL = 'getGoodDetailById';
  static const String BAIXING_SHOPS = 'integralGoodsShops';
  static const String BAIXING_SHOP_DETAIL = 'integralGoods';
  static const String BAIXING_ORDERS = 'getMyOrders';
  static const String BAIXING_SEARCH = 'searchGoods';
  static const String BAIXING_HOME_AD = 'getHomePageTip';

  static const String RANDOMUSER_URL = 'https://randomuser.me/api/';

  static const String JUZIMI_LIST_URL = 'juzimi/list';
  static const String JUZIMI_TAG_LIST_URL = 'juzimi/tag_list';
  static const String JUZIMI_DETAILS_URL = 'juzimi/details';

  /// 每日一文
  static const String ARTICLE_TODAY_URL = "juzimi/article_today";
  static const String ARTICLE_DAY_URL = "juzimi/article_day";
  static const String ARTICLE_RANDOM_URL = "juzimi/article_random";

  static const String MEIZITU_URL = 'https://m.image.so.com/';

  static const String QDAILY_HOME_DATA = "qdaily/home_data";

  static const String QDAILY_CATEGORY_DATA = "qdaily/news_by_category";

  static const String QDAILY_COMMENT_DATA = "qdaily/comments";

  static const String QDAILY_ARTICLE_URL =
      "http://m.qdaily.com/mobile/articles/";
  static const String QDAILY_ARTICLE_DETAIL = "qdaily/articles_details";

  static const String QDAILY_LABS_URL = "qdaily/papers";
  static const String QDAILY_TOPIC_NEWS_URL = "qdaily/paper_topics";
  static const String QDAILY_LAB_DETAIL = "qdaily/paper_info";

  static const String QDAILY_VOTE_URL = "qdaily/vote_info";
  static const String QDAILY_VOTE_RESULT = "qdaily/vote_result";

  static const String QDAILY_TOTS_URL = "qdaily/tots";

  static const String QDAILY_ISAY_URL = "qdaily/i_say";

  static const String QDAILY_WHO_URL = "qdaily/whos";

  static const String QDAILY_CHOICE_URL = "qdaily/choices";

  static const String QDAILY_COLUMN_LIST = "qdaily/columns";
  static const String QDAILY_COLUMN_INFO = "qdaily/column_info";
  static const String QDAILY_COLUMN_NEWS = "qdaily/column_news";

  static const String QDAILY_SEARCH_HIGHLIGHTING = "qdaily/search_highlighting";
  static const String QDAILY_SEARCH = "qdaily/search";
  static const String QDAILY_SEARCH_WEB = "qdaily/search_web";

  static const String QDAILY_CATEGORYS = "qdaily/categories";

  /// 有道精品课
  static const String YOUDAO_BASE_URL = "https://ke.youdao.com/";

  static const String YOUDAO_HOME_URL = "course3/api/webhome";

  static const String YOUDAO_HOME_LIST_URL =
      "course3/api/webhome/recommendCourse";

  static const String YOUDAO_GROUP_DETAILS_URL = 'course3/api/vertical2';

  static const String YOUDAO_GROUP_ALL_COURSE_URL =
      "course3/api/content/course";

  /// 追书神器
  static const String BOOK_URL = 'http://api.zhuishushenqi.com';

  /// 首页小说列表
  static const String BOOKS_BY_CATEGORY_URL = '/book/by-categories';

  /// 获取小说详情
  static const String BOOK_DETAILS_URL = '/book/:id';

  /// 获取小说相关推荐
  static const String BOOK_RECOMMEND_URL = '/book/:id/recommend';

  /// 获取小说正版源
  static const String BOOK_BTOC_URL = '/btoc';

  /// 获取小说章节
  static const String BOOK_ATOC_URL = '/atoc/:sourceId';

  /// 关键字模糊搜索返回小说列表
  static const String BOOK_SEARCH_URL = '/book/fuzzy-search';

  /// 搜索热词
  static const String BOOK_HOT_WORDS_URL = '/book/hot-word';

  /// 带书籍数量的父分类
  static const String BOOK_STATISTICS_URL = '/cats/lv2/statistics';

  /// 获取二级分类
  static const String BOOK_CATEGORY_URL = '/cats/lv2';

  /// 书评列表
  static const String BOOK_REVIEW_URL = '/post/review/by-book';

  /// 短评列表
  static const String BOOK_SHORT_REVIEW_URL = '/post/short-review';

  /// 讨论列表
  static const String BOOK_TALK_URL = '/post/by-book';

  /// 获取小说所有排行榜
  static const String BOOK_RANKING_URL = '/ranking/gender';

  /// 获取某具体排行榜
  static const String BOOK_RANKING_INFO_URL = '/ranking/:rankingId';

  /// 获取书单列表
  static const String BOOK_LIST_URL = '/book-list';

  /// 获取书单详情
  static const String BOOK_LIST_INFO_URL = '/book-list/:booklistId';

  /// 获取书单标签
  static const String BOOK_LIST_TAGS_URL = '/book-list/tagType';

  /// 一言
  static const String HITOKOTO_URL = 'https://v1.hitokoto.cn/';

  /// NBA赛程
  static const NBA_SCHEDULE = 'sports/nba_schedule';

  /// NBA球队赛程
  static const TEAM_SCHEDULE = 'sports/team_schedule';

  /// NBA球队阵容
  static const TEAM_ROSTER = 'sports/team_roster';

  /// NBA球队排名
  static const TEAM_RANK = 'sports/team_rank';

  /// NBA球队数据排名（前五）
  static const TEAM_RANNGE = 'sports/team_range';

  /// NBA球队数据排名（全）
  static const TEAM_RANNGE_ALL = 'sports/team_range_all';

  /// NBA球员数据排名（前五）
  static const PLAYER_RANNGE = 'sports/player_range';

  /// NBA球员数据排名（全）
  static const PLAYER_RANNGE_ALL = 'sports/player_range_all';

  /// NBA球员详情
  static const PLAYER_DETAIL = 'sports/player_details';

  /// NBA球员详情
  static const PLAYER_INFO = 'sports/player_info';

  /// NBA球员生涯数据
  static const PLAYER_CAREER = 'sports/player_career';

  /// NBA球员单赛季比赛数据
  static const PLAYER_MATCH = 'sports/player_match';

  /// 球队数据概况
  static const TEAM_STATS = 'sports/team_stats';

  /// NBA球队详情
  static const TEAM_INFO = 'sports/team_info';

  /// NBA比赛本场概况（技术统计）
  static const MATCH_STATS = 'sports/match_stats';

  /// NBA最新动态
  static const NBA_NEWS = 'sports/nba_news';

  /// 抗击疫情
  static const NCOV_INDEX = "cnov/statistics";

  /// 谣言鉴别
  static const NCOV_RUMOUR = "cnov/rumour";

  /// 肺炎同程查询
  static const NCOV_SAME = "cnov/ncovsame";

  /// 获取全国最新的新闻数据
  static const NCOV_NEWS = "cnov/news";

  /// 地区数据
  static const NCOV_PROVINCE = "cnov/province";

  /// 地区新闻
  static const NCOV_PROVINCE_NEWS = "cnov/provincenews";

  /// 新冠肺炎确诊病患活动轨迹
  static const NCOV_TRAJECTORY = "cnov/trajectory";

  /// 疫情分析
  static const NCOV_ANALYZE = "cnov/analyze";

  /// 预防手册
  static const NCOV_PREVENT_MANUAL = "cnov/prevent_manual";

  /// 我的音乐
  static const MUSIC = "musics/list";

  /// 抖音视频榜
  static const DY_VIDEOS = "astros/dyvideohot";

  /// 携程搜索
  static const CTRIP_SEARCH =
      'https://m.ctrip.com/restapi/h5api/globalsearch/search';
}
