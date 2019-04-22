class Article {
  /**
   * author : "玛丽安·麦肯译"
   * title : "静下来"
   * digest : "我用手电筒照亮庭院里的池塘。平铺如一片地毯的浮萍，几乎覆盖了整池水面，池水静止、平滑、青绿，犹如一座高尔夫球场，只有一株水芹菜的羽状叶这里一"
   * content : "<p>我用手电筒照亮庭院里的池塘。平铺如一片地毯的浮萍，几乎覆盖了整池水面，池水静止、平滑、青绿，犹如一座高尔夫球场，只有一株水芹菜的羽状叶这里一点那里一块，将池面的完整划破。手电筒的光线照见了一对对眼睛，正好露在水平面上，小小的脸，一丝不动且肃穆庄严，藏在萍叶下，像戴着俏皮的小帽。</p><p>我继续用手电简的光线锁定它们，它们依然动也不动，眼睛眨都不眨。我站的地方距离它们太远，看不清它们的喉咙由于呼吸而引发的动态。我不确定这些青蛙快不快乐。它们的眼睛不眨，它们的小脸神秘难解。它们安安静静，耐心平和地坐着，像安静的禅师，内心宁静、悠然自得。</p><p>聪明的人类，有着花样繁多的食物和对宇宙的征服力，我们不需要傻傻地坐在那里守株待免等待一只飞过的蚊子，我们把时间用来等待下一个令人惊奇的科技呼啸而过，用来发明不同的新鲜事物和新鲜玩法，就像踩着一台永不停止的跑步机，思考的时间愈来愈长，血拼愈来愈疯狂，“拥有”的东西越来越多，却看起来愈来愈憔悴，越来越不快乐。</p><p>简单生活的意思纯粹只是：相较于现在，给自己更多梦想和沉吟的时间，以及更多品闻玫瑰的时间，就像青蛙之于池塘，和谐静谧，动静皆宜。简单并不是舍弃所有，简单不过是学会在现有的旧事物上拥抱新的快乐罢了。</p>"
   * wc : 514
   */

  String author;
  String title;
  String digest;
  String content;
  int wc;
  DateBean date;

  int id;
  String curr;

  static Article fromMap(Map<String, dynamic> map) {
    Article article = new Article();
    article.author = map['author'];
    article.title = map['title'];
    article.digest = map['digest'];
    article.content = map['content'];
    article.wc = map['wc'];
    article.date = DateBean.fromMap(map['date']);

    article.curr = DateBean.fromMap(map['date']).curr;
    return article;
  }

  static Article fromJson(Map<String, dynamic> map) {
    Article article = new Article();
    article.id = map['_id'];
    article.author = map['author'];
    article.title = map['title'];
    article.digest = map['digest'];
    article.curr = map['date'];
    return article;
  }

  Map<String, dynamic> toMap() => {
        'author': author,
        'title': title,
        'digest': digest,
        'date': date.curr,
      };

  static List<Article> fromMapList(dynamic mapList) {
    List<Article> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return 'Article{author: $author, title: $title, digest: $digest, content: $content, wc: $wc, date: $date, id: $id, curr: $curr}';
  }
}

class DateBean {
  String curr;
  String prev;
  String next;

  static DateBean fromMap(Map<String, dynamic> map) {
    DateBean date = new DateBean();
    date.curr = map['curr'];
    date.prev = map['prev'];
    date.next = map['next'];
    return date;
  }

  static List<DateBean> fromMapList(dynamic mapList) {
    List<DateBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
