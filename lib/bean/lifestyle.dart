class Lifestyle {
  /***
   * 生活指数类型
   *
   * comf：舒适度指数
   * cw：洗车指数
   * drsg：穿衣指数
   * flu：感冒指数
   * sport：运动指数
   * trav：旅游指数
   * uv：紫外线指数
   * air：空气污染扩散条件指数
   * ac：空调开启指数
   * ag：过敏指数
   * gl：太阳镜指数
   * mu：化妆指数
   * airc：晾晒指数
   * ptfc：交通指数
   * fsh：钓鱼指数
   * spi：防晒指数
   */
  String type;

  /// 生活指数简介
  String brf;

  /// 生活指数详细描述
  String txt;

  /// 预报日期，例如2017-12-30
  String date;

  static Lifestyle fromMap(Map<String, dynamic> map) {
    Lifestyle lifestyle = Lifestyle();
    String life_style = '';
    switch (map['type']) {
      case 'comf':
        life_style = '舒适度指数';
        break;
      case 'cw':
        life_style = '洗车指数';
        break;
      case 'drsg':
        life_style = '穿衣指数';
        break;
      case 'flu':
        life_style = '感冒指数';
        break;
      case 'sport':
        life_style = '运动指数';
        break;
      case 'trav':
        life_style = '旅游指数';
        break;
      case 'uv':
        life_style = '紫外线指数';
        break;
      case 'air':
        life_style = '空气污染扩散条件指数';
        break;
      case 'ac':
        life_style = '空调开启指数';
        break;
      case 'ag':
        life_style = '过敏指数';
        break;
      case 'gl':
        life_style = '太阳镜指数';
        break;
      case 'mu':
        life_style = '化妆指数';
        break;
      case 'airc':
        life_style = '晾晒指数';
        break;
      case 'ptfc':
        life_style = '交通指数';
        break;
      case 'fsh':
        life_style = '钓鱼指数';
        break;
      case 'spi':
        life_style = '防晒指数';
        break;
      default:
        break;
    }
    lifestyle.type = life_style;
    lifestyle.brf = map['brf'];
    lifestyle.txt = map['txt'];
    lifestyle.date = map['date'];
    return lifestyle;
  }

  static List<Lifestyle> fromMapList(dynamic mapList) {
    List<Lifestyle> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
