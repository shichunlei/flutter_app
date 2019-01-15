import 'dart:convert';

class Movie {
  final String title;
  final String average;
  final int collectCount;
  final String smallImage;
  final String director;
  final String cast;
  final String movieId;

  // 构造函数
  Movie(
      {this.title,
      this.average,
      this.collectCount,
      this.smallImage,
      this.director,
      this.cast,
      this.movieId});

  static List<Movie> decodeData(jsonData) {
    List<Movie> movies = new List<Movie>();

    var results = jsonData['subjects'];
    for (int i = 0; i < results.length; i++) {
      movies.add(fromMap(results[i]));
    }
    return movies;
  }

  static Movie fromMap(Map map) {
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

    return new Movie(
      title: map['title'],
      average: map['rating']['average'].toString(),
      collectCount: map['collect_count'],
      smallImage: map['images']['small'],
      director: d,
      cast: c,
      movieId: map['id'],
    );
  }
}
