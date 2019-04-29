class JuzimiCelebrity {
  String name;
  String image;
  String desc;

  JuzimiCelebrity({this.name, this.image, this.desc});

  @override
  String toString() {
    return 'JuzimiCelebrity{name: $name, image: $image, desc: $desc}';
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
    return 'JuzimiBook{id: $id, name: $name, image: $image, desc: $desc, author: $author}';
  }
}

class MingjuClassify {
  String title;
  String tag;

  List<MingjuClassify> classify;

  MingjuClassify({this.title, this.tag, this.classify});

  @override
  String toString() {
    return '{title: $title, tag: $tag, classify: $classify}';
  }
}

class MeiTuMeiJu {
  String image;
  String desc;
  String author;
  String id;
  int like;
  String source;

  MeiTuMeiJu(
      {this.image, this.desc, this.author, this.id, this.like, this.source});

  @override
  String toString() {
    return 'MeiTuMeiJu{image: $image, desc: $desc, author: $author, id: $id, like: $like}';
  }
}
