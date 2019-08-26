import 'package:flutter_app/utils/date_format.dart';

/// image : "http://img.qdaily.com/article/article_show/20190523001508leXuFoOV5hpGsAaC.png?imageMogr2/auto-orient/thumbnail/!640x380r/gravity/Center/crop/640x380/quality/85/format/jpg/ignore-error/1"
/// type : 2
/// datatype : "article"
/// post : {"id":63954,"genre":1,"title":"好看的包装设计到处都有，这家英国设计公司更擅长“好卖”的","description":"做设计 26 年，Pearlfisher 的创始人谈了谈如何从当下最时髦的生活方式中汲取灵感，帮助客户完成变革，寻找新的商业机会。","publish_time":1558585148,"image":"http://img.qdaily.com/article/article_show/20190523001508leXuFoOV5hpGsAaC.png?imageMogr2/auto-orient/thumbnail/!640x380r/gravity/Center/crop/640x380/quality/85/format/jpg/ignore-error/1","start_time":0,"comment_count":3,"comment_status":true,"praise_count":89,"super_tag":"长文章","page_style":1,"post_id":66907,"appview":"http://app3.qdaily.com/app3/articles/63954.html","film_length":"","datatype":"article","category":{"id":17,"title":"设计","normal":"http://img.qdaily.com/category/icon_black/20160606004538bpyX8Nm7dL4ns5WQ.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1","normal_hl":"http://img.qdaily.com/category/icon_yellow_app/201606060045382gYtJkaTwmRrLq9B.png?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/ignore-error/1","image_lab":"http://img.qdaily.com/category/icon_yellow_app/201606060045382gYtJkaTwmRrLq9B.png?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/ignore-error/1","image_experiment":""}}

class FeedsBean {
  String image;
  int type;
  PostBean post;
  String dataType;
  List<NewList> newsList;
  int indexType;

  static FeedsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FeedsBean feedsBean = FeedsBean();
    feedsBean.image = map['image'];
    feedsBean.indexType = map['index_type'];
    feedsBean.type = map['type'];
    feedsBean.dataType = map['datatype'];
    feedsBean.post = map['post'] == null ? null : PostBean.fromMap(map['post']);
    feedsBean.newsList = List()
      ..addAll((map['news_list'] as List ?? []).map((o) => NewList.fromMap(o)));
    return feedsBean;
  }
}

/// description : "财政部调整车辆购置税计算方法，以实际价格征税"

class NewList {
  String description;

  static NewList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NewList newListBean = NewList();
    newListBean.description = map['description'];
    return newListBean;
  }
}

/// title : "央行又要降准刺激经济了，上一次刺激的效果怎么样？"
/// description : "鼓励小企业贷款的政策运行了三个季度，但企业借贷意愿还没有完全恢复，经济增长仍靠地产和制造业。"
/// publish_time : "2019-05-22 16:49:01 +0800"
/// duration : null
/// id : 63961
/// genre : 1
/// comment_count : 30
/// praise_count : 112
/// author : {"id":392200,"name":null,"avatar":"http://img.qdaily.com/user/face/20190128000025sMDOJ7c5gmklZ60y.JPG?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"乐观的悲观主义者。","background_image":"http://www.qdaily.com/images/author_background.jpg"}
/// category : {"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}
/// image : "http://img.qdaily.com/article/banner/20190522235741qLck1OXCJp9Y3ZNB.jpg?imageMogr2/auto-orient/thumbnail/!640x380r/gravity/Center/crop/640x380/quality/85/format/jpg/ignore-error/1"
/// start_time : 0
/// comment_status : true
/// super_tag : "长文章"
/// page_style : 1
/// post_id : 66928
/// appview : "http://app3.qdaily.com/app3/articles/63974.html"
/// film_length : ""
/// datatype : "article"
/// column : {"id":57,"name":"访谈录","description":"我们总是乐于分享一些值得仔细看的见解。","subscribe_status":true,"icon":"http://img.qdaily.com/special_column/icon/20171128180555lLovwtPzXViIkm5r.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/format/jpg/ignore-error/1","image":"http://img.qdaily.com/special_column/column/20171128180555De7azE4xlXn9Wd0i.png?imageMogr2/auto-orient/thumbnail/!320x320r/gravity/Center/crop/320x320/quality/85/format/jpg/ignore-error/1","image_large":"http://img.qdaily.com/special_column/column/20171128180555De7azE4xlXn9Wd0i.png?imageMogr2/auto-orient/thumbnail/!750x604r/gravity/Center/crop/750x604/quality/85/format/jpg/ignore-error/1","content_provider":"好奇心日报","show_type":1,"genre":1,"subscriber_num":27637,"post_count":68,"sort_time":"2019-04-23 07:18:57 +0800","column_tag":"special_columns_57","location":null,"share":{"url":"http://m.qdaily.com/mobile/special_columns/57.html","title":"访谈录_好奇心日报","text":"我们总是乐于分享一些值得仔细看的见解。","image":"http://img.qdaily.com/special_column/column/20171128180555De7azE4xlXn9Wd0i.png?imageMogr2/auto-orient/thumbnail/!320x320r/gravity/Center/crop/320x320/quality/85/format/jpg/ignore-error/1"}}

class PostBean {
  String title;
  String description;
  String publishTime;
  String startTime;
  String superTag;
  dynamic duration;
  int id;
  int genre;
  int commentCount;
  int praiseCount;
  int recordCount;
  AuthorBean author;
  CategoryBean category;
  String categoryTile;
  String image;

  bool commentStatus;
  int pageStyle;
  int postId;
  String appView;
  String filmLength;
  String dataType;
  ColumnBean column;

  PostBean(
      {this.title,
      this.description,
      this.publishTime,
      this.startTime,
      this.superTag,
      this.duration,
      this.id,
      this.genre,
      this.commentCount,
      this.praiseCount,
      this.recordCount,
      this.categoryTile,
      this.image,
      this.commentStatus,
      this.pageStyle,
      this.postId,
      this.appView,
      this.filmLength,
      this.dataType});

  static PostBean fromMap(Map<String, dynamic> map) {
    PostBean postBean = new PostBean();
    postBean.title = map['title'];
    postBean.image = map['image'];
    postBean.description = map['description'];
    postBean.publishTime = (map['publish_time'] is int)
        ? formatDateByMs(map['publish_time'] * 1000,
            formats: [mm, '月', dd, '日'])
        : formatDateByStr(map['publish_time'], formats: [mm, '月', dd, '日']);
    postBean.startTime = "${map['start_time']}";
    postBean.superTag = map['super_tag'];
    postBean.duration = map['duration'];
    postBean.id = map['id'];
    postBean.genre = map['genre'];
    postBean.commentCount = map['comment_count'];
    postBean.recordCount = map['record_count'];
    postBean.praiseCount = map['praise_count'];
    postBean.author =
        map['author'] == null ? null : AuthorBean.fromMap(map['author']);
    postBean.category =
        map['category'] == null ? null : CategoryBean.fromMap(map['category']);

    postBean.commentStatus = map['comment_status'];
    postBean.pageStyle = map['page_style'];
    postBean.postId = map['post_id'];
    postBean.appView = map['appview'];
    postBean.filmLength = map['film_length'];
    postBean.dataType = map['datatype'];
    postBean.column =
        map['column'] == null ? null : ColumnBean.fromMap(map['column']);

    return postBean;
  }
}

class CategoryBean {
  /// title : "商业"
  /// css_name : "shangye"
  /// normal : "http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1"
  /// image_lab : ""
  /// image_experiment : ""
  /// id : 18
  /// normal_hl : "http://img.qdaily.com/category/icon_yellow_app/20160606004533uFozK3xI4CHZjfSM.png?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/ignore-error/1"

  String title;
  String cssName;
  String normal;
  String imageLab;
  String imageExperiment;
  int id;
  String normalHl;

  String type;

  CategoryBean(
      {this.title,
      this.cssName,
      this.normal,
      this.imageLab,
      this.imageExperiment,
      this.id,
      this.type});

  static CategoryBean fromMap(Map<String, dynamic> map) {
    CategoryBean categoryBean = new CategoryBean();
    categoryBean.title = map['title'];
    categoryBean.cssName = map['css_name'];
    categoryBean.normal = map['normal'];
    categoryBean.imageLab = map['image_lab'];
    categoryBean.imageExperiment = map['image_experiment'];
    categoryBean.id = map['id'];
    categoryBean.normalHl = map['normalHl'];
    return categoryBean;
  }

  static List<CategoryBean> getCategory() {
    List<CategoryBean> list = [];

    list
      ..add(CategoryBean(
          id: 1,
          title: "长文章",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130162204XNnUWGkuvaS0O3ph.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 22,
          title: "10 个图",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130161854abmIjqc3wnS6RT4M.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 16,
          title: "Top 15",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130162312AqpnIgEti4yw2NKW.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 18,
          title: "商业",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/201611301617415V9kat3SgEJw670A.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 4,
          title: "智能",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130162237bsDvMVEOLl6tRSXf.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 17,
          title: "设计",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130161810Byfkx7ISFmCKWiTX.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 19,
          title: "时尚",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130161931CVT4P1Zf2HLB5dRn.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 3,
          title: "娱乐",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/201611301634116hw7KvSqPjMn5Nar.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 5,
          title: "文化",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130161329kR6O4Tu8ZrPfYehM.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 54,
          title: "游戏",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130162005uRUpXY2K4COG85AE.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'))
      ..add(CategoryBean(
          id: 63,
          title: "大公司头条",
          imageLab:
              'http://img.qdaily.com/category/icon_white_app/20161130161709IA8hvnl0q3TMbkus.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/ignore-error/1'));

    return list;
  }
}

/// id : 38
/// name : "这个设计了不起"
/// description : "总能找到好看的东西"
/// subscribe_status : true
/// icon : "http://img.qdaily.com/special_column/icon/20160703183440nKed1jf6mG9VcJZL.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/quality/85/format/jpg/ignore-error/1"
/// image : "http://img.qdaily.com/special_column/column/20160703183440in6zCrSyDRGvwWPp.jpg?imageMogr2/auto-orient/thumbnail/!320x320r/gravity/Center/crop/320x320/quality/85/format/jpg/ignore-error/1"
/// image_large : "http://img.qdaily.com/special_column/column/20160703183440in6zCrSyDRGvwWPp.jpg?imageMogr2/auto-orient/thumbnail/!750x604r/gravity/Center/crop/750x604/quality/85/format/jpg/ignore-error/1"
/// content_provider : "好奇心日报"
/// show_type : 1
/// genre : 1
/// subscriber_num : 238366
/// post_count : 1125
/// sort_time : "2019-05-23 06:58:33 +0800"
/// column_tag : "special_columns_38"
/// location : 8
/// share : {"url":"http://m.qdaily.com/mobile/special_columns/38.html","title":"这个设计了不起_好奇心日报","text":"总能找到好看的东西","image":"http://img.qdaily.com/special_column/column/20160703183440in6zCrSyDRGvwWPp.jpg?imageMogr2/auto-orient/thumbnail/!320x320r/gravity/Center/crop/320x320/quality/85/format/jpg/ignore-error/1"}

class ColumnBean {
  int id;
  String name;
  String description;
  bool subscribeStatus;
  String icon;
  String image;
  String imageLarge;
  String contentProvider;
  int showType; // 1图片等;2 图书等
  int genre;
  int subscriberNum;
  int postCount;
  String sortTime;
  String columnTag;
  int location;
  ShareBean share;

  static ColumnBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ColumnBean column = ColumnBean();
    column.id = map['id'];
    column.name = map['name'];
    column.description = map['description'];
    column.subscribeStatus = map['subscribe_status'];
    column.icon = map['icon'];
    column.image = map['image'];
    column.imageLarge = map['image_large'];
    column.contentProvider = map['content_provider'];
    column.showType = map['show_type'];
    column.genre = map['genre'];
    column.subscriberNum = map['subscriber_num'];
    column.postCount = map['post_count'];
    column.sortTime = map['sort_time'];
    column.columnTag = map['column_tag'];
    column.location = map['location'];
    column.share =
        map['share'] == null ? null : ShareBean.fromMap(map['share']);
    return column;
  }
}

/// avatar : "http://img.qdaily.com/user/face/20190128000025sMDOJ7c5gmklZ60y.JPG?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1"
/// description : "乐观的悲观主义者。"
/// background_image : "http://www.qdaily.com/images/author_background.jpg"
/// name : 张三
/// id : 392200

class AuthorBean {
  String avatar;
  String description;
  String backgroundImage;
  String name;
  int id;

  AuthorBean(
      {this.avatar,
      this.description,
      this.backgroundImage,
      this.name,
      this.id});

  static AuthorBean fromMap(Map<String, dynamic> map) {
    AuthorBean authorBean = new AuthorBean();
    authorBean.avatar = map['avatar'];
    authorBean.description = map['description'];
    authorBean.backgroundImage = map['background_image'];
    authorBean.name = map['name'];
    authorBean.id = map['id'];
    return authorBean;
  }
}

/// url : "http://m.qdaily.com/mobile/special_columns/38.html"
/// title : "这个设计了不起_好奇心日报"
/// text : "总能找到好看的东西"
/// image : "http://img.qdaily.com/special_column/column/20160703183440in6zCrSyDRGvwWPp.jpg?imageMogr2/auto-orient/thumbnail/!320x320r/gravity/Center/crop/320x320/quality/85/format/jpg/ignore-error/1"

class ShareBean {
  String url;
  String title;
  String text;
  String image;

  static ShareBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ShareBean shareBean = ShareBean();
    shareBean.url = map['url'];
    shareBean.title = map['title'];
    shareBean.text = map['text'];
    shareBean.image = map['image'];
    return shareBean;
  }
}

/// id : 982612
/// type : "paper"
/// type_id : 2962
/// content : "不忘初心。"
/// fake : false
/// publish_time : 1558947573
/// comment_count : 1
/// praise_count : 10
/// author : {"id":1656439,"description":null,"avatar":"http://img.qdaily.com/user/face/20190527170417TUzZxIdquXF3RVL2.jpg?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/format/jpg/ignore-error/1","name":"*FanG","background_image":"http://app3.qdaily.com/default_images/missing_loading.jpg"}
/// child_comments : [{"id":982753,"root_id":982612,"content":"恶毒的……","fake":false,"publish_time":1558960221,"comment_count":0,"praise_count":0,"parent_user":{"id":1656439,"description":null,"avatar":"http://img.qdaily.com/user/face/20190527170417TUzZxIdquXF3RVL2.jpg?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/format/jpg/ignore-error/1","name":"*FanG","background_image":"http://app3.qdaily.com/default_images/missing_loading.jpg"},"author":{"id":1301561,"description":null,"avatar":"http://img.qdaily.com/face/face/20170714144125FN5ASiJXxW2RqUMl.png?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/format/jpg/ignore-error/1","name":"疯狗先生","background_image":"http://app3.qdaily.com/default_images/missing_loading.jpg"}}]

class CommentBean {
  int id;
  String type;
  int typeId;
  String content;
  bool fake;
  int publishTime;
  int commentCount;
  int praiseCount;
  AuthorBean author;
  AuthorBean parentUser;
  List<CommentBean> childComments;
  int rootId;

  static CommentBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentBean commentBeanBean = CommentBean();
    commentBeanBean.id = map['id'];
    commentBeanBean.rootId = map['root_id'];
    commentBeanBean.type = map['type'];
    commentBeanBean.typeId = map['type_id'];
    commentBeanBean.content = map['content'];
    commentBeanBean.fake = map['fake'];
    commentBeanBean.publishTime = map['publish_time'];
    commentBeanBean.commentCount = map['comment_count'];
    commentBeanBean.praiseCount = map['praise_count'];
    commentBeanBean.author =
        map['author'] == null ? null : AuthorBean.fromMap(map['author']);
    commentBeanBean.parentUser = map['parent_user'] == null
        ? null
        : AuthorBean.fromMap(map['parent_user']);
    commentBeanBean.childComments = List()
      ..addAll((map['child_comments'] as List ?? [])
          .map((o) => CommentBean.fromMap(o)));
    return commentBeanBean;
  }
}

class DetailBean {
  String description;
  List<String> tags;
  String image;
  List<PostBean> posts;
  bool isFullPage;

  DetailBean(
      {this.description, this.tags, this.image, this.posts, this.isFullPage});

  @override
  String toString() {
    return 'DetailBean{description: $description, tags: $tags, image: $image,  posts: $posts, isFullPage: $isFullPage}';
  }
}

class BookBean {
  String desc;
  List<String> tags;
  List<PostBean> posts;
  String detail;

  BookBean({this.desc, this.tags, this.posts, this.detail});
}
