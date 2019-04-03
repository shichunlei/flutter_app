class Poetry {
  /**
   * title : "晓起"
   * content : "落月光微暝霭收，一轩潇洒旅怀幽。|湘君山外波涛晓，麋子城边草木秋。|俗吏区区易情倦，古人皦皦志空求。|且希月廪从官给，仰事孤亲洁膳羞。"
   * authors : "韦骧"
   */

  String title;
  String content;
  String authors;

  static Poetry fromMap(Map<String, dynamic> map) {
    String content = "";

    Poetry poetry = Poetry();
    poetry.title = map['title'];

    List<String> con = map['content'] == null ? [] : map['content'].split('|');
    for (int i = 0; i < con.length; i++) {
      content += con[i].toString() + "\n\n";
    }
    poetry.content = content;
    poetry.authors = map['authors'];
    return poetry;
  }

  static List<Poetry> fromMapList(dynamic mapList) {
    List<Poetry> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
