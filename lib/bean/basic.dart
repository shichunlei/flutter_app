class Basic {
  /// 地区／城市ID
  String cid;

  /// 地区／城市名称
  String location;

  /// 该地区／城市的上级城市
  String parent_city;

  /// 该地区／城市所属行政区域
  String admin_area;

  /// 该地区／城市所属国家名称
  String cnty;

  /// 地区／城市纬度
  String lat;

  /// 地区／城市经度
  String lon;

  /// 该地区／城市所在时区
  String tz;

  ///
  String type;

  static Basic fromMap(Map<String, dynamic> map) {
    Basic basicListBean = Basic();
    basicListBean.cid = map['cid'];
    basicListBean.location = map['location'];
    basicListBean.parent_city = map['parent_city'];
    basicListBean.admin_area = map['admin_area'];
    basicListBean.cnty = map['cnty'];
    basicListBean.lat = map['lat'];
    basicListBean.lon = map['lon'];
    basicListBean.tz = map['tz'];
    basicListBean.type = map['type'];
    return basicListBean;
  }

  static List<Basic> fromMapList(dynamic mapList) {
    List<Basic> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
