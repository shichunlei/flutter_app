class FriendsDynamic {
  /**
   * username : "张三"
   * userAvatar : "http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg"
   * desc : "这里是文字描述"
   * address : "北京"
   * datetime : "2019-01-01 23:11:23"
   * isSelf : true
   * share : null
   * id : 1
   * video : {"id":1,"url":"","image":"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2267040693,3719567402&fm=27&gp=0.jpg"}
   * images : [{"id":1,"image":"https://www.7160.com/templets/new7160/hotpic/2/s.jpg"}]
   * comment : []
   */

  String username;
  String userAvatar;
  String desc;
  String address;
  String datetime;
  bool isSelf;
  int id;
  VideoBean video;
  List<ImagesListBean> images;

  static FriendsDynamic fromMap(Map<String, dynamic> map) {
    FriendsDynamic friends_dynamic = new FriendsDynamic();
    friends_dynamic.username = map['username'];
    friends_dynamic.userAvatar = map['userAvatar'];
    friends_dynamic.desc = map['desc'];
    friends_dynamic.address = map['address'];
    friends_dynamic.datetime = map['datetime'];
    friends_dynamic.isSelf = map['isSelf'];
    friends_dynamic.id = map['id'];
    friends_dynamic.video =
        map['video'] == null ? null : VideoBean.fromMap(map['video']);
    friends_dynamic.images =
        map['images'] == null ? [] : ImagesListBean.fromMapList(map['images']);
    return friends_dynamic;
  }

  static List<FriendsDynamic> fromMapList(dynamic mapList) {
    List<FriendsDynamic> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class VideoBean {
  /**
   * url : ""
   * image : "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2267040693,3719567402&fm=27&gp=0.jpg"
   * id : 1
   */

  String url;
  String image;
  int id;

  static VideoBean fromMap(Map<String, dynamic> map) {
    VideoBean videoBean = new VideoBean();
    videoBean.url = map['url'];
    videoBean.image = map['image'];
    videoBean.id = map['id'];
    return videoBean;
  }

  static List<VideoBean> fromMapList(dynamic mapList) {
    List<VideoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class ImagesListBean {
  /**
   * image : "https://www.7160.com/templets/new7160/hotpic/2/s.jpg"
   * id : 1
   */

  String image;
  int id;

  static ImagesListBean fromMap(Map<String, dynamic> map) {
    ImagesListBean imagesListBean = new ImagesListBean();
    imagesListBean.image = map['image'];
    imagesListBean.id = map['id'];
    return imagesListBean;
  }

  static List<ImagesListBean> fromMapList(dynamic mapList) {
    List<ImagesListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
