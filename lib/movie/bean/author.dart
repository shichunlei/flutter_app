class Author {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  static Author fromMap(Map<String, dynamic> map) {
    Author author = Author();
    author.uid = map['uid'];
    author.avatar = map['avatar'];
    author.signature = map['signature'];
    author.alt = map['alt'];
    author.id = map['id'];
    author.name = map['name'];
    return author;
  }

  static List<Author> fromMapList(dynamic mapList) {
    List<Author> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{uid: $uid, avatar: $avatar, signature: $signature, alt: $alt, id: $id, name: $name}';
  }
}
