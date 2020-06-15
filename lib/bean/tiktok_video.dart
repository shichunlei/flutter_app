/// hotindex : 8403872
/// createtime : 1583755733
/// duration : 28560
/// playaddr : "https://aweme.snssdk.com/aweme/v1/playwm/?video_id=v0200f9a0000bpj33jl7gl1qf7rrdea0&line=0&ratio=540p&media_type=4&vr_type=0&improve_bitrate=0&is_play_url=1&is_support_h265=0&source=PackSourceEnum_FOLLOW_FEED"
/// coverurl : "https://p3-dy.byteimg.com/img/tos-cn-p-0015/e3f41d26dcb841259f13ac1e15d842a9~c5_300x400.jpeg?from=2563711402_large"
/// title : "？？？？？？？"
/// shareurl : "https://www.iesdouyin.com/share/video/6802179074182696207/?region=&mid=6802175027179129614&u_code=0&titleType=title"
/// author : "火线妹"
/// signature : "商务v❤️821015347\n粉丝群769510007\n\n只有这一个抖音账号，其他都不是本人！！"
/// avatar : "https://p3-dy.byteimg.com/aweme/100x100/2dd9c0005995c9a9cbca3.jpeg"

class TiktokVideo {
  int hotIndex; // 热榜指数

  int createTime; //发布时间戳

  int duration; //视频时长秒数

  String playAddr; //播放地址

  String coverUrl; //视频封面

  String title; //视频标题简介

  String shareUrl; //抖音分享地址

  String author; //作者抖音昵称

  String signature; //作者抖音个人签名

  String avatar; //作者抖音头像

  static TiktokVideo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TiktokVideo dyVideoBean = TiktokVideo();
    dyVideoBean.hotIndex = map['hotindex'];
    dyVideoBean.createTime = map['createtime'];
    dyVideoBean.duration = map['duration'];
    dyVideoBean.playAddr = map['playaddr'];
    dyVideoBean.coverUrl = map['coverurl'];
    dyVideoBean.title = map['title'];
    dyVideoBean.shareUrl = map['shareurl'];
    dyVideoBean.author = map['author'];
    dyVideoBean.signature = map['signature'];
    dyVideoBean.avatar = map['avatar'];
    return dyVideoBean;
  }

  Map toJson() => {
        "hotindex": hotIndex,
        "createtime": createTime,
        "duration": duration,
        "playaddr": playAddr,
        "coverurl": coverUrl,
        "title": title,
        "shareurl": shareUrl,
        "author": author,
        "signature": signature,
        "avatar": avatar,
      };
}
