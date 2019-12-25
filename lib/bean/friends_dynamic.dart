class FriendsDynamic {
  String username;
  String userAvatar;
  String desc;
  String address;
  String datetime;
  bool isSelf;
  int id;
  VideoBean video;
  List<ImagesListBean> images;
  List<CommentBean> comment;
  List<String> praise;

  static FriendsDynamic fromMap(Map<String, dynamic> map) {
    FriendsDynamic friends_dynamic = FriendsDynamic();
    friends_dynamic.username = map['username'];
    friends_dynamic.userAvatar = map['userAvatar'];
    friends_dynamic.desc = map['desc'];
    friends_dynamic.address = map['address'];
    friends_dynamic.datetime = map['datetime'];
    friends_dynamic.isSelf = map['isSelf'];
    friends_dynamic.id = map['id'];
    friends_dynamic.video =
        map['video'] == null ? null : VideoBean.fromMap(map['video']);
    friends_dynamic.images = List()
      ..addAll(
          (map['images'] as List ?? []).map((o) => ImagesListBean.fromMap(o)));
    friends_dynamic.comment = List()
      ..addAll(
          (map['comment'] as List ?? []).map((o) => CommentBean.fromMap(o)));
    friends_dynamic.praise = List()..addAll(
        (map['praise'] as List ?? []).map((o) => o.toString())
    );
    return friends_dynamic;
  }

  static List<FriendsDynamic> fromMapList(dynamic mapList) {
    List<FriendsDynamic> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class VideoBean {
  int id;
  String url;
  String image;

  static VideoBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    VideoBean videoBean = VideoBean();
    videoBean.id = map['id'];
    videoBean.url = map['url'];
    videoBean.image = map['image'];
    return videoBean;
  }

  Map toJson() => {
        "id": id,
        "url": url,
        "image": image,
      };
}

class ImagesListBean {
  String image;
  int id;

  static ImagesListBean fromMap(Map<String, dynamic> map) {
    ImagesListBean imagesListBean = ImagesListBean();
    imagesListBean.image = map['image'];
    imagesListBean.id = map['id'];
    return imagesListBean;
  }

  static List<ImagesListBean> fromMapList(dynamic mapList) {
    List<ImagesListBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class CommentBean {
  bool source;
  String fromUser;
  String toUser;
  String content;

  static CommentBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CommentBean commentBean = CommentBean();
    commentBean.source = map['source'];
    commentBean.fromUser = map['fromUser'];
    commentBean.toUser = map['toUser'];
    commentBean.content = map['content'];
    return commentBean;
  }

  Map toJson() => {
        "source": source,
        "fromUser": fromUser,
        "toUser": toUser,
        "content": content,
      };
}
