class Poetry {
  /**
   * message : "成功!"
   * code : 200
   * result : {"title":"晓起","content":"落月光微暝霭收，一轩潇洒旅怀幽。|湘君山外波涛晓，麋子城边草木秋。|俗吏区区易情倦，古人皦皦志空求。|且希月廪从官给，仰事孤亲洁膳羞。","authors":"韦骧"}
   */

  String message;
  int code;
  Result result;

  static Poetry fromMap(Map<String, dynamic> map) {
    Poetry poetry = Poetry();
    poetry.message = map['message'];
    poetry.code = map['code'];
    poetry.result =
        map['result'] == null ? null : Result.fromMap(map['result']);
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

class Result {
  /**
   * title : "晓起"
   * content : "落月光微暝霭收，一轩潇洒旅怀幽。|湘君山外波涛晓，麋子城边草木秋。|俗吏区区易情倦，古人皦皦志空求。|且希月廪从官给，仰事孤亲洁膳羞。"
   * authors : "韦骧"
   */

  String title;
  String content;
  String authors;

  static Result fromMap(Map<String, dynamic> map) {
    String content = "";

    Result result = Result();
    result.title = map['title'];

    List<String> con = map['content'] == null ? [] : map['content'].split('|');
    for (int i = 0; i < con.length; i++) {
      content += con[i].toString() + "\n\n";
    }
    result.content = content;
    result.authors = map['authors'];
    return result;
  }

  static List<Result> fromMapList(dynamic mapList) {
    List<Result> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
