class News {
  String title;
  String cover;
  String summary;
  String link;

  News(this.title, this.cover, this.summary, this.link);

  News.fromJson(Map data) {
    title = data['title'];
    summary = data['summary'];
    cover = data['cover'];
    link = data['link'];
  }

  @override
  String toString() {
    return '{title: $title, cover: $cover, summary: $summary, link: $link}';
  }
}
