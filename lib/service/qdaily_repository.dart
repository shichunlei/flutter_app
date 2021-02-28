import 'dart:convert';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import '../page_index.dart';

class QDailyRepository {
  /// 获取全部新闻(首页)
  static Future<ResponseBean> getQDailyHomeData(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_HOME_DATA, data: {"last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取某分类下的新闻
  static Future<ResponseBean> getQDailyNewsDataByCategory(
      int tagId, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_CATEGORY_DATA,
        data: {"last_key": lastKey, "tag_id": tagId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻评论
  static Future<ResponseBean> getQDailyCommentData(int id,
      {String dataType = 'article', String lastKey = '0'}) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_COMMENT_DATA,
        data: {"last_key": lastKey, "datatype": dataType, "id": id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目列表
  static Future<ResponseBean> getQDailyColumnList(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_COLUMN_LIST, data: {"last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目信息
  static Future<ResponseBean> getQDailyColumnInfo(int columnId) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_COLUMN_INFO, data: {'column_id': columnId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 栏目新闻
  static Future<ResponseBean> getQDailyColumnIndex(
      int columnId, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_COLUMN_NEWS,
        data: {'last_key': lastKey, 'column_id': columnId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 好奇心研究所
  static Future<ResponseBean> getQDailyLabsData(String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_LABS_URL, data: {'last_key': lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 好奇心研究所详情
  static Future<ResponseBean> getQDailyLabsDetailData(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_LAB_DETAIL, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 我说
  static Future<ResponseBean> getQDailyISay(int id, String lastKey) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_ISAY_URL, data: {'id': id, "last_key": lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 投票详情
  static Future<ResponseBean> getQDailyVote(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_VOTE_URL, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 投票结果
  static Future<ResponseBean> getQDailyVoteResult(int id) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_VOTE_RESULT, data: {'paper_id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 42%详情
  static Future<ResponseBean> getQDailyTots(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_TOTS_URL, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 你谁啊
  static Future<ResponseBean> getQDailyWho(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_WHO_URL, data: {'id': id});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 你猜
  static Future<ResponseBean> getQDailyChoices(int id) async {
    Response response =
        await HttpUtils().request(ApiUrl.QDAILY_CHOICE_URL, data: {'id': id});

    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻详情
  static Future<ResponseBean> getQDailyArticleInfoData(int articleId) async {
    Response response = await HttpUtils()
        .request(ApiUrl.QDAILY_ARTICLE_DETAIL, data: {'id': articleId});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// Topics新闻/文章
  static Future<ResponseBean> getQDailyTopicNews(int id, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_TOPIC_NEWS_URL,
        data: {'topic_id': id, 'last_key': lastKey});
    if (response == null || response?.statusCode != 200) {
      return null;
    }
    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 搜索
  static Future<ResponseBean> getQDailySearchData(
      String keywords, String lastKey) async {
    Response response = await HttpUtils().request(ApiUrl.QDAILY_SEARCH_WEB,
        data: {"last_key": lastKey, "keyword": keywords});
    if (response == null || response?.statusCode != 200) {
      return null;
    }

    BaseResult result = BaseResult.fromMap(json.decode(response.data));

    if (result.code == '0') {
      return ResponseBean.fromMap(result.data);
    } else {
      return null;
    }
  }

  /// 获取文章/新闻详情
  static Future<DetailBean> getQDailyArticleData(int articleId) async {
    DetailBean articleDetail;

    String detailsHtml = '';
    bool longPage = false;
    List<String> tags = [];
    String image = '';

    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_ARTICLE_URL)
        .request(":articleId", data: {'articleId': articleId});

    var document = parse(response.data.toString());

    dom.Element pageContent =
        document.getElementsByClassName('page-content').first;

    List<dom.Element> detailLongDiv =
        pageContent.getElementsByClassName('com-article-detail long');
    List<dom.Element> detailShortDiv =
        pageContent.getElementsByClassName('com-article-detail short');

    dom.Element detailDiv =
        detailLongDiv.length > 0 ? detailLongDiv.first : detailShortDiv.first;

    dom.Element detailBodyDiv =
        detailDiv.getElementsByClassName('article-detail-bd').first;
    dom.Element detailHeaderDiv =
        detailDiv.getElementsByClassName('article-detail-hd').first;
    dom.Element detailFooterDiv =
        detailDiv.getElementsByClassName('article-detail-ft').first;

    if (detailLongDiv.length > 0) {
      longPage = true;
    }

    if (detailShortDiv.length > 0) {
      longPage = false;
    }

    image = detailHeaderDiv
        .getElementsByClassName('banner')
        .first
        .querySelector('img')
        .attributes['data-src'];

    detailsHtml =
        detailBodyDiv.getElementsByClassName('detail').first.outerHtml;

    ////////////////////////////////////////////////////////////////

    List<dom.Element> tagsLi = detailFooterDiv
        .getElementsByClassName('tags items clearfix')
        .first
        .querySelectorAll('li');

    tagsLi.forEach((item) {
      tags.add(item.querySelector('span').text);
    });

    ////////////////////////////////////////////////////////////////
    List<PostBean> posts = [];

    List<dom.Element> banners = pageContent
        .getElementsByClassName('related-banners-bd')
        .first
        .querySelectorAll('a');

    banners.forEach((item) {
      int articleId = int.parse(item.attributes['href']
          .replaceAll('/mobile/articles/', '')
          .replaceAll('.html', ''));

      dom.Element bannerHd =
          item.getElementsByClassName('grid-key-article-hd').first;

      String image = bannerHd
          .getElementsByClassName('imgcover pic')
          .first
          .querySelector('img')
          .attributes['data-src'];

      print('-=-=-=-================----------$image');

      dom.Element bannerBd =
          item.getElementsByClassName('grid-key-article-bd').first;

      String title = bannerBd.getElementsByClassName('title').first.text;

      String category =
          bannerBd.querySelector('p').querySelectorAll('span')[1].text;

      dom.Element ribbonDiv = bannerBd.getElementsByClassName('ribbon').first;

      List<dom.Element> messageSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-message');
      List<dom.Element> heartSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-heart');

      int commentCount =
          messageSpans.length > 0 ? int.parse(messageSpans.first.text) : 0;

      int praiseCount =
          heartSpans.length > 0 ? int.parse(heartSpans.first.text) : 0;

      PostBean post = PostBean(
          image: image,
          id: articleId,
          title: title,
          categoryTile: category,
          commentCount: commentCount,
          praiseCount: praiseCount);

      posts..add(post);
    });

    articleDetail = DetailBean(
        description: detailsHtml,
        image: image,
        tags: tags,
        isFullPage: longPage,
        posts: posts);

    print(articleDetail.toString());

    return articleDetail;
  }

  /// 获取图书详情
  static Future<BookBean> getQDailyBookData(int articleId) async {
    BookBean bookDetail;

    String desc = '';
    List<String> tags = [];
    String detail = '';

    Response response = await HttpUtils(baseUrl: ApiUrl.QDAILY_ARTICLE_URL)
        .request(":articleId", data: {'articleId': articleId});

    var document = parse(response.data.toString());

    dom.Element pageContent =
        document.getElementsByClassName('page-content').first;

    dom.Element detailBodyDiv =
        pageContent.getElementsByClassName('article-detail-bd').first;
    dom.Element detailHeaderDiv =
        pageContent.getElementsByClassName('article-detail-hd').first;
    dom.Element detailFooterDiv =
        pageContent.getElementsByClassName('article-detail-ft').first;

    desc = detailHeaderDiv.getElementsByClassName('info').first.outerHtml;

    detail = detailBodyDiv.getElementsByClassName('detail').first.outerHtml;

    ////////////////////////////////////////////////////////////////

    List<dom.Element> tagsLi = detailFooterDiv
        .getElementsByClassName('tags items clearfix')
        .first
        .querySelectorAll('li');

    tagsLi.forEach((item) {
      tags.add(item.querySelector('span').text);
    });

    ////////////////////////////////////////////////////////////////
    List<PostBean> posts = [];

    List<dom.Element> banners = pageContent
        .getElementsByClassName('related-banners-bd')
        .first
        .querySelectorAll('a');

    banners.forEach((item) {
      int articleId = int.parse(item.attributes['href']
          .replaceAll('/mobile/articles/', '')
          .replaceAll('.html', ''));

      dom.Element bannerHd =
          item.getElementsByClassName('grid-key-article-hd').first;

      String image = bannerHd
          .getElementsByClassName('imgcover pic')
          .first
          .querySelector('img')
          .attributes['data-src'];

      print('-=-=-=-================----------$image');

      dom.Element bannerBd =
          item.getElementsByClassName('grid-key-article-bd').first;

      String title = bannerBd.getElementsByClassName('title').first.text;

      String category =
          bannerBd.querySelector('p').querySelectorAll('span')[1].text;

      dom.Element ribbonDiv = bannerBd.getElementsByClassName('ribbon').first;

      List<dom.Element> messageSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-message');
      List<dom.Element> heartSpans =
          ribbonDiv.getElementsByClassName('iconfont icon-heart');

      int commentCount =
          messageSpans.length > 0 ? int.parse(messageSpans.first.text) : 0;

      int praiseCount =
          heartSpans.length > 0 ? int.parse(heartSpans.first.text) : 0;

      PostBean post = PostBean(
          image: image,
          id: articleId,
          title: title,
          categoryTile: category,
          commentCount: commentCount,
          praiseCount: praiseCount);

      posts..add(post);
    });

    bookDetail = BookBean(desc: desc, tags: tags, posts: posts, detail: detail);

    print(bookDetail.toString());

    return bookDetail;
  }
}
