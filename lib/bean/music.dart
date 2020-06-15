class Song {
  String id;
  String title;
  String albumArtUrl;
  String audioPath;
  String lyric;
  String artists;

  Song(
      {this.id,
      this.title,
      this.albumArtUrl,
      this.audioPath,
      this.lyric,
      this.artists});

  static Song fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Song song = Song();
    song.title = map["name"];
    song.albumArtUrl = map["album_url"];
    song.id = map["id"];
    song.audioPath = map["audio_url"];
    song.lyric = map["lyric"];
    song.artists = map["artists"];

    return song;
  }
}

class Lyric {
  String lyric;
  Duration startTime;
  Duration endTime;

  Lyric(this.lyric, {this.startTime, this.endTime});

  @override
  String toString() {
    return "{lyric: $lyric, startTime: $startTime, endTime: $endTime}";
  }
}

class MusicCategory {
  String title;
  List<SubCategoryBean> list;

  static MusicCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MusicCategory bean = MusicCategory();
    bean.title = map["title"];
    bean.list = List()
      ..addAll(
          (map["list"] as List ?? []).map((o) => SubCategoryBean.fromMap(o)));
    return bean;
  }

  Map toJson() => {
        "title": title,
        "list": list,
      };
}

class SubCategoryBean {
  int id;
  String value;
  String label;
  String desc;
  String period;
  String update;
  List<Song> list;
  String coverUrl;

  static SubCategoryBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SubCategoryBean listBean = SubCategoryBean();
    listBean.value = "${map["value"]}";
    listBean.label = map["label"];
    listBean.desc = map["intro"];
    listBean.id = map["id"];
    listBean.period = map["period"];
    listBean.update = map["update"];
    listBean.list = List()
      ..addAll((map["list"] as List ?? []).map((o) => Song.fromMap(o)));
    listBean.coverUrl = map["picUrl"];
    return listBean;
  }

  Map toJson() => {
        "value": value,
        "label": label,
        "desc": desc,
        "id": id,
        "period": period,
        "update": update,
        "list": list,
        "coverUrl": coverUrl,
      };
}
