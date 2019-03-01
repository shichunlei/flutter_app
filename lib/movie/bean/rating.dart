class Rating {
  int max;
  num value;
  int min;
  num average;
  String stars;
  Details details;

  static Rating fromMap(Map<String, dynamic> map) {
    Rating ratingBean = Rating();
    ratingBean.max = map['max'];
    ratingBean.value = map['value'] == null ? -1 : map['value'];
    ratingBean.min = map['min'];
    ratingBean.stars = map['stars'] == null ? "" : map['stars'];
    ratingBean.average = map['average'] == null ? 0 : map['average'];
    ratingBean.details =
        map['details'] == null ? null : Details.fromMap(map['details']);
    return ratingBean;
  }

  static List<Rating> fromMapList(dynamic mapList) {
    List<Rating> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Rating{max: $max, value: $value, min: $min, average: $average, stars: $stars, details: $details}';
  }
}

class Details {
  var star1;
  var star2;
  var star3;
  var star4;
  var star5;

  static Details fromMap(Map<String, dynamic> map) {
    Details detailsBean = Details();
    detailsBean.star1 = map['1'];
    detailsBean.star2 = map['2'];
    detailsBean.star3 = map['3'];
    detailsBean.star4 = map['4'];
    detailsBean.star5 = map['5'];
    return detailsBean;
  }

  static List<Details> fromMapList(dynamic mapList) {
    List<Details> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{star1: $star1, star2: $star2, star3: $star3, star4: $star4, star5: $star5}';
  }
}
