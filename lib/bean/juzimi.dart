class JuzimiResult {
  int totalPage;
  int currentPage;

  List<JuzimiCelebrity> celebrity;
  List<JuzimiBook> books;
  List<MeiTuMeiJu> meijus;

  JuzimiResult(this.totalPage, this.currentPage,
      {this.celebrity, this.books, this.meijus});

  @override
  String toString() {
    return '{totalPage: $totalPage, currentPage: $currentPage, celebrity: $celebrity, books: $books, meijus: $meijus}';
  }
}

class JuzimiCelebrity {
  String name;
  String image;
  String desc;

  JuzimiCelebrity({this.name, this.image, this.desc});

  @override
  String toString() {
    return '{name: $name, image: $image, desc: $desc}';
  }
}

class JuzimiBook {
  String id;
  String name;
  String image;
  String desc;
  String author;

  JuzimiBook({this.id, this.name, this.author, this.image, this.desc});

  @override
  String toString() {
    return '{"id": "$id", "name": "$name", "image": "$image", "desc": "$desc", "author": "$author"}';
  }
}

class MingjuClassify {
  /**
   * title : "原创句子"
   * classify : [{"title":"本周热门原创","tag":"original/week","id":1},{"title":"最新原创句子","tag":"original/ju","id":2},{"title":"推荐原创句子","tag":"original/recommend","id":3}]
   */

  String title;
  List<MingjuClassify> classify;

  String tag;
  int id;

  MingjuClassify({this.title, this.classify, this.tag, this.id});

  @override
  String toString() {
    return '{"title": "$title", "classify": $classify, "tag": "$tag", "id": $id}';
  }

  static MingjuClassify fromMap(Map<String, dynamic> map) {
    MingjuClassify mingjuClassify = new MingjuClassify();
    mingjuClassify.title = map['title'];
    mingjuClassify.classify = map['classify'] == null
        ? []
        : MingjuClassify.fromMapList(map['classify']);
    mingjuClassify.tag = map['tag'];
    mingjuClassify.id = map['id'];
    return mingjuClassify;
  }

  static List<MingjuClassify> fromMapList(dynamic mapList) {
    List<MingjuClassify> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class MeiTuMeiJu {
  String image; // 图片
  String desc; // 内容
  String author; // 作者
  String id; // ID
  String like; // 喜欢人数
  String source; // 出处
  String publisher; // 发布者

  MeiTuMeiJu(
      {this.image,
      this.desc,
      this.author,
      this.id,
      this.like,
      this.source,
      this.publisher});

  @override
  String toString() {
    return '{"id": "$id", "image": "$image", "desc": "$desc", "author": "$author", "source": "$source", "like": "$like", "publisher": "$publisher"}';
  }
}
