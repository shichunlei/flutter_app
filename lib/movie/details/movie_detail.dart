import 'dart:convert';

class MovieDetail {
  final String title;
  final double average;
  final int collectCount;
  final String smallImage;
  final String director;
  final String cast;
  final String movieId;
  final String summary;

  //构造函数
  MovieDetail({
    this.title,
    this.average,
    this.collectCount,
    this.smallImage,
    this.director,
    this.cast,
    this.movieId,
    this.summary,
  });

  static MovieDetail decodeData(String jsonData) {
    var data = json.decode(jsonData);
    return fromMap(data);
  }

  static MovieDetail fromMap(Map map) {
    List directors = map['directors'];
    List casts = map['casts'];
    var d = '';
    for (int i = 0; i < directors.length; i++) {
      if (i == 0) {
        d = d + directors[i]['name'];
      } else {
        d = d + '/' + directors[i]['name'];
      }
    }
    var c = '';
    for (int i = 0; i < casts.length; i++) {
      if (i == 0) {
        c = c + casts[i]['name'];
      } else {
        c = c + '/' + casts[i]['name'];
      }
    }
    return new MovieDetail(
      title: map['title'],
      average: map['rating']['average'] == 0 ? 0.0 : map['rating']['average'],
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
      summary: map['summary'],
    );
  }
}
