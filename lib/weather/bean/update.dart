class UpdateBean {
  /// 当地时间，24小时制，格式yyyy-MM-dd HH:mm
  String loc;

  /// UTC时间，24小时制，格式yyyy-MM-dd HH:mm
  String utc;

  static UpdateBean fromMap(Map<String, dynamic> map) {
    UpdateBean updateBean = UpdateBean();
    updateBean.loc = map['loc'];
    updateBean.utc = map['utc'];
    return updateBean;
  }

  static List<UpdateBean> fromMapList(dynamic mapList) {
    List<UpdateBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}