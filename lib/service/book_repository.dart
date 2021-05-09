import 'dart:convert';

import '../page_index.dart';

class BookRepository {
  /// 根据分类得到小说列表
  /// [gender] 性别 男生:mael 女生:female 出版:press
  /// [major] 大类别
  /// [minor] 小类别
  /// [type] 热门:hot 新书:new 好评:repulation 完结:over 包月: month
  /// [start] 分页位置，从0开始
  /// [limit] 分页条数
  ///
  static Future<List<Books>> getBookByCategories(String gender, String major,
      {int start: 0,
      int limit: 20,
      String minor: '',
      String type: 'hot'}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOKS_BY_CATEGORY_URL, data: {
      "gender": gender,
      "major": major,
      'type': type,
      "start": start,
      "limit": limit,
      "minor": minor
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 小说详情
  static Future<Books> getBookDetails(String id) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_DETAILS_URL, data: {"id": id});
    if (response?.statusCode != 200) {
      return null;
    }

    Books book = Books.fromJson(json.decode(response.data));
    return book;
  }

  /// 相关推荐
  static Future<List<Books>> getBookByRecommend(String id) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RECOMMEND_URL, data: {"id": id});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 小说书评列表
  static Future<BookResult> getBookReview(String id,
      {String sort: 'updated', int start: 0, int limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_REVIEW_URL,
        data: {"book": id, "sort": sort, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 小说短评列表
  static Future<List<DocsBean>> getBookShortReview(String id,
      {String sort: 'updated', int start: 0, int limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_SHORT_REVIEW_URL,
        data: {"book": id, "sort": sort, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.docs;
    } else {
      return [];
    }
  }

  /// 小说讨论列表
  static Future<List<Post>> getBookTalks(String id,
      {String sort: 'updated',
      int start: 1,
      int limit: 20,
      String type: 'normal'}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_TALK_URL, data: {
      "book": id,
      "sort": sort,
      "start": start,
      "limit": limit,
      "type": type
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.posts;
    } else {
      return [];
    }
  }

  /// 获取小说正版源
  static Future<BtocResult> getBookBtocSource(String bookId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_BTOC_URL,
        data: {"book": bookId, 'view': 'summary'});
    if (response?.statusCode != 200) {
      return null;
    }

    List<BtocResult> result = []
      ..addAll((json.decode(response.data) as List ?? [])
          .map((o) => BtocResult.fromMap(o)));

    if (result.length > 0) {
      return result.first;
    } else {
      return null;
    }
  }

  /// 小说章节目录
  static Future<List<Chapters>> getBookChapters(String sourceId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_ATOC_URL,
        data: {"sourceId": sourceId, 'view': 'chapters'});
    if (response?.statusCode != 200) {
      return [];
    }

    ChapterResult result = ChapterResult.fromMap(json.decode(response.data));
    if (result.chapters.length > 0) {
      return result.chapters;
    } else {
      return [];
    }
  }

  /// 小说章节详情
  static Future<ChapterInfo> getBookChapterInfo(String link) async {
    Response response = await HttpUtils().request(link, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.chapter;
    } else {
      return null;
    }
  }

  /// 获取所有排行榜
  static Future<RankingResult> getBookRankings() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RANKING_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    RankingResult result = RankingResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 获取单一排行榜
  static Future<Ranking> getRankingBooks(String rankingId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_RANKING_INFO_URL, data: {"rankingId": rankingId});
    if (response?.statusCode != 200) {
      return null;
    }

    RankingResult result = RankingResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.ranking;
    } else {
      return null;
    }
  }

  /// 获取分类
  static Future<StatisticsResult> getBookStatistics() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_STATISTICS_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    StatisticsResult result =
        StatisticsResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 获取二级分类
  static Future<CategoryResult> getBookCategory() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_CATEGORY_URL, data: null);
    if (response?.statusCode != 200) {
      return null;
    }

    CategoryResult result = CategoryResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result;
    } else {
      return null;
    }
  }

  /// 关键字搜索返回小说列表
  /// [query] 搜索关键字
  /// [start] 开始位置（从1开始）
  /// [limit] 每页条数
  ///
  static Future<List<Books>> getSearchBook(String query,
      {int start: 1, limit: 20}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL).request(
        ApiUrl.BOOK_SEARCH_URL,
        data: {"query": query, "start": start, "limit": limit});
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.books;
    } else {
      return [];
    }
  }

  /// 搜索热词列表
  ///
  static Future<List<String>> getSearchHotWords() async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_HOT_WORDS_URL, data: null);
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.hotWords;
    } else {
      return [];
    }
  }

  /// 书单列表
  ///
  static Future<List<BookList>> getBookLists(String gender,
      {int start: 0,
      int limit: 20,
      String duration: 'all',
      String sort: 'collectorCount',
      String tag: ''}) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_LIST_URL, data: {
      "gender": gender,
      "duration": duration,
      "sort": sort,
      "tag": tag,
      "start": start,
      "limit": limit
    });
    if (response?.statusCode != 200) {
      return [];
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.bookLists;
    } else {
      return [];
    }
  }

  /// 书单详情
  ///
  static Future<BookList> getBookListInfo(String booklistId) async {
    Response response = await HttpUtils(baseUrl: ApiUrl.BOOK_URL)
        .request(ApiUrl.BOOK_LIST_INFO_URL, data: {"booklistId": booklistId});
    if (response?.statusCode != 200) {
      return null;
    }

    BookResult result = BookResult.fromMap(json.decode(response.data));
    if (result.ok) {
      return result.bookList;
    } else {
      return null;
    }
  }
}
