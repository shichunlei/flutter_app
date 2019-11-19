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
