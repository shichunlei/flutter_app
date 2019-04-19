class Comment {
  /**
   * comment_ID : "4210486"
   * comment_post_ID : "21183"
   * comment_author : "fufusako"
   * comment_date : "2019-04-09 01:42:10"
   * comment_date_gmt : "2019-04-09 01:42:10"
   * comment_content : "<img src=\"https://wx2.sinaimg.cn/mw600/a7b7d1cegy1g0pop33za2j21d14nn4qq.jpg\" />"
   * user_id : "0"
   * vote_positive : "129"
   * vote_negative : "19"
   * sub_comment_count : "5"
   * text_content : ""
   * pics : ["https://wx2.sinaimg.cn/mw600/a7b7d1cegy1g0pop33za2j21d14nn4qq.jpg"]
   */

  String comment_ID;
  String comment_post_ID;
  String comment_author;
  String comment_date;
  String comment_date_gmt;
  String comment_content;
  String user_id;
  String vote_positive;
  String vote_negative;
  String sub_comment_count;
  String text_content;
  List<String> pics;

  static Comment fromMap(Map<String, dynamic> map) {
    Comment comment = Comment();
    comment.comment_ID = map['comment_ID'];
    comment.comment_post_ID = map['comment_post_ID'];
    comment.comment_author = map['comment_author'];
    comment.comment_date = map['comment_date'];
    comment.comment_date_gmt = map['comment_date_gmt'];
    comment.comment_content = map['comment_content'];
    comment.user_id = map['user_id'];
    comment.vote_positive = map['vote_positive'];
    comment.vote_negative = map['vote_negative'];
    comment.sub_comment_count = map['sub_comment_count'];
    comment.text_content = map['text_content'];

    List<dynamic> pics = map['pics'] == null ? [] : map['pics'];
    comment.pics = List();
    comment.pics.addAll(pics.map((o) => o.toString()));

    return comment;
  }

  static List<Comment> fromMapList(dynamic mapList) {
    List<Comment> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
