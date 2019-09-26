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

/// title : "商业"
/// css_name : "shangye"
/// normal : "http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1"
/// image_lab : ""
/// image_experiment : ""
/// id : 18
/// normal_hl : "http://img.qdaily.com/category/icon_yellow_app/20160606004533uFozK3xI4CHZjfSM.png?imageMogr2/auto-orient/thumbnail/!160x160r/gravity/Center/crop/160x160/quality/85/ignore-error/1"

class CategoryBean {
  String title;
  String cssName;
  String normal;
  String imageLab;
  String imageExperiment;
  int id;
  String normalHl;

  String whiteIcon;
  String blackIcon;

  CategoryBean(
      {this.title,
      this.cssName,
      this.normal,
      this.imageLab,
      this.imageExperiment,
      this.id});

  static CategoryBean fromMap(Map<String, dynamic> map) {
    CategoryBean categoryBean = new CategoryBean();
    categoryBean.title = map['title'];
    categoryBean.cssName = map['css_name'];
    categoryBean.normal = map['normal'];
    categoryBean.imageLab = map['image_lab'];
    categoryBean.imageExperiment = map['image_experiment'];
    categoryBean.id = map['id'];
    categoryBean.normalHl = map['normalHl'];
    categoryBean.whiteIcon = map['white_icon'];
    categoryBean.blackIcon = map['black_icon'];
    return categoryBean;
  }

  Map toJson() => {
        "id": id,
        "title": title,
        "normal": normal,
        "white_icon": whiteIcon,
        "black_icon": blackIcon,
      };

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

  Map toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "subscribe_status": subscribeStatus,
        "icon": icon,
        "image": image,
        "image_large": imageLarge,
        "content_provider": contentProvider,
        "show_type": showType,
        "genre": genre,
        "subscriber_num": subscriberNum,
        "post_count": postCount,
        "sort_time": sortTime,
        "column_tag": columnTag,
        "location": location,
        "share": share,
      };

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

/// url : "http://m.qdaily.com/mobile/choices/2998.html"
/// title : "你对国产动画作品了解多少，来场入门测试_好奇心日报"
/// text : "在”国漫“被反复提到的今天，回顾下那些值得一提的作品。（题图来自：iStock ©️ CSA-Printstock）"
/// image : "http://img.qdaily.com/paper/paper_show/20190911184009BeiSsgKMmcPhzlL5.jpg?imageMogr2/auto-orient/thumbnail/!1030x430r/gravity/Center/crop/1030x430/quality/85/format/jpg/ignore-error/1"

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

  Map toJson() => {
        "url": url,
        "title": title,
        "text": text,
        "image": image,
      };
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

/// id : 347086
/// content : "Chatmate，就像树洞一样互相听对方唠家常"
/// percent : 18
/// selected : false

class VoteResult {
  int id;
  String content;
  int percent;
  bool selected;

  static VoteResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VoteResult vote = VoteResult();
    vote.id = map['id'];
    vote.content = map['content'];
    vote.percent = map['percent'];
    vote.selected = map['selected'];
    return vote;
  }

  Map toJson() => {
        "id": id,
        "content": content,
        "percent": percent,
        "selected": selected,
      };
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

/// has_more : true
/// last_key : 1558479137
/// total_count : 19
/// feeds : [{"post":{"id":63961,"genre":1,"title":"央行又要降准刺激经济了，上一次刺激的效果怎么样？","author":{"id":392200,"name":null,"avatar":"http://img.qdaily.com/user/face/20190128000025sMDOJ7c5gmklZ60y.JPG?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"乐观的悲观主义者。","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"鼓励小企业贷款的政策运行了三个季度，但企业借贷意愿还没有完全恢复，经济增长仍靠地产和制造业。","publish_time":"2019-05-22 16:49:01 +0800","start_time":"","comment_count":30,"praise_count":112,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522162157zLGHwmrDxSBWTNuf.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63952,"genre":1,"title":"《阴道独白》作者推出新作，模仿曾性侵自己的父亲写下道歉","author":{"id":1588712,"name":null,"avatar":"http://img.qdaily.com/user/face/20190227165229TQecY7HFrnak4jVG.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"yiruwashere@163.com","background_image":"http://img.qdaily.com/user/background_image/20190227165634zUCl3MDwe7oAynXm.jpg?imageMogr2/auto-orient/thumbnail/!900x450r/gravity/Center/crop/900x450/ignore-error/1"},"description":"“我想很多人会花钱来听一个男人道歉，因为我们以前从未听到过。”","publish_time":"2019-05-22 14:00:11 +0800","start_time":"","comment_count":20,"praise_count":109,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/201905221134041MZiLKDAROC6WUYc.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63956,"genre":1,"title":"#Topic: 海鸥侵扰城镇，英国人试图花费数万英镑解决它","author":{"id":1523403,"name":null,"avatar":"http://img.qdaily.com/user/face/20181204213731EFnoOfAhHUemr7I9.jpeg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"yingyin.xu@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"如果海鸥擅自进入城市，造成麻烦，那么人们就没法将它当作大自然的一部分。","publish_time":"2019-05-22 14:00:05 +0800","start_time":"","comment_count":17,"praise_count":22,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522131038gqXGBAY6N7sPjHFC.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63953,"genre":1,"title":"奥利奥用 1 万多块饼干盖了座故宫，Airbnb 推出寻根之旅 | 乙方日报","author":{"id":1480589,"name":null,"avatar":"http://img.qdaily.com/user/face/20181112025537liPB0HVDsyc42uLz.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"wangjing@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"这里有营销和营销人的一切","publish_time":"2019-05-22 13:45:40 +0800","start_time":"","comment_count":9,"praise_count":29,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522122921B8VNr6TibujpvAag.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63942,"genre":1,"title":"报告称，英国政府未能解决的饥饿问题侵犯了贫困家庭人权","author":{"id":1482599,"name":null,"avatar":"http://img.qdaily.com/user/face/20181026110746RYMG9kOpFEjwo2aq.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"喜欢剧场，或者其它和剧场相似的地方","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"这份报告认为，英国自 2010 年保守党上台以来，实施了很多以紧缩为主要动机的政策，这些政策削弱了原有的福利制度。","publish_time":"2019-05-22 12:37:00 +0800","start_time":"","comment_count":10,"praise_count":38,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521231641Xosd3fIAE470rxUi.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63944,"genre":1,"title":"OMA 击败 35 个团队，赢得了芝加哥 UIC 新艺术中心的设计竞赛","author":{"id":1588271,"name":null,"avatar":"http://img.qdaily.com/user/face/20190306153744kcziIJgndl20K1ZA.PNG?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"I ","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"该中心将作为一个公共的城市表演及聚会中心，主要用于戏剧与音乐学院（STM）举办演出。","publish_time":"2019-05-22 12:36:21 +0800","start_time":"","comment_count":0,"praise_count":27,"super_tag":"","duration":null,"category":{"id":17,"title":"设计","css_name":"sheji","normal":"http://img.qdaily.com/category/icon_white/20160606004537YtoFqvLTCX3SpK16.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522014111f3zMYC59khvn0si1.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63946,"genre":1,"title":"“千克”等单位新定义生效，我们离“万世万民”的计量体系又近一步","author":{"id":856604,"name":null,"avatar":"http://img.qdaily.com/user/face/201612051100417NqCzJZI5QuOmrV8.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"霓虹国观察者","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"在人类眼中，宇宙的像素又变高了","publish_time":"2019-05-22 12:36:13 +0800","start_time":"","comment_count":22,"praise_count":180,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522013847Fkt2L9yWe3gfObuN.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63947,"genre":1,"title":"Google Glass 企业版第二代发布，支持 Android 移动设备管理","author":{"id":1480589,"name":null,"avatar":"http://img.qdaily.com/user/face/20181112025537liPB0HVDsyc42uLz.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"wangjing@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"售价 999 美元，价格比微软 HoloLens 2 低不少","publish_time":"2019-05-22 12:36:08 +0800","start_time":"","comment_count":5,"praise_count":24,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522074002iHTl19nLxJdtVrDf.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63951,"genre":1,"title":"蚯蚓入侵地球北端森林，这告诉我们哪些气候变化的信息？","author":{"id":18,"name":null,"avatar":"http://www.qdaily.com/images/missing_face.png","description":null,"background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"“即便蚯蚓很小，单独来看似乎不会构成威胁，但考虑到它们数量庞大，由此会形成非常重要的生物体，它们可能有益，也可能有害”","publish_time":"2019-05-22 12:36:03 +0800","start_time":"","comment_count":8,"praise_count":48,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522104934tIBsWoLdwGzSRarK.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63925,"genre":1,"title":"拼多多花得比挣得多，一季度净亏 19 亿元","author":{"id":1240135,"name":null,"avatar":"http://img.qdaily.com/user/face/20180117163228jL3M8xAUu4EoCgKr.jpeg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"有什么想对我说的，可以发邮件 zhangdan@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"今年一季度营销费用同比增长 3 倍，技术研发费用同比增长 8 倍。","publish_time":"2019-05-22 12:06:14 +0800","start_time":"","comment_count":10,"praise_count":26,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521152427qr4Pmv7TDnNzMjcf.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63949,"genre":27,"title":"运动剧场作品《战》，以肢体表达“人生即战场”","author":{"id":1482599,"name":null,"avatar":"http://img.qdaily.com/user/face/20181026110746RYMG9kOpFEjwo2aq.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"喜欢剧场，或者其它和剧场相似的地方","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"《战》主要展现社会生存中从未停止的追逐，以及面对压力而逐渐扭曲的人性，并希望能对客观生存境遇中的人的自身给予深切的关注。","publish_time":"2019-05-22 11:29:19 +0800","start_time":"","comment_count":0,"praise_count":4,"super_tag":"","duration":null,"category":{"id":3,"title":"娱乐","css_name":"yule","normal":"http://img.qdaily.com/category/icon_white/20160606004530eYkQ9zAdRabByinK.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522095605HrMjG6T9hExgUtdD.jpeg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":2951,"genre":1001,"title":"你觉得在社交网络上啥样的关系才算铁？","image":"http://img.qdaily.com/paper/paper_show/20190516164904Yk4TJLgZDqOnwojl.jpg?imageMogr2/auto-orient/thumbnail/!500x280r/gravity/Center/crop/500x280/ignore-error/1","description":"肯定不是“点赞之交”。（图片来源：istock ©️ roberuto）","record_count":2048,"comment_count":0,"category":{"id":2,"title":"我说","css_name":"","normal":"","image_lab":"http://img.qdaily.com/paper_category/icon_white/20160722174309beUs7l6nN5RZkEyV.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_experiment":""},"publish_time":"2019-05-22 11:00:00 +0800"},"datatype":"paper"},{"post":{"id":63948,"genre":1,"title":"今日娱乐：《六欲天》不参加戛纳电影节，起点被约谈整改","author":{"id":798625,"name":null,"avatar":"http://img.qdaily.com/user/face/20190515025459GWdxlOAQSgqX1sMo.png?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"好了你不要再说了 | tianli.gu@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"我们为你挑选了今天最重要的娱乐新闻","publish_time":"2019-05-22 10:38:32 +0800","start_time":"","comment_count":45,"praise_count":22,"super_tag":"","duration":null,"category":{"id":3,"title":"娱乐","css_name":"yule","normal":"http://img.qdaily.com/category/icon_white/20160606004530eYkQ9zAdRabByinK.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190522095241oJydhMqGuiprBZ4X.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63941,"genre":33,"title":"大公司头条：央行下调县城农商行存款准备金率，称将释放 2800 亿资金给小企业放贷；安邦在美国卖奢华酒店资产，65 亿美金买入，58 亿卖；苹果升级 MacBook，还在解决糟糕的键盘设计","author":{"id":998,"name":null,"avatar":"http://img.qdaily.com/user/face/201704112303233Kmtr2FZnCe79PRc.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"唐云路，记者。有什么想送进好奇心实验室的点子，都可以告诉她 yunlu.tang@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"我们每天早上为你摘取最重要的商业新闻，一切可能改变我们生活的公司都在其列","publish_time":"2019-05-22 09:10:01 +0800","start_time":"","comment_count":27,"praise_count":85,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521231034ANHZ0a6e3vCXt5Jp.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63933,"genre":1,"title":"#Cover：《生活大爆炸》如何让书呆子文化走入日常？","author":{"id":1389800,"name":null,"avatar":"http://img.qdaily.com/user/face/20190519025649FGyKLQ8AYZJwMR6U.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"yiyi.zhang@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"完结撒花。","publish_time":"2019-05-22 06:52:52 +0800","start_time":"","comment_count":22,"praise_count":97,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521191301aueKbl19Rh0ZfcFO.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63939,"genre":1,"title":"#Topic：男性陪产假促进生育？在西班牙结果恰恰相反","author":{"id":652712,"name":null,"avatar":"http://img.qdaily.com/user/face/20190104143727c8HC72rIQK3wGRpO.jpg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"联系请发邮件至：zhangjing@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"对很多国家来说，推行陪产假政策是促进性别平等措施的一部分，同时也是为了促进生育。","publish_time":"2019-05-22 06:52:41 +0800","start_time":"","comment_count":16,"praise_count":55,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521225926yzHToD87m43IrJKu.gif?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63928,"genre":1,"title":"火人节艺术家烧了一座寺庙雕塑，以纪念高中枪击案受害者","author":{"id":1523403,"name":null,"avatar":"http://img.qdaily.com/user/face/20181204213731EFnoOfAhHUemr7I9.jpeg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"yingyin.xu@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"人们进入寺庙，留下纸条、鲜花与照片，然后点燃它。","publish_time":"2019-05-22 06:52:33 +0800","start_time":"","comment_count":5,"praise_count":43,"super_tag":"","duration":null,"category":{"id":5,"title":"文化","css_name":"chengshi","normal":"http://img.qdaily.com/category/icon_white/20160606004532ynJMGPWumtSq2HVU.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521160308hF18irKZB3nkUXJb.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63868,"genre":1,"title":"Uber 1200 亿美元的 IPO 承诺，如何走向了破灭？","author":{"id":18,"name":null,"avatar":"http://www.qdaily.com/images/missing_face.png","description":null,"background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"尽管 Uber 通过 IPO 筹集到了 81 亿美元，并为其早期投资者和创始人带来了数十亿美元的回报，但对于这个交通巨头而言，上市本应是一个高光时刻，结果却落得十分尴尬。","publish_time":"2019-05-22 06:52:30 +0800","start_time":"","comment_count":7,"praise_count":75,"super_tag":"","duration":null,"category":{"id":18,"title":"商业","css_name":"shangye","normal":"http://img.qdaily.com/category/icon_white/20160606004538qz8vwMJLy2pAWKUi.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/201905191247231g7MIQ8oDiWvLq62.jpg?imageMogr2/auto-orient/thumbnail/!500x185r/gravity/Center/crop/500x185/ignore-error/1","type":2,"datatype":"article"},{"post":{"id":63936,"genre":1,"title":"研究发现，人工智能可以更好地在 CT 扫描中识别出肺癌","author":{"id":18,"name":null,"avatar":"http://www.qdaily.com/images/missing_face.png","description":null,"background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"“经过长时间的训练之后，我们用它从未见过的数据对它进行期末考试，结果我们也看到了，它的期末考成绩是 A。”","publish_time":"2019-05-22 06:52:29 +0800","start_time":"","comment_count":1,"praise_count":45,"super_tag":"","duration":null,"category":{"id":4,"title":"智能","css_name":"zhineng","normal":"http://img.qdaily.com/category/icon_white/20160606004531SAlEei5NBV2mnHd1.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521203750WUQ3IMocrNPm9DTl.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"},{"post":{"id":63930,"genre":1,"title":"宜家最近出了两款新 logo，都和以前没有大不同","author":{"id":1468991,"name":null,"avatar":"http://img.qdaily.com/user/face/20181013132503PYiRDtr7pzqh6fTV.jpeg?imageMogr2/auto-orient/thumbnail/!80x80r/gravity/Center/crop/80x80/ignore-error/1","description":"siyuan.ren@qdaily.com","background_image":"http://www.qdaily.com/images/author_background.jpg"},"description":"为了在电子环境中看起来更清晰、在社交网络中更好传播。","publish_time":"2019-05-22 06:52:17 +0800","start_time":"","comment_count":6,"praise_count":25,"super_tag":"","duration":null,"category":{"id":17,"title":"设计","css_name":"sheji","normal":"http://img.qdaily.com/category/icon_white/20160606004537YtoFqvLTCX3SpK16.png?imageMogr2/auto-orient/thumbnail/!128x128r/gravity/Center/crop/128x128/ignore-error/1","image_lab":"","image_experiment":""}},"image":"http://img.qdaily.com/article/article_show/20190521164251VkqHhzSvirea2UZd.jpg?imageMogr2/auto-orient/thumbnail/!245x185r/gravity/Center/crop/245x185/ignore-error/1","type":1,"datatype":"article"}]

class QdailyWebBean {
  bool hasMore;
  String lastKey;
  List<FeedsBean> feeds;
  int totalCount;
  List<ColumnBean> columns;

  static QdailyWebBean fromMap(Map<String, dynamic> map) {
    QdailyWebBean dataBean = QdailyWebBean();
    dataBean.hasMore = map['has_more'];
    dataBean.totalCount = map['total_count'];
    dataBean.lastKey = '${map['last_key']}';
    dataBean.feeds = List()
      ..addAll((map['feeds'] as List ?? []).map((o) => FeedsBean.fromMap(o)));

    dataBean.columns = List()
      ..addAll(
          (map['columns'] as List ?? []).map((o) => ColumnBean.fromMap(o)));
    return dataBean;
  }
}
