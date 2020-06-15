/// id : 468
/// hitokoto : "Yesterday is a history, tomorrow is a mystery, but today is a gift."
/// type : "g"
/// from : "功夫熊猫"
/// creator : "efreet"
/// created_at : "1468950839"

class Hitokoto {
  /// 本条一言的id。
  int id;

  /// 一言正文。编码方式unicode。使用utf-8。
  String hitokoto;

  ///  类型
  ///  a	Anime - 动画
  ///  b	Comic – 漫画
  ///  c	Game – 游戏
  ///  d	Novel – 小说
  ///  e	Myself – 原创
  ///  f	Internet – 来自网络
  ///  g	Other – 其他
  String type;

  /// 一言的出处。
  String from;

  /// 添加者。
  String creator;

  /// 添加时间。
  String createdAt;

  static Hitokoto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Hitokoto hitokoto = Hitokoto();
    hitokoto.id = map['id'];
    hitokoto.hitokoto = map['hitokoto'];
    hitokoto.type = map['type'];
    hitokoto.from = map['from'];
    hitokoto.creator = map['creator'];
    hitokoto.createdAt = map['created_at'];
    return hitokoto;
  }

  Map toJson() => {
        "id": id,
        "hitokoto": hitokoto,
        "type": type,
        "from": from,
        "creator": creator,
        "created_at": createdAt,
      };
}
