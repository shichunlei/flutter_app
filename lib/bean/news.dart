/// cover : "https://img1.doubanio.com/view/movie_gallery_frame_hot_rec/normal/public/b4b3467a4a0df7c.jpg"
/// link : "https://www.douban.com/note/735952605/?from=gallery"
/// title : "秋日特惠！大师课八个课程4折起"
/// summary : "10月1日~10月15日活动期间，豆瓣影人PRO大师课八门课程4折起，购买课程限量赠送「大师课学习手账」一本！"

class MovieNews {
  String title;
  String cover;
  String summary;
  String link;

  MovieNews({this.title, this.cover, this.summary, this.link});

  static MovieNews fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MovieNews bannersBean = MovieNews();
    bannersBean.cover = map['cover'];
    bannersBean.link = map['link'];
    bannersBean.title = map['title'];
    bannersBean.summary = map['summary'];
    return bannersBean;
  }

  Map toJson() => {
        "cover": cover,
        "link": link,
        "title": title,
        "summary": summary,
      };
}

/// app_id : "20191119A09Y0G00"
/// article_type : 0
/// category : "sports"
/// category2_chn : "nba"
/// category2_id : "210"
/// category_chn : "体育"
/// category_id : "2"
/// comment_id : "4428424683"
/// comment_num : 0
/// ext : {"tonality_score":2,"news_score":4,"img_type":3,"video_count":0}
/// flag : 0
/// from : "cms_pool"
/// id : "20191119A09Y0G"
/// img : "https://inews.gtimg.com/newsapp_ls/0/10794758643_640330/0"
/// img_count : 5
/// img_special : 0
/// img_type : 3
/// intro : "北京时间11月19日，凯尔特人99-85击败太阳，以11胜2负的战绩追平湖人。绿军21岁新星杰森-塔图姆打出一场高效率的比赛，出战27分钟，16投8中，三分9投3中，罚球9罚7中，得到26分11篮板……"
/// is_org : 0
/// keywords : "詹姆斯;凯尔特人;杰森·塔图姆;湖人"
/// keywords_new : ""
/// media_icon : "https://inews.gtimg.com/newsapp_ls/0/1453976129_200200/0"
/// multi_imgs : ["https://inews.gtimg.com/newsapp_bt/0/10794734117/641","https://inews.gtimg.com/newsapp_bt/0/10794734118/641","https://inews.gtimg.com/newsapp_bt/0/10794734119/641"]
/// news_level : 4
/// publish_time : "2019-11-19 12:57:58"
/// report : ""
/// showtype : "article"
/// source : "罗说NBA"
/// source_id : "5108759"
/// strategy : 1
/// surl : "http://kuaibao.qq.com/s/20191119A09Y0G00"
/// tag_cluster : ""
/// tag_label : [["詹姆斯","81603"],["凯尔特人","83283"],["杰森·塔图姆","3903092"]]
/// tags : "詹姆斯;凯尔特人;杰森·塔图姆;湖人"
/// terms : "81603:0.335918,83283:0.269823,3903092:0.229397,82224:0.164861"
/// title : "正负值＋154，力压詹皇排第一！新星轰26＋11绿军追平湖人"
/// title_simhash : 0
/// ts : 1574139478
/// update_time : "2019-11-19 12:59:35"
/// url : "https://xw.qq.com/cmsid/20191119A09Y0G00"
/// view_count : 0
/// vurl : "https://new.qq.com/omn/20191119/20191119A09Y0G00.html"

class NBANews {
  String appId;
  int articleType;
  String category;
  String category2Chn;
  String category2Id;
  String categoryChn;
  String categoryId;
  String commentId;
  int commentNum;
  ExtBean ext;
  int flag;
  String from;
  String id;
  String img;
  int imgCount;
  int imgSpecial;
  int imgType;
  String intro;
  int isOrg;
  String keywords;
  String keywordsNew;
  String mediaIcon;
  List<String> multiImages;
  int newsLevel;
  String publishTime;
  String report;
  String showType;
  String source;
  String sourceId;
  int strategy;
  String sUrl;
  String tagCluster;
  List<List<String>> tagLabel;
  String tags;
  String terms;
  String title;
  int titleSimHash;
  int ts;
  String updateTime;
  String url;
  int viewCount;
  String vUrl;

  static NBANews fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NBANews bean = NBANews();
    bean.appId = map['app_id'];
    bean.articleType = map['article_type'];
    bean.category = map['category'];
    bean.category2Chn = map['category2_chn'];
    bean.category2Id = map['category2_id'];
    bean.categoryChn = map['category_chn'];
    bean.categoryId = map['category_id'];
    bean.commentId = map['comment_id'];
    bean.commentNum = map['comment_num'];
    bean.ext = ExtBean.fromMap(map['ext']);
    bean.flag = map['flag'];
    bean.from = map['from'];
    bean.id = map['id'];
    bean.img = map['img'];
    bean.imgCount = map['img_count'];
    bean.imgSpecial = map['img_special'];
    bean.imgType = map['img_type'];
    bean.intro = map['intro'];
    bean.isOrg = map['is_org'];
    bean.keywords = map['keywords'];
    bean.keywordsNew = map['keywords_new'];
    bean.mediaIcon = map['media_icon'];
    bean.multiImages = List()
      ..addAll((map['multi_imgs'] as List ?? []).map((o) => o.toString()));
    bean.newsLevel = map['news_level'];
    bean.publishTime = map['publish_time'];
    bean.report = map['report'];
    bean.showType = map['showtype'];
    bean.source = map['source'];
    bean.sourceId = map['source_id'];
    bean.strategy = map['strategy'];
    bean.sUrl = map['surl'];
    bean.tagCluster = map['tag_cluster'];
    bean.tagLabel = List()
      ..addAll((map['tag_label'] as List ?? []).map(
          (o) => List()..addAll((o as List ?? []).map((oo) => oo.toString()))));
    bean.tags = map['tags'];
    bean.terms = map['terms'];
    bean.title = map['title'];
    bean.titleSimHash = map['title_simhash'];
    bean.ts = map['ts'];
    bean.updateTime = map['update_time'];
    bean.url = map['url'];
    bean.viewCount = map['view_count'];
    bean.vUrl = map['vurl'];
    return bean;
  }

  Map toJson() => {
        "app_id": appId,
        "article_type": articleType,
        "category": category,
        "category2_chn": category2Chn,
        "category2_id": category2Id,
        "category_chn": categoryChn,
        "category_id": categoryId,
        "comment_id": commentId,
        "comment_num": commentNum,
        "ext": ext,
        "flag": flag,
        "from": from,
        "id": id,
        "img": img,
        "img_count": imgCount,
        "img_special": imgSpecial,
        "img_type": imgType,
        "intro": intro,
        "is_org": isOrg,
        "keywords": keywords,
        "keywords_new": keywordsNew,
        "media_icon": mediaIcon,
        "multi_imgs": multiImages,
        "news_level": newsLevel,
        "publish_time": publishTime,
        "report": report,
        "showtype": showType,
        "source": source,
        "source_id": sourceId,
        "strategy": strategy,
        "surl": sUrl,
        "tag_cluster": tagCluster,
        "tag_label": tagLabel,
        "tags": tags,
        "terms": terms,
        "title": title,
        "title_simhash": titleSimHash,
        "ts": ts,
        "update_time": updateTime,
        "url": url,
        "view_count": viewCount,
        "vurl": vUrl,
      };
}

/// tonality_score : 2
/// news_score : 4
/// img_type : 3
/// video_count : 0

class ExtBean {
  int tonalityScore;
  int newsScore;
  int imgType;
  int videoCount;

  static ExtBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ExtBean bean = ExtBean();
    bean.tonalityScore = map['tonality_score'];
    bean.newsScore = map['news_score'];
    bean.imgType = map['img_type'];
    bean.videoCount = map['video_count'];
    return bean;
  }

  Map toJson() => {
        "tonality_score": tonalityScore,
        "news_score": newsScore,
        "img_type": imgType,
        "video_count": videoCount,
      };
}
